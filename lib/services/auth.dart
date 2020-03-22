import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService{


  final FirebaseAuth _auth  = FirebaseAuth.instance;
  final Firestore _db  = Firestore.instance;
  Future<FirebaseUser> get getUser => _auth.currentUser();
  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;


  Future signInAnon() async{

    try{

      AuthResult authResult = await _auth.signInAnonymously();
      FirebaseUser user = authResult.user;
      return user;
    } catch(e){

      print(e.toString());
      return null;

    }


  }

  Future signUpWithEmail(String email,String password,String username,String country) async{

    try{

      AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = authResult.user;
      updateUserData(user,username,country);
      return user;
    } catch(e){

      print(e.toString());
      return null;

    }


  }

  Future signInWithEmail(String email,String password,) async{

    try{

      AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = authResult.user;
      return user;
    } catch(e){

      print(e.toString());
      return null;

    }


  }

  Future<void> updateUserData(FirebaseUser user,String username,String country){

    DocumentReference reportRef = _db.collection('users').document(user.uid);

    return reportRef.setData({

      'uid': user.uid,
      'registrationDate': DateTime.now(),
      'username':username,
      'email': user.email,
      'country':country


    }, merge:true);

  }



}