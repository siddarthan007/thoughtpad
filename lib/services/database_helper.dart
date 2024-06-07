import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:thoughtpad/models/thought_model.dart';

class DatabaseHelper {
  static const _version = 1;
  static const _dbName = "thoughts.db";
  static const _tableName = "thoughts";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
      return await db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, title TEXT NOT NULL, content TEXT NOT NULL, createdAt TEXT NOT NULL)');
    }, version: _version);
  }

  static Future<int> addThought({required Thought thought}) async {
    final db = await _getDB();
    return await db.insert(_tableName, thought.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateThought({required Thought thought}) async {
    final db = await _getDB();
    return await db.update(_tableName, thought.toJson(),
        where: 'id = ?',
        whereArgs: [thought.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteThought({required Thought thought}) async {
    final db = await _getDB();
    return await db
        .delete(_tableName, where: 'id = ?', whereArgs: [thought.id]);
  }

  static Future<List<Thought>> getAllThoughts() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(
        maps.length,
        (index) => Thought(
            id: maps[index]['id'] as int,
            title: maps[index]['title'] as String,
            content: maps[index]['content'] as String,
            createdAt: DateTime.parse(maps[index]['createdAt'])));
  }
}
