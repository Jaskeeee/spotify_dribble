import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_dribble/core/app.dart';

void main()async{
 WidgetsFlutterBinding.ensureInitialized(); 
 try{
  await dotenv.load(fileName:".env");
 }catch(e){
  throw Exception("Failed to load .env file: $e");
 }
 Process.run('systemctl',['--user','start','spotifyd.service']);
 runApp(App());
 doWhenWindowReady((){
    const initialSize = Size(600, 450);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.startDragging();
    appWindow.show();
    appWindow.maximize();
 });
}