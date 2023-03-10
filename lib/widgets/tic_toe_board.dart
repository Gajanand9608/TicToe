import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictoe/provider/room_data_provider.dart';
import 'package:tictoe/resources/socket_methods.dart';

class TicToeBoard extends StatefulWidget {
  const TicToeBoard({super.key});

  @override
  State<TicToeBoard> createState() => _TicToeBoardState();
}

class _TicToeBoardState extends State<TicToeBoard> {
  final SocketMethods _socketMethods = SocketMethods();

  void tapped(int index, RoomDataProvider roomDataProvider) {
    _socketMethods.tapGrid(roomDataProvider.roomData['_id'], index,
        roomDataProvider.displayElements);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _socketMethods.tappedListener(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.7,
        maxWidth: 400,
      ),
      child: AbsorbPointer(
        absorbing: roomDataProvider.roomData['turn']['socketID'] !=
            _socketMethods.socketClient.id,
        child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, index) {
            return GestureDetector(
              onTap: () => tapped(index, roomDataProvider),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white24,
                  ),
                ),
                child: Center(
                    child: AnimatedSize(
                  duration: Duration(milliseconds: 200),
                  child: Text(
                    roomDataProvider.displayElements[index],
                    style: TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 40,
                          color: roomDataProvider.displayElements[index] == 'O'
                              ? Colors.red
                              : Colors.blue,
                        ),
                      ],
                    ),
                  ),
                )),
              ),
            );
          },
        ),
      ),
    );
  }
}
