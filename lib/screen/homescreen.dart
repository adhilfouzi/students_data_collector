import 'package:flutter/material.dart';
import 'package:task_sqflite_01/database/db_functions.dart';
import 'package:task_sqflite_01/screen/addstudent.dart';
import 'package:task_sqflite_01/screen/listscreeen.dart';
import 'package:task_sqflite_01/screen/searchscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    getstudentdata();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.face_sharp),
        ),
        title: const Text(
          'Students Data',
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                addstudent(context);
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctxs) => const SearchScreen()));
              },
              icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: const Column(
        children: [
          Expanded(
            child: StudentList(),
          ),
        ],
      ),
    );
  }

  void addstudent(gtx) {
    Navigator.of(gtx)
        .push(MaterialPageRoute(builder: (gtx) => const AddStudent()));
  }
}
