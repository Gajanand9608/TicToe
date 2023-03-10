const express = require('express');
const http = require('http');
const Mongoose = require('mongoose');
const app = express();
const port = process.env.PORT || 3000;

var server  = http.createServer(app);
var socketio = require("socket.io");
const Room = require('./models/room');
var io = socketio(server);

//middleware

app.use(express.json());
const DB="";

io.on("connection",(socket)=>{
    console.log("connected!");
    socket.on("createRoom", async ({nickname})=>{
        console.log(nickname);
        // player is created and stored in the room
        try{
            let room = new Room();
            let player = {
                socketID:socket.id,
                nickname:nickname,
                playerType:"X",
                };
            room.players.push(player);
            room.turn = player;
            room = await room.save();
            console.log(room);
            const roomId = room._id.toString();
            socket.join(roomId);
            //  tell our client that room has been created 
            // go to next page
            // io -> sending data to everyone
            // socket -> sending data to yourself
            io.to(roomId).emit("createRoomSuccess", room);
        }catch (e){
            console.log(e);
        }
    });

    socket.on("joinRoom", async ({nickname, roomId})=>{
        try{
            if(!roomId.match(/^[0-9a-fA-F]{24}$/)){
                socket.emit('errorOccured','Please enter a valid room Id.');
                return;
            }
            let room = await Room.findById(roomId);
            console.log('here');
            console.log(room);
            if(room.isJoin){
                let player = {
                socketID:socket.id,
                nickname:nickname,
                playerType:"O",
                }
                socket.join(roomId);
                room.players.push(player);
                room.isJoin=false;
                room = await room.save();
                io.to(roomId).emit("joinRoomSuccess", room);
                io.to(roomId).emit("updatePlayers",room.players);
                io.to(roomId).emit("updateRoom",room);
            }else{
                socket.emit('errorOccured','Th game is in progress, try again later.');
                return;
            }

        }catch(e){
            console.log(e);
        }
    });

    socket.on("tap", async({index, roomId})=>{
        try{
           let room =  await Room.findById(roomId);
           let choice = room.turn.playerType;
           if(room.turnIndex==0){
            room.turnIndex =1;
            room.turn = room.players[1];
           }else{
            room.turnIndex =0;
            room.turn = room.players[0];
           }
           room = await room.save();
           io.to(roomId).emit("tapped",{
            index, choice, room
           });
        }catch(e){
            console.log(e);
        }
    });

    socket.on('winner', async({winnerSocketId,roomId}) => {
        try{
            let room = await Room.findById(roomId);
           let player = room.players.find((playerr)=> playerr.socketID == winnerSocketId);
           player.points+=1;
           room = await room.save();
           if(player.points>=room.maxRounds){
            io.to(roomId).emit('endGame', player);
           }else{
            io.to(roomId).emit('pointIncrease', player);
           }
        }catch(e){
            console.log(e);

        }
    });
});

Mongoose.connect(DB).then(()=>{
    console.log('Connection successful!');
}).catch((e)=>{
    console.log(e);
});

server.listen(port,"0.0.0.0",()=>{
    console.log(`server has been started on ${port}`);
});

