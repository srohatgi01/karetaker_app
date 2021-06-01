import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:karetaker/data/models/googleuser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  signIn() async {
    var initialized = false;
    try {
      await Firebase.initializeApp();
      initialized = true;
    } catch (e) {
      print(e);
    }
    if (initialized) {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await firebaseAuth.signInWithCredential(googleAuthCredential);

      final User fuser = firebaseAuth.currentUser!;

      final user = GoogleUser.fromGoogle(fuser);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isSignedIn', true);
      prefs.setString('emailAddress', user.emailAddress!);
      prefs.setString('first_name', user.firstName!);
      prefs.setString('last_name', user.lastName!);
      prefs.setString('uuid', user.uuid!);
      prefs.setString('photoUrl', user.photoUrl!);

      String? emailAddress =
          prefs.getString('emailAddress') ?? 'Didn\'t get email';
      String? firstName =
          prefs.getString('first_name') ?? 'Didn\'t get First Name';
      String? lastName =
          prefs.getString('last_name') ?? 'Didn\'t get Last Name';
      String? uuid = prefs.getString('uuid') ?? 'Didn\'t get UUID';
      String? photoUrl = prefs.getString('photoUrl') ?? 'Didn\'t get Photo Url';

      GoogleUser googleUser = GoogleUser.fromLocal(
          firstName, lastName, emailAddress, uuid, photoUrl);

      print(googleUser.firstName);
      print(googleUser.lastName);
      print(googleUser.emailAddress);
      print(googleUser.uuid);
      print(googleUser.photoUrl);
      return googleUser;
    } else {
      print("Not initialized");
    }
  }

  signOut() async {
    await googleSignIn.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSignedIn', false);
    prefs.remove('emailAddress');
    prefs.remove('first_name');
    prefs.remove('last_name');
    prefs.remove('uuid');
    prefs.remove('photoUrl');
    print("Sign Out Successfully");
  }

  disconnect() async {
    await googleSignIn.disconnect();
    print("Disconnected Successfully");
  }
}
