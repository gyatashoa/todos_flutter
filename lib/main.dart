import 'package:flutter/material.dart';
import 'package:todos/add Task.dart';
import 'package:todos/home.dart';
import 'package:todos/loading.dart';

//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//final  FlutterBitmapAssetAndroidIcon flutterLocalNotificatificationPlugin =
//flutterLocalNotificatificationPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /*var initializationSettingsAndroid = AndroidInitializationSettings(
      'codex_logo');
  var initializationSettings =InitializationSettings(
    android: initializationSettingsAndroid
  );
  await flutterLocalNotificatificationPlugin.icon;*/

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Splash(),
      '/home': (context) => Home(),
      '/task': (context) => AddTask(),
    },
  ));
}
