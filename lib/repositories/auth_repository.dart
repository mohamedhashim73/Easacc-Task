import 'package:easacc_task/core/constants/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../core/services/app_secrets.dart';
import '../core/services/dependency_injection.dart';

class AuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  Future<User?> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize(serverClientId: AppSecrets.kFirebaseWebClientID);
      final GoogleSignInAccount? googleUser = await _googleSignIn.attemptLightweightAuthentication();
      if (googleUser == null) return null;
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.idToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await sl<FirebaseAuth>().signInWithCredential(credential);
      return userCredential.user;
    }
    on FirebaseException catch(e){
      throw Exception(e.code);
    }
    catch (e) {
      throw Exception(AppStrings.kSomethingWentWrong);
    }
  }

  Future<User?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status != LoginStatus.success) return null;
      final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);
      final UserCredential userCred = await sl<FirebaseAuth>().signInWithCredential(credential);
      return userCred.user;
    }
    on FirebaseException catch(e){
      throw Exception(e.code);
    }
    catch (e) {
      throw Exception(AppStrings.kSomethingWentWrong);
    }
  }
}
