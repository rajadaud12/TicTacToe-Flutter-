
import 'package:flutter/material.dart';
import 'package:tictactoe/AudioManager.dart';
import 'package:tictactoe/gameModeSeleciton.dart';
import 'package:tictactoe/homePage.dart';
import 'package:tictactoe/toss.dart';
import 'game.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  AudioManager.aizen();
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/gameMode':(context)=>GameModeSelection(),
      '/human':(context)=>HumanGame(),
      '/home': (context)=>HomePage(),
      '/toss':(context)=>TossScreen(),
    },
  ));
}