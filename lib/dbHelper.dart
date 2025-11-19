import 'dart:async';
import 'package:pas_mobile_11pplg2_10/model/tv_show_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb("tvshow.db");
    return _database!;
  }

  Future<Database> _initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    await db.execute("""
      CREATE TABLE tvshow(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        url TEXT,
        name TEXT,
        type TEXT,
        language TEXT,
        rating TEXT,
        image TEXT
      )
    """);
  }

  // INSERT
  Future<int> insertShow(Tvshowmodel model) async {
    final db = await instance.database;
    return await db.insert("tvshow", model.toMap());
  }


  Future<List<Map<String, dynamic>>> getAllShow() async {
    final db = await instance.database;
    return await db.query("tvshow");
  }

  Future<bool> isShowExists(int id) async {
    final db = await instance.database;
    final res = await db.query("tvshow", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty;
  }


  Future<int> deleteShow(int id) async {
    final db = await instance.database;
    return await db.delete("tvshow", where: "id = ?", whereArgs: [id]);
  }

}
