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
    if (task == "GET Location") {
      try {
        Position currentPosition = await Geolocator.getCurrentPosition();

        var dataModel = DataModel(
          lat: currentPosition.latitude,
          lon: currentPosition.longitude,
          dateTime: DateTime.now().toString(),
        );
        await DataRepository().insertToDb(dataModel);
        // for (int i = 0; i <= 150; i++) {
        //   await DataRepository().insertToDb(dataModel);
        // }
      } catch (err) {
        Logger().e(err.toString());
        throw Exception(err);
      }
      return Future.value(true);
    } else if (task == "NEW COUNTER TASK") {
      debugPrint(
          "=====================NEW Task Starts==============================");
      int newValue = 0;
      for (int i = 0; i <= 10; i++) {
        newValue == i;
        debugPrint(newValue.toString());
      }
      return Future.value(true);
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
