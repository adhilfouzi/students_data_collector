import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_sqflite_01/database/db_functions.dart';

class StudentDetails extends StatelessWidget {
  final stdetails;
  const StudentDetails({super.key, required this.stdetails});

  @override
  Widget build(BuildContext context) {
    getstudentdata();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => EditStudent(student: stdetails),
              // ));
            },
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          height: 400,
          width: 400,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 10,
            color: Colors.blueAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: FileImage(File(stdetails.imagex)),
                  radius: 80,
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('NAME     :${stdetails.name}'),
                    Text('CLASS    :${stdetails.classname}'),
                    Text('GUARDIAN :${stdetails.father}'),
                    Text('MOBILE   :${stdetails.pnumber}'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
