// import 'package:firebase_app_web/Service/Auth_Service.dart';
// import 'package:firebase_app_web/main.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../screens/addTaskPage.dart';
import '../screens/viewTaskPage.dart';
import '../services/auth_services.dart';


class HomePage extends StatefulWidget {
  HomePage({required Key key}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
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

          Padding(
            padding: const EdgeInsets.only(left: 10,right: 20),
            child: IconButton(
                icon: Icon(Icons.logout,color: Colors.white,),
                onPressed: () async {
                  await authClass.signOut(context: context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => MyApp()),
                          (route) => false);
                }),
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttonAddTask (context),
            SizedBox(
              height: 50,
            ),
            buttonViewTask (context),
          ],
        ),
      ),
    );
  }
}


Widget buttonAddTask(BuildContext context){
  return GestureDetector( // Wrap the Container with GestureDetector
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddTask()),
      );
    },
    child: Container(
      height: 70,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Center(
        child: Text ('Add Task', style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),),
      ),
    ),
  );
}


Widget buttonViewTask(BuildContext context){
  return GestureDetector( // Wrap the Container with GestureDetector
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ViewTask()),
      );
    },
    child: Container(
      height: 70,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Center(
          child: Text ('View Task', style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),)),
    ),
  );
}
