import 'package:demo_assignment/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase/firebase_authentication_methods.dart';

class LoginViewModel extends GetxController {
  Future<void> login({required VoidCallback onLoginSuccess}) async {
    try {
      await isConnected().then((value) async {
        startLoader(Get.context!);
        User? user = await FireBaseAuthMethods.signInWithGoogle();
        if (user != null) {
          closeLoader();
          onLoginSuccess();
          showSnackBar('Login Successfully!', title: 'Success');
        } else {
          closeLoader();
          showSnackBar('Something went wrong', title: 'Error');
        }
      }).onError((error, stackTrace) async {
        closeLoader();
        showSnackBar('No internet connection!', title: 'Error');
      });
    } catch (e) {
      closeLoader();
      customPrinter(e.toString());
      showSnackBar(e.toString(), title: 'Error');
    }
  }
}
