import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Function to handle Google sign-in process.
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // User canceled the sign-in.
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication; // Retrieve authentication details.
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth
          .signInWithCredential(credential); // Sign in with Google credentials.
      return userCredential.user;
    } catch (e) {
      log(e.toString()); // Log the error message.
      return null; // Return null on failure.
    }
  }
}
