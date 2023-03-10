import 'package:flutter/material.dart';
import 'package:tictoe/provider/room_data_provider.dart';
import 'package:tictoe/screens/create_room_screen.dart';
import 'package:tictoe/screens/gameScreen.dart';
import 'package:tictoe/screens/join_room_screen.dart';
import 'package:tictoe/screens/main_menu.dart';
import 'package:tictoe/utils/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context)=> RoomDataProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
        ),
        routes: {
          MainMenuScreen.routeName: (context) => const MainMenuScreen(),
          CreateRoom.routeName: (context) => const CreateRoom(),
          JoinRoom.routeName: (context) => const JoinRoom(),
          GameScreen.rountName:(context)=> const GameScreen(),
        },
        initialRoute:  MainMenuScreen.routeName,
      ),
    );
  }
}
