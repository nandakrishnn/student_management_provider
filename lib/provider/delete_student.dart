import 'package:flutter/foundation.dart';
import 'package:provider_student_management/database/database_helper.dart';

class StudentDetailsProvider extends ChangeNotifier{
final DatabaseHelper db=DatabaseHelper();

Future<void>deleteStudent(int studentId)async{
  await db.deleteStudent(studentId);
}
}