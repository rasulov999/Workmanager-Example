import 'package:flutter/material.dart';
import 'package:workmanager_tutorial/data/models/data_model.dart';
import 'package:workmanager_tutorial/data/repository/data_repository.dart';

class WorkmanagerExampleScreen extends StatelessWidget {
  const WorkmanagerExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workmanager Example"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: DataRepository().getDatalist(),
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
