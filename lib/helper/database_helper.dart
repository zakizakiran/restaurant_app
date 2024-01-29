import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'restaurant.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE favorite_restaurants (
      id TEXT PRIMARY KEY,
      name TEXT
    )
  ''');
  }

  Future<void> insertFavoriteRestaurant(Map<String, dynamic> restaurant) async {
    final Database db = await database;
    await db.insert('favorite_restaurants', restaurant,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteFavoriteRestaurant(String id) async {
    final Database db = await database;
    await db.delete('favorite_restaurants', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getFavoriteRestaurants() async {
    final Database db = await database;
    return await db.query('favorite_restaurants');
  }
}
