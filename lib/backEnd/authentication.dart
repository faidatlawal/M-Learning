import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_quiz/backEnd/UserClass.dart';


class MyAuthServices{
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  UserClass _userGetFromFirebase(User user){
    return user != null ? UserClass(userId: user.uid): null;
  }

  Future registerWithEmailAndPassword({String email, String password})async{
    try{
      var result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User registerUser = result.user;
      return _userGetFromFirebase(registerUser);
    }catch(e){
      print(e.toString());
    }
  }

  Future signInWithEmail({String email, String password})async{
    try{
      var signIn = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User signedUer = signIn.user;
      return _userGetFromFirebase(signedUer);
    }catch(e){
      print(e.toString());
    }
  }
  Future signInOut()async{
    try{
      _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
}
