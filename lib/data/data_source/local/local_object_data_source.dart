import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalObjectDataSource {
  Database? _db;
  final _dbName = "own.db";
  final _nowVersion = 1;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _databaseConfig();
    return _db!;
  }

  _databaseConfig() async {
    String path = join(await getDatabasesPath(), _dbName);
    var database = await openDatabase(
        path,
        version: _nowVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade
    );
    return database;
  }

  // DB version migration - DB 테이블 추가, 수정, 컬럼 추가, 수정 할때마다 migration & version up
  void _onUpgrade(Database database, int oldVersion, int newVersion) async {
    // if (oldVersion < 1) {
    //   await database.execute(DBTable.member.ddl);
    // }
  }

  // sqflite 객체는 bool값 못 받음 Integer로 바꿔줘야함
  void _onCreate(Database database, int version) async {
    // await database.execute(DBTable.member.ddl);
  }
}

enum DBTable {
  member;

  String get tableName {
    switch (this) {
      case DBTable.member:
        return "member";
    }
  }

  String get ddl {
    switch (this) {
      case DBTable.member:
        return '''
        CREATE TABLE member(
        user_id INTEGER PRIMARY KEY,
        nickname TEXT
        )
        ''';
    }
  }
}