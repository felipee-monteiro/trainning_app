import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TrainningDatabase {
  late String dbPath;
  Future<Database> open() async {
    dbPath = await getDatabasesPath();
    return await openDatabase(join(dbPath, 'trainning.sql'), version: 5,
        onOpen: (db) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS trainning_data ( id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR(35) NOT NULL, description TEXT, time INTEGER NOT NULL, interval INTEGER NOT NULL )');
    }, onConfigure: (db) async {
      return await db.transaction((txn) async {
        await txn.execute('DROP TABLE IF EXISTS trainning_data');
        await txn.execute(
            'CREATE TABLE trainning_data ( id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR(35) NOT NULL, description TEXT, time INTEGER NOT NULL, interval INTEGER NOT NULL )');
      });
    }, onCreate: (db, _) async {
      return await db.execute(
          'CREATE TABLE trainning_data ( id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR(35) NOT NULL, description TEXT, time INTEGER NOT NULL, interval INTEGER NOT NULL )');
    }, onUpgrade: (db, _, __) async {
      return await db.transaction((txn) async {
        await txn.execute('DROP TABLE trainning_data');
        await txn.execute(
            'CREATE TABLE trainning_data ( id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR(35) NOT NULL, description TEXT, time INTEGER NOT NULL, interval INTEGER NOT NULL )');
      });
    });
  }

  Future<void> delete() async {
    await deleteDatabase(dbPath);
  }
}

final trainningDB = TrainningDatabase();
