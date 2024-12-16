import 'package:pill_tracker/core/errors/failure.dart';
import 'package:pill_tracker/data/models/pill_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PillLocalDatabase {
  //lazy initialization no need to initialize
  static final PillLocalDatabase instance = PillLocalDatabase._init();

  static Database? _database;

  PillLocalDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('pilltracker.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE pills (
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL
    )
    ''');
  }

  Future<PillModel?> getPillById(String id) async {
    try {
      final db = await instance.database;

      final maps = await db.query(
        'pills',
        columns: PillModelFields.values,
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return PillModel.fromJson(maps.first);
      } else {
        return null;
      }
    } catch (e) {
      throw DatabaseFailure('Failed to get pill by id: $e');
    }
  }

  Future<List<PillModel>> getAllPills() async {
    try {
      final db = await instance.database;

      final result = await db.query('pills');

      return result.map((json) => PillModel.fromJson(json)).toList();
    } catch (e) {
      throw DatabaseFailure('Failed to get all pills: $e');
    }
  }

  Future<int> addPill(PillModel pill) async {
    try {
      final db = await instance.database;

      return await db.insert('pills', pill.toJson());
    } catch (e) {
      throw DatabaseFailure('Failed to add pill: ${e.toString()}');
    }
  }

  Future<int> removePill(String id) async {
    try {
      final db = await instance.database;

      return await db.delete(
        'pills',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw DatabaseFailure('Failed to remove pill: $e');
    }
  }

  Future close() async {
    try {
      final db = await instance.database;

      db.close();
    } catch (e) {
      throw DatabaseFailure('Failed to close database: $e');
    }
  }
}

class PillModelFields {
  static final List<String> values = [
    id,
    name,
  ];

  static const String id = 'id';
  static const String name = 'name';
}
