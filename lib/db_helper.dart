// db_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'farm_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT,
        phone TEXT,
        email TEXT,
        location TEXT,
        totalAcres TEXT,
        password TEXT
      )
    ''');
  }

  Future<bool> registerUser(Map<String, dynamic> user) async {
    try {
      final db = await database;
      await db.insert('users', user);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>?> loginUser(String emailOrPhone, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'users',
      where: '(email = ? OR phone = ?) AND password = ?',
      whereArgs: [emailOrPhone, emailOrPhone, password],
    );
    
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }
}