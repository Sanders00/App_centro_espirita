import 'package:app_centro_espirita/Utils/show_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  })async{
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    }
    on FirebaseAuthException catch (e){
      showSnackBar(context, e.message!);
    }
  }
}