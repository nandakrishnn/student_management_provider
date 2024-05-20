import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_management/provider/add_student.dart';
import 'package:provider_student_management/provider/home_screen.dart';
import 'package:provider_student_management/view/first_page/student_list_page.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>Homeprovider()),
        ChangeNotifierProvider(create: (_)=>AddStudentProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StudentListFirst(),
      ));
  }
}