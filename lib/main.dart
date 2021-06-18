import 'package:flutter/material.dart';
import 'package:mobile_quiz/screens/homeS/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_quiz/userAuthentication/authenticationPage.dart';
import 'package:mobile_quiz/userAuthentication/login.dart';
import 'package:mobile_quiz/userAuthentication/register.dart';
import 'package:mobile_quiz/widgets/loading.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp((First()));
}

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Loading.id,
      // initialRoute: LevelScreen.id,
      routes: {
        Loading.id: (context) => Loading(),
        AuthenticationPage.id: (context) => AuthenticationPage(),
        Register.id: (context) => Register(),
        Login.id: (context) => Login(),
        HomeScreen.id: (context) => HomeScreen(),
        // Category.id: (context)=> Category(),
      },
    );
  }
}
