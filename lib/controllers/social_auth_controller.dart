// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:double_date/controllers/feed_controller.dart';
import 'package:double_date/controllers/profile_controller.dart';
import 'package:double_date/models/user_model.dart';
import 'package:double_date/pages/authScreens/create_profile.dart';
import 'package:double_date/pages/homeScreens/bottom_nav.dart';
import 'package:double_date/repositories/auth_repository.dart';
import 'package:double_date/utils/global_varibles.dart';
import 'package:double_date/utils/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import "dart:math" as math;

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialAuthController extends GetxController {
  String idToken = '';

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(forceCodeForRefreshToken: true).signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;
      idToken = credential.idToken.toString();
      return user;
    } catch (e) {
      idToken = '';
      return null;
    }
  }

  signInWithApple() async {
    final rawNonce = generateNonce();
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
        accessToken: appleCredential.authorizationCode,
      );
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      User? user = userCredential.user;
      idToken = appleCredential.identityToken.toString();
      return user;
    } catch (e) {
      idToken = '';
      return null;
    }
  }

  String generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = math.Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  onSocialLogin({required BuildContext context}) async {
    final pc = Get.put(ProfileController());
    final fc = Get.put(FeedController());

    final userCredential = Platform.isAndroid ? await signInWithGoogle() : await signInWithApple();
    if (userCredential != null) {
      final body = {
        "provider": Platform.isAndroid ? "Google" : "Apple",
        "accessToken": idToken,
        "deviceToken": GlobalVariable.deviceToken,
        "deviceType": Platform.isAndroid ? 'Android' : 'IOS',
      };
      final res = await AuthRepository().socialLogin(
        context: context,
        body: body,
      );
      if (res['data'] != null) {
        if (res['data']['token'] != null) {
          await setDataToStorage(StorageKeys.token, res['data']['token']);
        }
        if (res['message'] == 'Please complete your profile') {
          Get.to(
            () => const CreateProfile(
              isFromEditProfile: false,
              isFromRelationshipGoals: false,
            ),
          );
        } else {
          pc.saveUserDetails(
            UserModel.fromJson(
              res['data']['user'],
            ),
          );
          fc.editfeedData = res['data']['user']['posts'];
          await setDataToStorage(StorageKeys.isLogin, 'true');
          Get.offAll(() => const Dashboard());
        }
      } else {
        idToken = '';
      }
    }
  }
}
