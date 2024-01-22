import 'package:flutter/material.dart';
import 'package:mobile_quiz/scopedModel/model.dart';
import 'package:mobile_quiz/screens/homeS/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_quiz/userAuthentication/authenticationPage.dart';
import 'package:mobile_quiz/userAuthentication/login.dart';
import 'package:mobile_quiz/userAuthentication/register.dart';
import 'package:mobile_quiz/widgets/loading.dart';
import 'package:scoped_model/scoped_model.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp((First()));
}

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MyModel>(
      model: MyModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Loading.id,
        routes: {
          Loading.id: (context) => Loading(),
          AuthenticationPage.id: (context) => AuthenticationPage(),
          Register.id: (context) => Register(),
          Login.id: (context) => Login(),
          HomeScreen.id: (context) => HomeScreen(),
        },
      ),
    );
  }
}
