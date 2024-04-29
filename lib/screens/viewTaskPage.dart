import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/custom/viewData.dart';

import '../custom/taskCard.dart';
import 'addTaskPage.dart';

class ViewTask extends StatefulWidget {
  const ViewTask({super.key});

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  final Stream<QuerySnapshot> _stream =  //Source of stream
    FirebaseFirestore.instance.collection("Task").snapshots(); //store inside the task collection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: EdgeInsets.only(top: 60.0, bottom: 60), // Increase bottom padding
          child: Text("Task List", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,color: Colors.white),),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: CircleAvatar(
              child: SizedBox (
                height: 20,
              ),
              backgroundImage: AssetImage("assets/avatar2.jpg"),
            ),
          ),
          SizedBox(
            width: 30,
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30,color: Colors.white,),
            label: '',
          ),

          BottomNavigationBarItem(
            icon: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder) => AddTask()));
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [
                        Colors.redAccent,
                        Colors.pinkAccent,
                      ]
                  ),
                ),
                child: Icon(Icons.add, size: 30,color: Colors.white,),
              ),
            ),
            label: '',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 30,color: Colors.white,),
            label: 'Settings',
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context,index){
                IconData iconData;
                Color iconColor;
                Map<String, dynamic> document = snapshot.data?.docs[index].data() as Map<String, dynamic>;

                switch (document["Level"]){
                  case "*****":
                    iconData = Icons.circle;
                    iconColor = Colors.redAccent;
                    break;
                  case "***":
                    iconData = Icons.circle;
                    iconColor = Colors.lightGreen;
                    break;
                  case "*":
                    iconData = Icons.circle;
                    iconColor = Colors.lime;
                    break;
                  default:
                    iconData = Icons.circle;
                    iconColor = Colors.redAccent;
                }
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder) => ViewData(document: {},)));
              },
              child: TaskCard(

                title: document["title"] == null ? "Please enter the title" : document["title"],
                description: document["Description"] == null ? "Please enter the description" : document["Description"],
                check: true,
                time: "10 AM",
              ),
            );
          });
            
            

        }
      ),
    );
  }
}




