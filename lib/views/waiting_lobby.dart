import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictoe/provider/room_data_provider.dart';
import 'package:tictoe/widgets/custom_text_field.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {

  TextEditingController _controller = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text= Provider.of<RoomDataProvider>(context,listen: false).roomData['_id'];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Waiting for the player to join...'),
        const SizedBox(height: 20,),
        CustomTextField(controller: _controller, hintText: '', isReadOnly: true,)
    ],);
  }
}