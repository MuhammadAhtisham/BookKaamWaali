import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import '../../models/app_response.dart';
import 'package:bookkaamwaali/register_login_screen/emailLinkSignIn_Controller.dart';
AuthService get auth => Get.find<AuthService>();

class AuthService {

  final _firebaseAuth = firebase_auth.FirebaseAuth.instance;
  bool get isAuthenticated => _firebaseAuth.currentUser != null;
  String get userName => isAuthenticated ? _firebaseAuth.currentUser!.email ?? '' : '';

  Future<AppResponse> EmailLink({required String email,}) async {

    final actionCodeSettings = firebase_auth.ActionCodeSettings(
      url: 'https://bookkaamwaali.page.link/mVFa?email=$email',
      handleCodeInApp: true,
      androidPackageName: 'com.nonstopio.flutter_passwordless',
      iOSBundleId: 'com.nonstopio.flutter_passwordless',
    );
    await _firebaseAuth.sendSignInLinkToEmail(
      email: email,
      actionCodeSettings: actionCodeSettings,
    );

    return AppResponse.success(
      id: 'EmailLink',
    message: 'Email Link sent successfully',
      );

  }

  /// Cold state means the app was terminated.
  Future<AppResponse> retrieveDynamicLinkAndSignIn({required bool fromColdState,}) async {
  try {

    PendingDynamicLinkData? dynamicLinkData;
print("zara");
    if (fromColdState) {
      dynamicLinkData = await FirebaseDynamicLinks.instance.getInitialLink();
    } else {
      dynamicLinkData = await FirebaseDynamicLinks.instance.onLink.first;
    }

    if (dynamicLinkData == null) {
    return AppResponse.notFound(
      id: 'retrieveDynamicLinkAndSignIn',
      message: 'No Credentials Were Found',
      );
    }

   bool validLink = _firebaseAuth.isSignInWithEmailLink(dynamicLinkData.link.toString());
    if(validLink) {
      //Get the user's email address from the continueUrl
      final continueUrl = dynamicLinkData.link.queryParameters['continueUrl'] ?? "";
      final email = Uri.parse(continueUrl).queryParameters['continueUrl'] ?? "";

      final firebase_auth.UserCredential userCredential =
      await _firebaseAuth.signInWithEmailLink(
        email: email,
        emailLink: dynamicLinkData.toString(),
      );

      if (userCredential.user != null) {
        return AppResponse.success(
          id: 'retrieveDynamicLinkAndSignIn',
        message: 'Singed in successfully',
        );
      }
      else {
        return AppResponse.notFound(
          id: 'retrieveDynamicLinkAndSignIn',
        message: 'Not able to sign in',
        );
      }
    }
    else {
      return AppResponse.notFound(
        id: 'retrieveDynamicLinkAndSignIn',
      message: 'Link is not valid',
      );
    }
  }
  catch (e, s) {
    return AppResponse.error(
      id: 'retrieveDynamicLinkAndSignIn',
      error: e,
      stackTrace: s,
      );
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}