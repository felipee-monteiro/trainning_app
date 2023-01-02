import 'package:sqflite/sqflite.dart';
import '../db.dart';

class Trainning {
  int? id;
  String? title;
  String description = '';
  String? time;

  Future<List<Map<String, Object?>>> get data async {
    var db = await trainningDB.open();
    var trainningData = await db.query('trainning_data');
    await db.close();
    return trainningData;
  }

  Future<int?> create(Map<String, Object> data) async {
    var db = await trainningDB.open();
    id = await db.insert('trainning_data', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    await db.close();
    return id;
  }

  Future<int?> delete({required int id}) async {
    var db = await trainningDB.open();
    var isDeleted =
        await db.rawDelete('DELETE FROM trainning_data WHERE id = ?', [id]);
    await db.close();
    return isDeleted;
  }
}

final trainningModel = Trainning();
