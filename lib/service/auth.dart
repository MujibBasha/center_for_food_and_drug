import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  User user;
  // bool isSignInWithGoogle;
  // FirebaseAuth _auth;
  // Authentication() {
  //   initFirebase();
  // }
  // initFirebase() async {
  //   // try {
  //   await Firebase.initializeApp();
  //   _auth = FirebaseAuth.instance;
  //   // } catch (e) {
  //   //   print(e);
  //   //   //show Screen
  //   // }
  // }
//NewUser ==> user and institution
  Future signUpNewUser({String email, String password}) async {
    await Firebase.initializeApp();

    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  getCurrentUser() async {
    await Firebase.initializeApp();
    return FirebaseAuth.instance.currentUser;
  }

  Future deleteCurrentUser() async {
    await Firebase.initializeApp();
    return FirebaseAuth.instance.currentUser.delete();
  }

  Future signInUser({String email, String password}) async {
    await Firebase.initializeApp();
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
  //
  // Future signInWithGoogle() async {
  //   GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  //
  //   if (googleSignInAccount != null) {
  //     GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount.authentication;
  //     //To get Info of user from Google
  //     // ignore: deprecated_member_use
  //     AuthCredential credential = GoogleAuthProvider.getCredential(
  //         idToken: googleSignInAuthentication.idToken,
  //         accessToken: googleSignInAuthentication.accessToken);
  //
  //     var result = await _auth.signInWithCredential(credential);
  //
  //     user = FirebaseAuth.instance.currentUser;
  //     print(
  //         "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++$user");
  //
  //     if (user.uid == result.user.uid) {
  //       isSignInWithGoogle = true;
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   }
  // }

  signOut() async {
    await Firebase.initializeApp();
    User currentUser = FirebaseAuth.instance.currentUser;
    print(
        "+======================================================================$currentUser");
    print(
        "+======================================================================${currentUser.providerData}");
    try {
      // await googleSignIn.disconnect();
      if (currentUser.providerData[0].providerId == 'google.com') {
        print("_________________________________ sign out from google");
        // await googleSignIn.disconnect();
      } else {
        await FirebaseAuth.instance.signOut();
      }
    } catch (e) {
      print(e);
    }

    // if (isSignInWithGoogle) {
    //   await googleSignIn.disconnect();
    //   return;
    // }
  }

  Future sendPasswordResetEmail({String email}) async {
    await Firebase.initializeApp();
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
