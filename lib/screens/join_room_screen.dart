import 'package:flutter/material.dart';
import 'package:tictoe/resources/socket_methods.dart';
import 'package:tictoe/responsive/responsive.dart';
import 'package:tictoe/widgets/custom_button.dart';
import 'package:tictoe/widgets/custom_text.dart';
import 'package:tictoe/widgets/custom_text_field.dart';

class JoinRoom extends StatefulWidget {
  static const routeName = '/join-room';

  const JoinRoom({super.key});

  @override
  State<JoinRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<JoinRoom> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();
  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccuredListener(context);
    _socketMethods.updatePlayerStateListener(context);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _gameIdController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Responsive(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                shadows: [
                  Shadow(
                    color: Colors.blue,
                    blurRadius: 40,
                  ),
                ],
                text: "Join Room",
                fontSize: 70,
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomTextField(
                  controller: _nameController, hintText: 'Enter you nickname',),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: _gameIdController, hintText: 'Enter your GameID',),
              SizedBox(
                height: size.height * 0.045,
              ),
              CustomButton(onTap: () => _socketMethods.joinRoom(_nameController.text, _gameIdController.text), text: 'Join',),
            ],
          ),
        ),
      ),
    );
  }
}
