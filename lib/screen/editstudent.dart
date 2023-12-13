import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_sqflite_01/database/db_functions.dart';
import 'package:task_sqflite_01/database/db_model.dart';

class EditStudent extends StatefulWidget {
  final student;

  const EditStudent({super.key, required this.student});

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  String? updatedImagepath;

  final _formKey = GlobalKey<FormState>(); //  form key for the validation

  final _nameController = TextEditingController();
  final _classController = TextEditingController();
  final _guardianController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student'),
        actions: [
          IconButton(
            onPressed: () {
              editstudentclicked(
                context,
                widget.student,
              );
            },
            icon: const Icon(Icons.cloud_upload),
          )
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey, // Assign the form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: updatedImagepath != null
                          ? FileImage(File(updatedImagepath!))
                          : FileImage(File(widget.student.imagex)),
                      radius: 80,
                    ),
                    Positioned(
                      bottom: 20,
                      right: 5,
                      child: IconButton(
                        onPressed: () {
                          editphoto(context);
                        },
                        icon: const Icon(Icons.add_a_photo_outlined),
                        color: Colors.green,
                        iconSize: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),

                // Name input field with validation
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 2.0,
                      ),
                    ),
                    suffixIcon: const Icon(Icons.abc_outlined),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Class input field with validation
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _classController,
                  decoration: InputDecoration(
                    labelText: "Class",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 2.0,
                      ),
                    ),
                    suffixIcon: const Icon(Icons.class_outlined),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Class';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Guardian input field with validation
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _guardianController,
                  decoration: InputDecoration(
                    labelText: "Guardian",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 2.0,
                      ),
                    ),
                    suffixIcon: const Icon(Icons.person_4),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Guardian';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Mobile input field with validation
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _mobileController,
                  decoration: InputDecoration(
                    labelText: "Mobile",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 2.0,
                      ),
                    ),
                    suffixIcon: const Icon(Icons.phone_sharp),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Mobile';
                    } else if (value.length != 10) {
                      return 'Mobile number should be 10 digits';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.student.name;
    _classController.text = widget.student.classname;
    _guardianController.text = widget.student.father;
    _mobileController.text = widget.student.pnumber;
    updatedImagepath = widget.student.imagex;
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Future<void> geterimage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }
    setState(() {
      updatedImagepath = image.path.toString();
    });
  }

  Future<void> editstudentclicked(
      BuildContext context, StudentModel student) async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.toUpperCase();
      final classA = _classController.text.toString().trim();
      final father = _guardianController.text;
      final phonenumber = _mobileController.text.trim();

      final updatedStudent = StudentModel(
        id: student.id,
        name: name,
        classname: classA,
        father: father,
        pnumber: phonenumber,
        imagex: updatedImagepath ?? student.imagex,
      );

      await editStudent(
        student.id!,
        updatedStudent.name,
        updatedStudent.classname,
        updatedStudent.father,
        updatedStudent.pnumber,
        updatedStudent.imagex,
      );

      // Refresh the data in the StudentList widget.
      getstudentdata();

      Navigator.of(context).pop();
    }
  }

  void editphoto(ctxr) {
    showDialog(
      context: ctxr,
      builder: (ctxr) {
        return AlertDialog(
          title: const Text('Choose Image From.......'),
          content: const Text(' From where do you want to take the photo ?'),
          actions: [
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    geterimage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.red,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    geterimage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.image,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
