import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider_student_management/constants/color.dart';
import 'package:provider_student_management/constants/others.dart';
import 'package:provider_student_management/model/database_model.dart';

class StudentDetails extends StatelessWidget {
  final Student student;
  const StudentDetails({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar:AppBar(),
    body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(gradient: Shade.bodyGradient),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(158, 0, 0, 0).withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: Offset(0,
                      18), // Adjust this offset to evenly distribute the shadow
                ),
              ],
            ),
            child: Card(
              elevation: 50,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                height: MediaQuery.of(context).size.height / 1.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Card(
                      elevation: 32,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                                           
                         
                            image: DecorationImage(
                                image: FileImage(
                                  File(student.imageurl),
                                ),
                                fit: BoxFit.cover),
                          
                          ),
                        ),
                      ),
                    ),
                    kheight20,
         
                    Text(
                      'Name : ${student.name}',
                      style: TextStyle1,
                    ),
                    Text(
                      'Age : ${student.age}',
                      style: TextStyle1,
                    ),
                    Text(
                      'Father : ${student.fatherName}',
                      style: TextStyle1,
                    ),
                    Text(
                      'School : ${student.schoolName}',
                      style:  TextStyle1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),);
  }
}