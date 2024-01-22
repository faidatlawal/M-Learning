import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_quiz/backEnd/authentication.dart';
import 'package:mobile_quiz/backEnd/database.dart';
import 'package:mobile_quiz/constants/decoration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:mobile_quiz/screens/homeS/homescreen.dart';
import 'package:mobile_quiz/sharedPrefs/userSharedPrefs.dart';
import 'package:mobile_quiz/userAuthentication/authenticationPage.dart';
import 'package:mobile_quiz/userAuthentication/login.dart';
import 'package:mobile_quiz/widgets/loadingGeneral.dart';

class Register extends StatefulWidget {
  static const String id = "register";
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password1;
  String password2;
  String name;
  String matricNo;
  TextEditingController controllerForEmail = TextEditingController();
  TextEditingController controllerForPassword1 = TextEditingController();
  TextEditingController controllerForMatric = TextEditingController();
  TextEditingController controllerForName = TextEditingController();
  TextEditingController controllerForPassword2 = TextEditingController();
  MyAuthServices myAuthServices = MyAuthServices();
  MyDatabaseServices myDatabaseServices = MyDatabaseServices();
  MyDataBaseMini myDataBaseMini = MyDataBaseMini();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool hidePassword = true;
  bool hidePassword2 = true;
  List<String> getL = [];
  String level = "";
  String gender = 'Male';
  String groupValue = 'Male';
  bool loading = false;

  getLevelList() {
    myDatabaseServices.getLevelListFromDb().then((value) {
      for (DocumentSnapshot valueGet in value.docs) {
        setState(() {
          getL.add(valueGet.data()['levelName']);
          level = getL[0];
        });
      }
      return getL;
    });
    //  print(a);
  }

