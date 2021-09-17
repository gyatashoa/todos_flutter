import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todos/add Task.dart';
import 'package:todos/home.dart';
import 'package:todos/loading.dart';
import 'package:todos/models/taskModel.dart';
import 'package:todos/providers/task_provider.dart';

//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//final  FlutterBitmapAssetAndroidIcon flutterLocalNotificatificationPlugin =
//flutterLocalNotificatificationPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<HiveTaskModel>(HiveTaskModelAdapter());

  /*var initializationSettingsAndroid = AndroidInitializationSettings(
      'codex_logo');
  var initializationSettings =InitializationSettings(
    android: initializationSettingsAndroid
  );
  await flutterLocalNotificatificationPlugin.icon;*/

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<TasksProvider>(create: (_) => TasksProvider())
    ],
    child: MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/home': (context) => Home(),
        '/task': (context) => AddTask(),
      },
    ),
  ));
}
