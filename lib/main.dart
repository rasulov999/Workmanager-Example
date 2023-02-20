import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:workmanager/workmanager.dart';
import 'package:workmanager_tutorial/data/models/data_model.dart';
import 'package:workmanager_tutorial/data/repository/data_repository.dart';
import 'package:workmanager_tutorial/view/screens/workmanager_example_screen.dart';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    Location location = Location();
    LocationData locationData;
   // Future.delayed(const Duration(seconds: 1));
    locationData = await location.getLocation();
    await DataRepository().insertToDb(DataModel(
        lat: locationData.latitude.toString(),
        lon: locationData.longitude.toString(),
        dateTime: DateTime.now().toString()));
    location.enableBackgroundMode(enable: true);
    debugPrint(
        "===================================${locationData.latitude}============================");
   
    

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerPeriodicTask("task-identifier", "simpleTask",initialDelay: Duration(seconds: 5));
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
