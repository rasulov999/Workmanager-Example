import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:workmanager/workmanager.dart';
import 'package:workmanager_tutorial/data/models/data_model.dart';
import 'package:workmanager_tutorial/data/repository/data_repository.dart';

class WorkmanagerExampleScreen extends StatefulWidget {
  const WorkmanagerExampleScreen({super.key});

  @override
  State<WorkmanagerExampleScreen> createState() =>
      _WorkmanagerExampleScreenState();
}

class _WorkmanagerExampleScreenState extends State<WorkmanagerExampleScreen> {
  @override
  void initState() {
    askLocationPermission();
    super.initState();
  }

  askLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    Workmanager().registerOneOffTask(
      "task-identifier",
      "GET Location",
      // frequency: const Duration(minutes: 16)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workmanager Example"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Workmanager()
                  .registerOneOffTask("task-identifier", "NEW COUNTER TASK");
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: DataRepository().getDatalist().asStream(),
        builder:
            (BuildContext context, AsyncSnapshot<List<DataModel>> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Table(
                  border: TableBorder.all(color: Colors.black, width: 1),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    const TableRow(
                        decoration: BoxDecoration(color: Colors.greenAccent),
                        children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("ID"),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Lat"),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Lon"),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("DateTime"),
                            ),
                          ),
                        ]),
                    ...List.generate(
                      snapshot.data?.length ?? 0,
                      (index) => TableRow(
                        children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${snapshot.data?[index].id ?? 0}"),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(snapshot.data![index].lat.toString()),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(snapshot.data![index].lon.toString()),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(snapshot.data![index].dateTime),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(
            child: Text("You Are Loser"),
          );
        },
      ),
    );
  }
}
