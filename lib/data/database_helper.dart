import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Tasks table
    await db.execute('''
      CREATE TABLE tasks (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        isCompleted INTEGER DEFAULT 0,
        priority INTEGER DEFAULT 1,
        dueDate INTEGER,
        category TEXT DEFAULT 'General',
        createdAt INTEGER NOT NULL,
        updatedAt INTEGER NOT NULL
      )
    ''');

    // Categories table for custom categories
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        color TEXT DEFAULT '#2196F3',
        createdAt INTEGER NOT NULL
      )
    ''');

    // Insert default categories
    await db.insert('categories', {
      'name': 'General',
      'color': '#2196F3',
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });
    await db.insert('categories', {
      'name': 'Work',
      'color': '#FF5722',
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });
    await db.insert('categories', {
      'name': 'Personal',
      'color': '#4CAF50',
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });
    await db.insert('categories', {
      'name': 'Shopping',
      'color': '#9C27B0',
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database upgrades here
    if (oldVersion < newVersion) {
      // Add new columns or tables as needed
    }
  }

  // Task CRUD operations
  Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert('tasks', task.toJson());
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      orderBy: 'createdAt DESC',
    );
    return List.generate(maps.length, (i) => Task.fromJson(maps[i]));
  }

  Future<Task?> getTask(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Task.fromJson(maps.first);
    }
    return null;
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    return await db.update(
      'tasks',
      task.toJson(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(String id) async {
    final db = await database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllTasks() async {
    final db = await database;
    return await db.delete('tasks');
  }

  // Task filtering and searching
  Future<List<Task>> getTasksByCategory(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'createdAt DESC',
    );
    return List.generate(maps.length, (i) => Task.fromJson(maps[i]));
  }

  Future<List<Task>> getTasksByPriority(TaskPriority priority) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'priority = ?',
      whereArgs: [priority.index],
      orderBy: 'createdAt DESC',
    );
    return List.generate(maps.length, (i) => Task.fromJson(maps[i]));
  }

  Future<List<Task>> getCompletedTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'isCompleted = ?',
      whereArgs: [1],
      orderBy: 'updatedAt DESC',
    );
    return List.generate(maps.length, (i) => Task.fromJson(maps[i]));
  }

  Future<List<Task>> getPendingTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'isCompleted = ?',
      whereArgs: [0],
      orderBy: 'dueDate ASC, createdAt DESC',
    );
    return List.generate(maps.length, (i) => Task.fromJson(maps[i]));
  }

  Future<List<Task>> getOverdueTasks() async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'dueDate < ? AND isCompleted = ?',
      whereArgs: [now, 0],
      orderBy: 'dueDate ASC',
    );
    return List.generate(maps.length, (i) => Task.fromJson(maps[i]));
  }

  Future<List<Task>> searchTasks(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'title LIKE ? OR description LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'createdAt DESC',
    );
    return List.generate(maps.length, (i) => Task.fromJson(maps[i]));
  }

  // Category operations
  Future<List<String>> getAllCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('categories');
    return List.generate(maps.length, (i) => maps[i]['name'] as String);
  }

  Future<int> insertCategory(String name, String color) async {
    final db = await database;
    return await db.insert('categories', {
      'name': name,
      'color': color,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<int> deleteCategory(String name) async {
    final db = await database;
    return await db.delete(
      'categories',
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  // Statistics
  Future<Map<String, int>> getTaskStatistics() async {
    final db = await database;
    
    final totalTasks = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM tasks')
    ) ?? 0;
    
    final completedTasks = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM tasks WHERE isCompleted = 1')
    ) ?? 0;
    
    final pendingTasks = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM tasks WHERE isCompleted = 0')
    ) ?? 0;
    
    final overdueTasks = Sqflite.firstIntValue(
      await db.rawQuery('''
        SELECT COUNT(*) FROM tasks 
        WHERE dueDate < ? AND isCompleted = 0
      ''', [DateTime.now().millisecondsSinceEpoch])
    ) ?? 0;

    return {
      'total': totalTasks,
      'completed': completedTasks,
      'pending': pendingTasks,
      'overdue': overdueTasks,
    };
  }

  // Close database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
} 