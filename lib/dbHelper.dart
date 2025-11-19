import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'shows.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE product(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            image TEXT,
            name TEXT,
            genres TEXT,
            language TEXT,
            rating INT
          )
          ''');
      },
    );
  }

  Future<int> markShow(Map<String, dynamic> show) async {
    final client = await db;
    return await client.insert('show', show);
  }

  Future<int> deleteShow(int id) async {
    final client = await db;
    return await client.delete('show', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getMarkShow() async {
    final client = await db;
    return await client.query('show');
  }
}
