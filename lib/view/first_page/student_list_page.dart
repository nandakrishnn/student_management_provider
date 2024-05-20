import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_management/constants/color.dart';
import 'package:provider_student_management/provider/home_screen.dart';
import 'package:provider_student_management/view/add_student/add_student.dart';
import 'package:provider_student_management/view/details_student/deatils_student.dart';

class StudentListFirst extends StatelessWidget {
  const StudentListFirst({super.key});

  @override
  Widget build(BuildContext context) {
    final homeprovider = Provider.of<Homeprovider>(context);

    return Scaffold(
      appBar: AppBar(
        title: !homeprovider.isSeacrching
            ? const Text('Student List')
            : TextField(
                onChanged: (query) {
                  homeprovider.searchStudent(query);
                },
                decoration: const InputDecoration(
                    hintText: 'Search student here',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w300,
                    )),
              ),
        actions: [
          IconButton(
              onPressed: () {
                homeprovider.toogleSearch();
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: homeprovider.filtered.isEmpty
          ? Center(
              child: LottieBuilder.asset('assets/no data found.json'),
            )
          : Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(gradient: Shade.bodyGradient),
              child: ListView.builder(
                itemCount: homeprovider.filtered.length,
                itemBuilder: (context, index) {
                  final student = homeprovider.filtered[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentDetails(
                                    student: student,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Card(
                        elevation: 10,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 45,
                                  backgroundImage:
                                      FileImage(File(student.imageurl)),
                                  backgroundColor: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    student.name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    student.schoolName,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddStudent()))
              .then((value) {
            homeprovider.refreshStudents();
          });
        },
        child: const Text('+'),
      ),
    );
  }
}