  @override
  void initState() {
    super.initState();
    getLevelList();
    gender = "Male";
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        leading: Icon(Icons.school, color: buttonColor1, size: 35,),
        backgroundColor: appBarColor2,
        title: Text(
          "Mobile Learning",
          style: TextStyle(fontWeight: FontWeight.bold, color: buttonColor1),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: loading == true ? LoadingGeneral(): GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFormField(
                      controller: controllerForEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: formFieldDecoration.copyWith(
                        prefixIcon: Icon(
                          Icons.email,
                          color: buttonColor1,
                          size: 24,
                        ),
                      ),
                      validator: (valid) {
                        return valid.isEmpty
                            ? "Enter a valid email address"
                            : null;
                      },
                      onChanged: (values) {
                        setState(() {
                          email = values;
                        });
                      },
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      obscureText: hidePassword,
                      controller: controllerForPassword1,
                      decoration: formFieldDecoration.copyWith(
                        hintText: "Password",
                        prefixIcon: Icon(
                          FontAwesomeIcons.lock,
                          color: buttonColor1,
                          size: 24,
                        ),
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
                      validator: (valid) {
                        return valid.isEmpty ||
                                valid.length < 6 ||
                                valid != password2
                            ? "Password not match"
                            : null;
                      },
                      onChanged: (values) {
                        setState(() {
                          password1 = values;
                        });
                      },
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      obscureText: hidePassword2,
                      controller: controllerForPassword2,
                      decoration: formFieldDecoration.copyWith(
                        hintText: "Repeat Password",
                        prefixIcon: Icon(
                          FontAwesomeIcons.lock,
                          color: buttonColor1,
                          size: 24,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                            size: 28,
                          ),
                          onPressed: () {
                            setState(() {
                              hidePassword2 = !hidePassword2;
                            });
                          },
                        ),
                      ),
                      validator: (valid) {
                        return valid.isEmpty ||
                                valid.length < 6 ||
                                valid != password1
                            ? "Password not match"
                            : null;
                      },
                      onChanged: (values) {
                        setState(() {
                          password2 = values;
                        });
                      },
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      controller: controllerForMatric,
                      decoration: formFieldDecoration.copyWith(
                        hintText: "Matric No",
                        prefixIcon: Icon(
                          FontAwesomeIcons.user,
                          color: buttonColor1,
                          size: 24,
                        ),
                      ),
                      validator: (valid) {
                        return valid.isEmpty || valid.length < 5
                            ? "Enter your Matric No"
                            : null;
                      },
                      onChanged: (values) {
                        setState(() {
                          matricNo = values;
                        });
                      },
                    ),
                    SizedBox(
                      height: 7,
                    ),

                    TextFormField(
                      controller: controllerForName,
                      decoration: formFieldDecoration.copyWith(
                        hintText: "Name",
                        prefixIcon: Icon(
                          FontAwesomeIcons.userAlt,
                          color: buttonColor1,
                          size: 24,
                        ),
                      ),
                      validator: (valid) {
                        return valid.isEmpty
                            ? "Enter your Name"
                            : null;
                      },
                      onChanged: (values) {
                        setState(() {
                          name = values;
                        });
                      },
                    ),

                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      height: 53,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: Colors.white,
                          border: Border.all(width: 1.5, color: buttonColor1)),
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                "Select Level",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              width: 24,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: DropdownButton(
                                value: level,
                                items: getL.map((String dropDownStringItem) {
                                  return DropdownMenuItem(
                                    value: dropDownStringItem,
                                    child: Text(dropDownStringItem),
                                  );
                                }).toList(),
                                onChanged: (String newValue) {
                                  setState(() {
                                    level = newValue;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 53,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: Colors.white,
                          border: Border.all(width: 1.5, color: buttonColor1)),
                      child: Row(
                        children: [
                          Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                     Text(
                                        "Male",
                                        style: TextStyle(color: Colors.black),
                                        textAlign: TextAlign.end,
                                      ),
                                      Radio(
                                          value: 'Male', focusColor: buttonColor1, activeColor: buttonColor1,
                                          groupValue: groupValue,
                                          onChanged: (newValue) =>
                                              unChanged(newValue),
                                      ),
                                ],
                              ),
                          ),
                          Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                   Text(
                                        "Female",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                      Radio(
                                          value: 'Female', focusColor: buttonColor1, activeColor: buttonColor1,
                                          groupValue: groupValue,
                                          onChanged: (newValue) =>
                                              unChanged(newValue)),
                                ],
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an Account? ",
                          style: TextStyle(fontSize: 16),
                        ),
                        Flexible(
                          child: InkWell(
                            child: Text(
                              "Login Here",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            onTap: () => Navigator.pushReplacementNamed(context, Login.id),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 12,
                    ),
                    GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);

                            DateTime datetime = DateTime.now();
                            var formattedDate = DateFormat("EEEE, MMM d, y").format(datetime).toString();
                            var newTime = DateFormat.jm().format(datetime);

                            var registered =
                                await myAuthServices.registerWithEmailAndPassword(
                                    email: email, password: password1);
                            if (registered != null) {
                              await myDatabaseServices
                                  .setUserData(docData: <String, dynamic>{
                                "email": auth.currentUser.email,
                                "name": name,
                                "uid": auth.currentUser.uid,
                                "matric no": controllerForMatric.text.toUpperCase(),
                                "level": level,
                                "register_date": formattedDate,
                                "time": newTime.toString(),
                                "gender": gender,
                              }, userId: auth.currentUser.uid);

                              //===============================UserLevel DATA================================
                              await myDataBaseMini.userByLevelData(levelName: level, levelMap: <String, dynamic>{
                                "levelName": level,
                              });
//===============================UserLevel DATA ENDS HERE================================

                              // ===================UserLevels based on reg
                              await myDatabaseServices.storeUserByLevel(userDoc: <String, dynamic>{
                                "email": auth.currentUser.email,
                                "name": name,
                                "uid": auth.currentUser.uid,
                                "matric no": controllerForMatric.text.toUpperCase(),
                                "level": level,
                                "register_date": formattedDate,
                                "time": newTime.toString(),
                                "gender": gender,
                              }, userID: auth.currentUser.uid, levelName: level);
                              //=========================Ends ===================================

                              //Saving data into preference
                              UserPreference.setUserLoggedPreference(logPrefs: true);
                              UserPreference.setUserLoggedName(userLoggedName: name);
                              UserPreference.setUserLoggedEmail(userLoggedEmail: email);
                              UserPreference.setUserLoggedRegTime(userLoggedRegTime: newTime);
                              UserPreference.setUserLoggedRegDate(userLoggedRegDate: formattedDate);
                              UserPreference.setUserLoggedGender(userLoggedGender: gender);
                              UserPreference.setUserLoggedLevel(userLoggedLevel: level);
                              UserPreference.setUserLoggedMatricNo(userLoggedMatricNo: controllerForMatric.text.toUpperCase());

                              await Fluttertoast.showToast(
                                  msg: "Registration successful"
                              );

                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), ModalRoute.withName(AuthenticationPage.id));
                              controllerForEmail.clear();
                              controllerForMatric.clear();
                              controllerForPassword1.clear();
                              controllerForPassword2.clear();
                              controllerForName.clear();
                            } else {
                              setState(() => loading = false);
                              return showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) => AlertDialog(
                                        title: Text("Error"),
                                        content: Text("Invalid details"),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                controllerForEmail.clear();
                                                controllerForMatric.clear();
                                                controllerForPassword1.clear();
                                                controllerForPassword2.clear();
                                                controllerForName.clear();
                                              },
                                              child: Text(
                                                "OK",
                                                style: TextStyle(
                                                    color: iconColor2,
                                                    fontWeight: FontWeight.bold),
                                              )),
                                        ],
                                        backgroundColor: Colors.white,
                                        elevation: 24,
                                      ));
                            }
                          } else {
                            // values not correct
                            setState(() {
                              loading = false;
                              controllerForEmail.clear();
                              controllerForMatric.clear();
                              controllerForPassword1.clear();
                              controllerForPassword2.clear();
                              controllerForName.clear();
                            });
                          }
                        },
                        child: button(context: context, textTitle: "Register")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }

  unChanged(val) {
    setState(() {
      if (val == 'Male') {
        groupValue = val;
        gender = val;
      } else if (val == 'Female') {
        groupValue = val;
        gender = val;
      }
    });
  }
}
