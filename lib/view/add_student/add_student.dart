import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_student_management/constants/others.dart';
import 'package:provider_student_management/database/database_helper.dart';
import 'package:provider_student_management/model/database_model.dart';
import 'package:provider_student_management/provider/add_student.dart';
import 'package:provider_student_management/refactored_widgets/round_button.dart';

class AddStudent extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _fathernameController = TextEditingController();
  final _ageController = TextEditingController();
  final _schoolnameController = TextEditingController();
  final DatabaseHelper databaseHelper = DatabaseHelper();
  AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Add Students'), backgroundColor: Colors.amber),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
            key: _formkey,
            child: Consumer<AddStudentProvider>(
              builder: (context, addStudentCo, _) {
                return ListView(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        XFile? img = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        Provider.of<AddStudentProvider>(context, listen: false).setImage(img);
                      },
                      child: CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              addStudentCo.profilePicturePath != null
                                  ? FileImage(
                                      File(addStudentCo.profilePicturePath!))
                                  : null,
                          child: addStudentCo.profilePicturePath == null
                              ? const Icon(Icons.add_a_photo)
                              : null),
                    ),
                    kheight20,
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: const Text('Student Name'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Student Name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    kheight20,
                    TextFormField(
                      controller: _schoolnameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: const Text(' School Name'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter The school Name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    kheight20,
                    TextFormField(
                      controller: _fathernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: const Text('Father Name'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Father Name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    kheight20,
                    TextFormField(
                      controller: _ageController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: const Text('Age'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Age';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    kheight40,
                    RoundButton(
                        title: 'Save',
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            final student = Student(
                                id: 0,
                                name: _nameController.text,
                                fatherName: _fathernameController.text,
                                schoolName: _schoolnameController.text,
                                imageurl: addStudentCo.profilePicturePath ?? '',
                                age: int.parse(_ageController.text));
                            databaseHelper.insertStudent(student).then((id) {
                              if (id > 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Student added scucessfully')));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Failed to add student')));
                              }
                            });
                            Provider.of<AddStudentProvider>(context,listen: false)
                                .clearImage();
                                Navigator.pop(context);
                          }
                        },
                        buttoncolor: Colors.black,
                        textcolor: Colors.white)
                  ],
                );
              },
            )),
      ),
    );
  }
}
