import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz/constants/decoration.dart';
import 'package:mobile_quiz/screens/homeS/homescreen.dart';
import 'package:mobile_quiz/sharedPrefs/userSharedPrefs.dart';
import 'package:mobile_quiz/userAuthentication/authenticationPage.dart';

class Loading extends StatefulWidget {
  static const String id = "loading";

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  bool userLoginStatus;
  getUserLoginStatus(){
    UserPreference.getUserLoggedPreference().then((value) {
     if(value == null){
       setState(() {
         userLoginStatus = false;
       });
     }else{
       setState(() {
         userLoginStatus = value;
       });
     }
    });
  }

  void nextPage(){
    Future.delayed(Duration(seconds: 10)).then((value) => Navigator.pushReplacementNamed(context, userLoginStatus == false ? AuthenticationPage.id : HomeScreen.id));
  }

  @override
  void initState() {
    getUserLoginStatus();
    nextPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: appBarColor2.withOpacity(0.1),
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/7,),
            Image.asset("assets/images/ml.png", color: buttonColor1,),
            Spacer(),
            Spacer(),
            Text("WELCOME", style: TextStyle(color: buttonColor1, fontSize: 20, fontStyle: FontStyle.italic),),
            Spacer(),
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(appBarColor2),
                strokeWidth: 6,
                backgroundColor: buttonColor1,
              ),
            ),
            SizedBox(height: 80,)
          ],
        ),
      ),
    );
  }
}

