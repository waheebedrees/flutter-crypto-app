import 'package:firebase_auth/firebase_auth.dart';
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<User?> registerUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  
  Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

}


String getCustomErrorMessage(FirebaseAuthException e) {
  switch (e.code) {
    case 'invalid-email':
      return 'The email address is badly formatted.';
    case 'user-not-found':
      return 'No user found with this email.';
    case 'wrong-password':
      return 'The password is incorrect.';
    case 'email-already-in-use':
      return 'This email is already registered.';
    case 'weak-password':
      return 'The password is too weak.';
    case 'operation-not-allowed':
      return 'This operation is not allowed. Please contact support.';
    default:
      return 'An unexpected error occurred. Please try again.';
  }
}
