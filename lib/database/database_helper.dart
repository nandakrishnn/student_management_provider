import 'package:provider_student_management/model/database_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseversion = 1;
  static const table = 'students';
  static const columnId = '_id';
  static const columnName = 'name';
  static const columnFatherName = 'fathername';
  static const columnSchoolNmae = 'schoolname';
  static const columnAge = 'age';
  static const columnProfilePicture = 'profile_picture';

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabse();
    return _database!;
  }

  Future<Database> _initDatabse() async {
    return await openDatabase('student.db',
        version: _databaseversion, onCreate: _oncreate);
  }

  Future<void> _oncreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $table(
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnName TEXT NOT NULL,
          $columnFatherName TEXT NOT NULL,
          $columnSchoolNmae TEXT  NOT NULL,
          $columnAge INTEGER NOT NULL,
          $columnProfilePicture TEXT NOT NULL
        )
''');
  }

  Future<int> insertStudent(Student student) async {
    final db = await database;
    return await db.insert(table, {
      columnName: student.name,
      columnFatherName: student.fatherName,
      columnSchoolNmae: student.schoolName,
      columnAge: student.age,
      columnProfilePicture: student.imageurl
    });
  }

  Future<List<Student>> getStudents() async {
    final db = await database;
   final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(
        maps.length,
        (index) => Student(
            id: maps[index][columnId],
            name: maps[index][columnName],
            fatherName: maps[index][columnFatherName],
            schoolName: maps[index][columnSchoolNmae],
            imageurl: maps[index][columnProfilePicture],
            age: maps[index][columnAge]));
  }
  Future<int>updateStudent(Student student)async{
    final db=await database;
    return await db.update(table, {
      columnName:student.name,
      columnSchoolNmae:student.schoolName,
      columnFatherName:student.fatherName,
      columnAge:student.age,
      columnProfilePicture:student.imageurl
    },
    where: '$columnId=?',
    whereArgs: [student.id],
    
    );
  }
    Future<int>deleteStudent(int id)async{
      final db=await database;
      return await db.delete(
        table,
        where: '$columnId=?',
        whereArgs: [id],
      );
    }
}
