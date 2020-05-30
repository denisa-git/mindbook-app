import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<FirebaseUser> get currentUser {
    return _auth.onAuthStateChanged;
  }

  Future<FirebaseUser> signInWithEmail(String email, String password) async {
    FirebaseUser user;
    String errorMsg;
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      assert(authResult.user != null);
      assert(await authResult.user.getIdToken() != null);
      user = authResult.user;
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMsg = "Email is malformed";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMsg = "Invalid password";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMsg = "Account not found";
          break;
        case "ERROR_USER_DISABLED":
          errorMsg = "Account disabled";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMsg = "Attempts exceeded, please wait and try again";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMsg = "Email/password signin disabled";
          break;
        default:
          errorMsg = "Undefined Error";
      }
    }
    if (errorMsg != null) {
      return Future.error(errorMsg);
    }
    return user;
  }

  Future<FirebaseUser> signUpWithEmail(String email, String password) async {
    FirebaseUser user;
    String errorMsg;
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      assert(authResult.user != null);
      assert(await authResult.user.getIdToken() != null);
      user = authResult.user;
    } catch (error) {
      switch (error.code) {
        case "ERROR_WEAK_PASSWORD":
          errorMsg = "Password is not strong enough";
          break;
        case "ERROR_INVALID_EMAIL":
          errorMsg = "Invalid email";
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          errorMsg = "Email already in use";
          break;
        default:
          errorMsg = "Undefined Error";
      }
    }
    if (errorMsg != null) {
      return Future.error(errorMsg);
    }
    return user;
  }

  Future signInWithGoogle() async {
    FirebaseUser user;
    String errorMsg;
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        throw Exception("GOOGLE_ABORTED");
      }
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      AuthResult authResult = await _auth.signInWithCredential(credential);
      user = authResult.user;
    } catch (error) {
      switch (error.code) {
        case "GOOGLE_ABORTED":
          errorMsg = "Google signin cancelled";
          break;
        case "ERROR_INVALID_CREDENTIAL":
          errorMsg = "Request issue, please try again";
          break;
        case "ERROR_USER_DISABLED":
          errorMsg = "Account disabled";
          break;
        case "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL":
          errorMsg = "Please sign in with email/password";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMsg = "Google sign in disabled";
          break;
        case "GOOGLE_ABORTED":
          errorMsg = "Google sign in aborted";
          break;
        default:
          errorMsg = "Undefined Error";
      }
    }
    if (errorMsg != null) {
      return Future.error(errorMsg);
    }
    return user;
  }

  Future signInAnonymously() async {
    FirebaseUser user;
    String errorMsg;
    try {
      AuthResult authResult = await _auth.signInAnonymously();
      user = authResult.user;
    } catch (error) {
      switch (error.code) {
        case "ERROR_ADMIN_RESTRICTED_OPERATION":
          errorMsg = "Anonymous sign in disabled";
          break;
        default:
          errorMsg = "Undefined Error";
      }
    }
    if (errorMsg != null) {
      return Future.error(errorMsg);
    }
    return user;
  }

  Future forgotPassword(String email) async {
    String errorMsg;
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (error) {
      switch (error.code) {
        case "ERROR_MISSING_EMAIL":
          errorMsg = "An email address must be provided";
          break;
        case "ERROR_INVALID_EMAIL":
          errorMsg = "Invalid email";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMsg = "Account not found";
          break;
        default:
          errorMsg = "Undefined Error";
      }
    }
    if (errorMsg != null) {
      return Future.error(errorMsg);
    }
  }

  Future signOut() async {
    return await _auth.signOut();
  }
}
