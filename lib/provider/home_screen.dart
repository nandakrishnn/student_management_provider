import 'package:flutter/foundation.dart';
import 'package:provider_student_management/database/database_helper.dart';
import 'package:provider_student_management/model/database_model.dart';

class Homeprovider extends ChangeNotifier {
  late DatabaseHelper databaseHelper;
  List<Student> filtered = [];
  List<Student> students = [];
  bool isSeacrching = false;

  

  Homeprovider() {
    databaseHelper = DatabaseHelper();
    refreshStudents();
  }


  Future<void> refreshStudents() async {
    final stduentslist = await databaseHelper.getStudents();
    students = stduentslist;
    filtered = stduentslist;
    notifyListeners();
  }

  void toogleSearch() {
    isSeacrching = !isSeacrching;
    if (!isSeacrching) {
      filtered = students;
    }
    notifyListeners();
  }

  void searchStudent(String query) {
    if (query.isEmpty) {
      filtered = students;
    } else {
      filtered = students
          .where((student) =>
              student.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

}
