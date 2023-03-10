import 'package:flutter/material.dart';
import 'package:tictoe/resources/socket_methods.dart';
import 'package:tictoe/responsive/responsive.dart';
import 'package:tictoe/widgets/custom_button.dart';
import 'package:tictoe/widgets/custom_text.dart';
import 'package:tictoe/widgets/custom_text_field.dart';

class CreateRoom extends StatefulWidget {
  static const routeName = '/create-room';
  const CreateRoom({super.key});

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final TextEditingController controller = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
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
                text: "Create Room",
                fontSize: 70,
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomTextField(
                controller: controller,
                hintText: 'Enter your ninkname',
              ),
              SizedBox(
                height: size.height * 0.045,
              ),
              CustomButton(
                  onTap: () => _socketMethods.createRoom(controller.text),
                  text: 'Create'),
            ],
          ),
        ),
      ),
    );
  }
}
