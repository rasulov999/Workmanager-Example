import 'package:workmanager_tutorial/data/db/local_db.dart';
import 'package:workmanager_tutorial/data/models/data_model.dart';

class DataRepository {
  
  Future<DataModel> insertToDb(DataModel dataModel) =>
      LocalDatabase.insertToDatabase(dataModel);

  Future<List<DataModel>> getDatalist() => LocalDatabase.getList();

  Stream<List<DataModel>> getAllData(List<DataModel> dataModel) async*{
    dataModel.map((e) => DataModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  
}
