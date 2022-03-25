import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/progress.dart';
import '../models/record.dart';
import 'db_constants.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._privateConstructor();
  static Database? _database;

  DBHelper._privateConstructor();

  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), DBConstants.feedTheCatDB),
      version: 1,
      onCreate: _createTable,
    );
  }

  Future _createTable(Database db, int version) async {
    await db.execute(DBConstants.createRecordTable);
    await db.execute(DBConstants.createProgressTable);
  }

  Future<void> insertOrUpdateRecordByUserName(Record record) async {
    int recordId = await isUserExistsInRecords(record.userName);
    if (recordId > 0) {
      await updateRecord(Record(
        id: recordId,
        userName: record.userName,
        dateTime: record.dateTime,
        score: record.score,
      ));
    } else {
      await insertRecord(record);
    }
  }

  Future<int> isUserExistsInRecords(String userName) async {
    final db = await database;
    List<Map> records = await db.query(DBConstants.recordTable);
    for (var element in records) {
      if (element[DBConstants.recordUserNameColumn] == userName) {
        return element[DBConstants.recordIdColumn];
      }
    }
    return -1;
  }

  Future<int> insertRecord(Record record) async {
    final db = await database;
    int id = await db.insert(
      DBConstants.recordTable,
      record.toMap(),
    );
    return id;
  }

  Future<int> deleteRecord(Record record) async {
    final db = await database;
    return await db.delete(
      DBConstants.recordTable,
      where: '${DBConstants.recordIdColumn} = ?',
      whereArgs: [record.id],
    );
  }

  Future<int> updateRecord(Record record) async {
    final db = await database;
    return await db.update(
      DBConstants.recordTable,
      record.toMap(),
      where: '${DBConstants.recordIdColumn} = ?',
      whereArgs: [record.id],
    );
  }

  Future<List<Record>> getRecordList() async {
    final userInfoList = <Record>[];
    final db = await database;
    final dbUserInfoListList = await db.query(DBConstants.recordTable);
    for (final element in dbUserInfoListList) {
      userInfoList.add(Record.fromMap(element));
    }
    return userInfoList;
  }

  Future<int> insertProgress(Progress progress) async {
    final db = await database;
    return await db.insert(
      DBConstants.progressTable,
      progress.toMap(),
    );
  }

  Future<int> deleteProgress(Progress progress) async {
    final db = await database;
    return await db.delete(
      DBConstants.progressTable,
      where: '${DBConstants.progressIdColumn} = ?',
      whereArgs: [progress.id],
    );
  }

  Future<int> updateProgress(Progress progress) async {
    final db = await database;
    return await db.update(
      DBConstants.recordTable,
      progress.toMap(),
      where: '${DBConstants.progressIdColumn} = ?',
      whereArgs: [progress.id],
    );
  }

  Future<List<Progress>> getProgressList() async {
    final progressList = <Progress>[];
    final db = await database;
    final dbProgressList = await db.query(DBConstants.progressTable);
    for (final element in dbProgressList) {
      progressList.add(Progress.fromMap(element));
    }
    return progressList;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
