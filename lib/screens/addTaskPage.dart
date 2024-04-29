import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/screens/viewTaskPage.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  String importance = '';

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context); // This line navigates back to the HomePage
                },
                icon: Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create New Task',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Task Title',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    title(context),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Importance Level',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        importanceLevel("*****", 0xFFFF5252),
                        SizedBox(
                          width: 25,
                        ),
                        importanceLevel("***", 0xFF8BC34A),
                        SizedBox(
                          width: 25,
                        ),
                        importanceLevel("*", 0xFFCDDC39),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    description(context),
                    SizedBox(
                      height: 20,
                    ),
                    button(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget button(BuildContext context) {
    return InkWell(
      onTap: () async {
        // Add data to Firestore
        await FirebaseFirestore.instance.collection("Task").add({
          "title": titleController.text,
          "Level": importance,
          "Description": descriptionController.text,
        });

        // Navigate to ViewTaskPage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewTask()),
        );
      },
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            'Add Task',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget description(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: descriptionController,
        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        maxLines: null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter Description",
          hintStyle: TextStyle(color: Colors.white, fontSize: 17),
          contentPadding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
        ),
      ),
    );
  }

  Widget importanceLevel(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          importance = label;
        });
      },
      child: Chip(
        backgroundColor: importance == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        label: Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.8,
        ),
      ),
    );
  }

  Widget title(BuildContext context) {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: titleController,
        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter Title",
          hintStyle: TextStyle(color: Colors.white, fontSize: 17),
          contentPadding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
        ),
      ),
    );
  }
}