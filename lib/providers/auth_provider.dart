import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wandering_wheels/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:wandering_wheels/providers/user_provider.dart';

class AuthProvider extends ChangeNotifier {
  bool loggingIn = false;
  bool signingUp = false;

  login({
    required String email,
    required String password,
    required Function(String) onSuccess,
    required Function(String) onError,
  }) async {
    _setLoggingIn(true);
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      _setLoggingIn(false);
      onSuccess(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      _setLoggingIn(false);
      if (e.code == 'user-not-found') {
        _setLoggingIn(false);
        onError('No user found for that email.');
      } else if (e.code == "invalid-email") {
        onError('Invalid email address');
      } else if (e.code == "user-disabled") {
        onError('User corresponding to the given email has been disabled');
      } else if (e.code == 'wrong-password') {
        onError('Wrong password provided for that user.');
      } else {
        onError('An unknown error has invoked. Please check user credentials.');
      }
    } catch (e) {
      _setLoggingIn(false);
      onError(e.toString());
    }
  }

  signup({
    required BuildContext context,
    required String email,
    required String password,
    required UserData user,
    required Function(String) onSuccess,
    required Function(String) onError,
  }) async {
    _setSigningUp(true);
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user.id = credential.user!.uid;
      await context.read<UserProvider>().createUser(
            user: user,
            onSuccess: (val) {
              onSuccess(user.id!);
            },
            onError: (val) {
              onError(val);
            },
          );
      _setSigningUp(false);
    } on FirebaseAuthException catch (e) {
      _setSigningUp(false);
      if (e.code == 'weak-password') {
        onError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError('The account already exists for that email.');
      } else if (e.code == "operation-not-allowed") {
        onError('An unknown error from server');
      } else if (e.code == "invalid-email") {
        onError('Invalid email address');
      } else {
        onError('Something went wrong');
      }
    } catch (e) {
      _setSigningUp(false);
      onError(e.toString());
    }
  }

  _setSigningUp(bool val) {
    signingUp = val;
    notifyListeners();
  }

  _setLoggingIn(bool val) {
    loggingIn = val;
    notifyListeners();
  }
}
