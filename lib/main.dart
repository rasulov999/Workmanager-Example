import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:workmanager/workmanager.dart';
import 'package:workmanager_tutorial/data/models/data_model.dart';
import 'package:workmanager_tutorial/data/repository/data_repository.dart';
import 'package:workmanager_tutorial/view/screens/workmanager_example_screen.dart';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      Position currentPosition = await Geolocator.getCurrentPosition();
      await DataRepository().insertToDb(
        DataModel(
          lat: currentPosition.latitude,
          lon: currentPosition.longitude,
          dateTime: DateTime.now().toString(),
        ),
      );
    } catch (err) {
      Logger().e(err.toString());
      throw Exception(err);
    }

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WorkmanagerExampleScreen(),
    );
  }
}
