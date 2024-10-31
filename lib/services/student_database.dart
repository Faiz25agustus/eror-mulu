import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_crud/models/student_model.dart';

class StudentDatabase {
  static final StudentDatabase instance = StudentDatabase._init();

  static Database? _database;

  StudentDatabase._init();

  Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    _database = await _initDB('students.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        nisn TEXT NOT NULL,
        birthDate TEXT NOT NULL,
        photoPath TEXT
      )
    ''');
  }

  Future<void> insertStudent(Student student) async {
    final db = await getDatabase();

    await db.insert(
      'students',
      student.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Student>> getStudents() async {
    final db = await getDatabase();  // Fixed recursive call

    final List<Map<String, dynamic>> maps = await db.query('students'); // Corrected the query

    return List.generate(maps.length, (i) {
      return Student(
        id: maps[i]['id'],
        name: maps[i]['name'],
        nisn: maps[i]['nisn'],
        birthDate: maps[i]['birthDate'],
        photoPath: maps[i]['photoPath'],
      );
    });
  }

  Future<void> deleteStudent(int id) async {
    final db = await getDatabase();
    await db.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}