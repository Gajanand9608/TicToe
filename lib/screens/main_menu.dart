import 'package:flutter/material.dart';
import 'package:tictoe/responsive/responsive.dart';
import 'package:tictoe/screens/create_room_screen.dart';
import 'package:tictoe/screens/join_room_screen.dart';
import 'package:tictoe/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  static const routeName = '/main-menu';
  const MainMenuScreen({super.key});

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoom.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoom.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(onTap: () => createRoom(context), text: 'Create Room'),
            const SizedBox(
              height: 20,
            ),
            CustomButton(onTap: ()=> joinRoom(context), text: 'Join Room'),
          ],
        ),
      ),
    );
  }
}
