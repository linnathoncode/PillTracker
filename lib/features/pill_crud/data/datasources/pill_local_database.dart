import 'package:flutter/material.dart';
import 'package:pill_tracker/core/errors/failure.dart';
import 'package:pill_tracker/features/pill_crud/data/models/pill_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PillLocalDatabase {
  // Lazy initialization, no need to initialize explicitly
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
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      dosagePerDose TEXT NOT NULL, -- JSON string to store the map of dosages
      startDate TEXT DEFAULT (CURRENT_TIMESTAMP), -- Defaults to the current date and time
      endDate TEXT, -- Optional end date
      notes TEXT, -- Optional notes
      color TEXT, -- Optional color code
      totalPills INTEGER NOT NULL -- Total pills (mandatory)
    )
  ''');
  }

  Future<PillModel?> getPillById(int id) async {
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
      debugPrint(e.toString());
      throw DatabaseFailure('Failed to add pill: ${e.toString()}');
    }
  }

  Future<int> removePill(int id) async {
    final db = await instance.database;

    final rowsEffected = await db.delete(
      'pills',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (rowsEffected == 0) {
      throw DatabaseFailure('Failed to remove pill with id: $id!');
    }
    return rowsEffected;
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
    dosagePerDose,
    startDate,
    notes,
    color,
    totalPills,
    endDate,
  ];

  static const String id = 'id';
  static const String name = 'name';
  static const String dosagePerDose =
      'dosagePerDose'; // JSON string for dosage map
  static const String startDate =
      'startDate'; // Defaults to current timestamp if not provided
  static const String notes = 'notes'; // Optional notes
  static const String color = 'color'; // Optional color code
  static const String totalPills = 'totalPills'; // Mandatory field
  static const String endDate = 'endDate';
}
