import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart';
import 'package:karetaker/data/models/googleuser.dart';
import 'package:karetaker/data/provider/user_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart' as CustomUser;

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

      final googleUser = GoogleUser.fromGoogle(fuser);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isSignedIn', true);
      prefs.setString('emailAddress', googleUser.emailAddress!);
      prefs.setString('first_name', googleUser.firstName!);
      prefs.setString('last_name', googleUser.lastName!);
      prefs.setString('uuid', googleUser.uuid!);
      prefs.setString('photoUrl', googleUser.photoUrl!);

      // var emailAddress = prefs.getString('emailAddress') ?? null;
      // var firstName = prefs.getString('first_name') ?? null;
      // var lastName = prefs.getString('last_name') ?? null;
      // var uuid = prefs.getString('uuid') ?? null;
      // var photoUrl = prefs.getString('photoUrl') ?? null;

      // GoogleUser googleUser = GoogleUser.fromLocal(
      //   emailAddress: emailAddress,
      //   firstName: firstName,
      //   lastName: lastName,
      //   uuid: uuid,
      //   photoUrl: photoUrl,
      // );

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

  isNewUser(String emailAddress) async {
    Response response = await UserApi().fetchUser(emailAddress: emailAddress);

    if (response.statusCode == 404) {
      return true;
    } else if (response.statusCode == 200) {
      CustomUser.User user = CustomUser.User.fromRawJson(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('gender', user.gender!);
      prefs.setString('phoneNumber', user.phoneNumber!);

      return user;
    }
  }

  createUserInDatabase(String json) async {
    var createdUser = await UserApi().createUser(json: json);

    print("User created");

    CustomUser.User user = CustomUser.User.fromRawJson(createdUser.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('gender', user.gender!);
    prefs.setString('phoneNumber', user.phoneNumber!);

    return user;
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
    prefs.remove('gender');
    prefs.remove('phoneNumber');

    print("Sign Out Successfully");
  }

  disconnect() async {
    await googleSignIn.disconnect();
    print("Disconnected Successfully");
  }
}
