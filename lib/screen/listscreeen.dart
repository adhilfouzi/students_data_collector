import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_sqflite_01/database/db_functions.dart';
import 'package:task_sqflite_01/database/db_model.dart';
import 'package:task_sqflite_01/screen/editstudent.dart';
import 'package:task_sqflite_01/screen/studentdetails.dart';

class StudentList extends StatelessWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentList,
      builder: (context, value, child) {
        if (value.isEmpty) {
          return const Center(
            child: Text(
              'No data available',
              style: TextStyle(fontSize: 18),
            ),
          );
        } else {
          return ListView.separated(
            itemCount: value.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final student = value[index];

              return ListTile(
                leading: CircleAvatar(
                    backgroundImage: FileImage(
                  File(student.imagex),
                )),
                title: Text(student.name),
                subtitle: Text(
                  "Class: ${student.classname}, \nMobile: +91 - ${student.pnumber}",
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditStudent(student: student),
                        ));
                      },
                    ),
                    IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          deletestudent(context, student);
                        }),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctr) => StudentDetails(stdetails: student),
                  ));

                  // Add logic to handle when the student item is tapped.
                },
              );
            },
          );
        }
      },
    );
  }

  void deletestudent(rtx, StudentModel student) {
    showDialog(
      context: rtx,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Do You Want delete Name ?'),
          actions: [
            TextButton(
                onPressed: () {
                  delectYes(context, student);
                },
                child: const Text('Yes')),
            TextButton(
                onPressed: () {
                  Navigator.pop(rtx);
                },
                child: const Text('No'))
          ],
        );
      },
    );
  }

  void delectYes(ctx, StudentModel student) {
    deleteStudent(student.id!);
    ScaffoldMessenger.of(ctx).showSnackBar(
      const SnackBar(
        content: Text("Successfully Deleted"),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
    Navigator.of(ctx).pop();
  }
}
