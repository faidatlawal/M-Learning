import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_quiz/backEnd/authentication.dart';
import 'package:mobile_quiz/constants/decoration.dart';
import 'package:mobile_quiz/screens/homeS/homescreen.dart';
import 'package:mobile_quiz/sharedPrefs/userSharedPrefs.dart';
import 'package:mobile_quiz/userAuthentication/register.dart';
import 'package:mobile_quiz/widgets/loadingGeneral.dart';
class Login extends StatefulWidget {
  static const String id = "login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String error;
  bool hidePassword = true;
  TextEditingController controllerForEmail = TextEditingController();
  TextEditingController controllerForPassword = TextEditingController();
  bool loadingPage = false;
  
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  MyAuthServices myAuthServices = MyAuthServices();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        backgroundColor: appBarColor2,
        leading: Icon(Icons.school, color: buttonColor1, size: 35,),
        title: Text("Mobile Learning", style: TextStyle(fontWeight: FontWeight.bold, color: buttonColor1),),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: loadingPage == true ? LoadingGeneral(): GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 4),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: controllerForEmail,
                      keyboardType: TextInputType.emailAddress,
                      validator: (valid){
                        return valid.isEmpty ? "Enter your email address" : null;
                      },
                      onChanged: (values){
                        setState(() {
                          email = values;
                        });
                      },
                      decoration: formFieldDecoration.copyWith(
                        prefixIcon: Icon(Icons.email, color: buttonColor1,size: 24,),

                      ),
                    ),
                    SizedBox(height: 7,),
                    TextFormField(
                      obscureText: hidePassword,
                      controller: controllerForPassword,
                      validator: (valid){
                        return valid.isEmpty || valid.length < 6 ? "Invalid password length (6min)": null;
                      },
                      onChanged: (values){
                        setState(() {
                          password = values;
                        });
                      },
                      decoration: formFieldDecoration.copyWith(
                        hintText: "Password",
                        prefixIcon: Icon(FontAwesomeIcons.lock,color: buttonColor1,size: 24,),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                            size: 28,
                          ),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 18,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an Account? ", style: TextStyle(fontSize: 18),),
                        InkWell(child: Text("Register Here", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                          onTap: ()=> Navigator.pushReplacementNamed(context, Register.id),),
                      ],
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height / 12,),
                    GestureDetector(
                        onTap: ()async{
                          if(_formKey.currentState.validate()){
                            setState(() => loadingPage = true);
                          //  print("valid");
                           await  myAuthServices.signInWithEmail(email: email, password: password).then((value)async{
                            if ( value != null){
                              QuerySnapshot query = await firebaseFireStore.collection("Users").where("uid", isEqualTo: auth.currentUser.uid).get();
                              final List <DocumentSnapshot> docSnap = query.docs;
                              if (docSnap.length == 0){
                                setState(() {
                                  loadingPage = false;
                                  Fluttertoast.showToast(msg: "user does not exit");
                                });
                              }else{
                                //Saving data into preference
                                UserPreference.setUserLoggedPreference(logPrefs: true);
                                UserPreference.setUserLoggedName(userLoggedName: docSnap[0].data()["name"]);
                                UserPreference.setUserLoggedEmail(userLoggedEmail: docSnap[0].data()["email"]);
                                UserPreference.setUserLoggedRegTime(userLoggedRegTime: docSnap[0].data()["time"]);
                                UserPreference.setUserLoggedRegDate(userLoggedRegDate: docSnap[0].data()["register_date"]);
                                UserPreference.setUserLoggedGender(userLoggedGender: docSnap[0].data()["gender"]);
                                UserPreference.setUserLoggedLevel(userLoggedLevel: docSnap[0].data()["level"]);
                                UserPreference.setUserLoggedMatricNo(userLoggedMatricNo: docSnap[0].data()["matric no"]);

                                await Fluttertoast.showToast(
                                    msg: "Login successful"
                                );

                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), ModalRoute.withName(HomeScreen.id));
                                controllerForPassword.clear();
                                controllerForEmail.clear();
                              }

                            }else{
                              setState(() => loadingPage = false);
                              showDialog(context:context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: Text("Error"),
                                        content: Text("Invalid details"),
                                        actions: [
                                          ElevatedButton(onPressed: (){
                                            Navigator.pop(context);
                                          },
                                              child: Text("OK", style: TextStyle(color: iconColor2, fontWeight: FontWeight.bold),)),
                                        ],
                                        backgroundColor: Colors.white,
                                        elevation: 24,
                                      ));
                              controllerForPassword.clear();
                              controllerForEmail.clear();
                            }
                           });
                          }else{
                            controllerForPassword.clear();
                            controllerForEmail.clear();
                            setState(() {
                              loadingPage = false;
                            });
                          }
                        },
                        child: button(context: context, textTitle: "Login")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
