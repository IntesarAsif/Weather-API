import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/screens/addTaskPage.dart';
// import 'package:task_management_app/screens/auth/signInPage.dart';
import 'package:task_management_app/screens/auth/signUpPage.dart';
import 'package:task_management_app/services/auth_services.dart';
// import 'package:task_management_app/pages/homePage.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized(); //all the widget is binding or not
  await Firebase.initializeApp(); //inialize firebase in the flutter app
  runApp(MyApp(key: UniqueKey()));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthClass authClass = AuthClass();
  Widget currentPage = SignUpPage(key: ValueKey('SignUpPageKey'));


  @override
  void initState() {
    super.initState();
    // authClass.signOut();
    checkLogin();
  }

  checkLogin() async {
    String? token = await authClass.getToken();
    print("token");
    if (token != null)
      setState(() {
        currentPage = AddTask();
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: currentPage,
    );
  }
}

