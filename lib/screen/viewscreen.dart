import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_sqflite_01/database/db_functions.dart';
import 'package:task_sqflite_01/database/db_model.dart';
import 'package:task_sqflite_01/screen/editstudent.dart';
import 'package:task_sqflite_01/screen/studentdetails.dart';

class ViewScreen extends StatelessWidget {
  const ViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<StudentModel>>(
      valueListenable: studentList,
      builder: (context, students, child) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: students.length,
          itemBuilder: (context, index) {
            final student = students[index];

            return Card(
              elevation: 4,
              child: InkWell(
                onTap: () => navigateToStudentDetails(context, student),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: FileImage(
                        File(student.imagex),
                      ),
                    ),
                    Text(student.name),
                    Text(
                      "Class: ${student.classname}",
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            navigateToEditStudent(context, student);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            confirmDelete(context, student);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void confirmDelete(BuildContext context, StudentModel student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Do you want to delete this student?'),
          actions: [
            TextButton(
              onPressed: () {
                deleteStudentAndShowSnackBar(context, student);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  void deleteStudentAndShowSnackBar(
      BuildContext context, StudentModel student) {
    deleteStudent(student.id!);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Successfully Deleted"),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
    Navigator.of(context).pop();
  }

  void navigateToEditStudent(BuildContext context, StudentModel student) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditStudent(student: student),
      ),
    );
  }

  void navigateToStudentDetails(BuildContext context, StudentModel student) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StudentDetails(stdetails: student),
      ),
    );
  }
}
