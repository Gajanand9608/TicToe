import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictoe/provider/room_data_provider.dart';
import 'package:tictoe/resources/socket_methods.dart';
import 'package:tictoe/views/score_board.dart';
import 'package:tictoe/views/waiting_lobby.dart';
import 'package:tictoe/widgets/tic_toe_board.dart';

class GameScreen extends StatefulWidget {
  static const rountName = '/game-screen';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayerStateListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);

  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
      body: roomDataProvider.roomData['isJoin']
          ? const WaitingLobby()
          : Center(
              child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const ScoreBoard(),
                  const TicToeBoard(),
                  Text('${roomDataProvider.roomData['turn']['nickname']}\'s '
                      'turn'),
                ],
              ),
            )),
    );
  }
}
