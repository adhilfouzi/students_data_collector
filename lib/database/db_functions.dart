// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_sqflite_01/database/db_model.dart';

// Create a ValueNotifier to hold a list of StudentModel objects.
ValueNotifier<List<StudentModel>> studentList = ValueNotifier([]);
late Database _db;

// Function to initialize the database.
Future<void> initializeDatabase() async {
  _db = await openDatabase(
    'student_db',
    version: 1,
    onCreate: (Database db, version) async {
      // Create the 'student' table when the database is created.
      await db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, classname TEXT, father TEXT, pnumber TEXT, imagex TEXT)');
    },
  );
  //print("Database created successfully.");
}

// Function to retrieve student data from the database.
Future<void> getstudentdata() async {
  final result = await _db.rawQuery("SELECT * FROM student");
  print('All Students data : ${result}');
  studentList.value.clear();
  for (var map in result) {
    final student = StudentModel.fromMap(map);
    studentList.value.add(student);
  }
  studentList.notifyListeners();
}

// Function to add a new student to the database.
Future<void> addstudent(StudentModel value) async {
  try {
    await _db.rawInsert(
      'INSERT INTO student(name,classname,father,pnumber,imagex) VALUES(?,?,?,?,?)',
      [value.name, value.classname, value.father, value.pnumber, value.imagex],
    );
    log(value.id.toString());
    getstudentdata();
  } catch (e) {
    //------> Handle any errors that occur during data insertion.
    // print('Error inserting data: $e');
  }
}

// Function to delete a student from the database by their ID.
Future<void> deleteStudent(id) async {
  await _db.delete('student', where: 'id=?', whereArgs: [id]);
  getstudentdata();
}

// Function to edit/update a student's information in the database.
Future<void> editStudent(id, name, classname, father, pnumber, imagex) async {
  final dataflow = {
    'name': name,
    'classname': classname,
    'father': father,
    'pnumber': pnumber,
    'imagex': imagex,
  };
  await _db.update('student', dataflow, where: 'id=?', whereArgs: [id]);
  getstudentdata();
}

// You can add more comments as needed for further clarification.
