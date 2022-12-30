import 'dart:io';

import 'package:demo_assignment/routes/route_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

void showSnackBar(String msg, {String title = ''}) {
  Get.snackbar(title, msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black);
}

BuildContext? _dialogContext;

closeLoader() {
  if (_dialogContext != null) {
    Navigator.pop(_dialogContext!);
    _dialogContext = null;
  }
}

Future<void> startLoader(BuildContext context) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (buildContext) {
      _dialogContext = buildContext;
      return const SizedBox(
          height: 50,
          width: 50,
          child: Center(child: CircularProgressIndicator()));
    },
  );
}

void customPrinter(String msg) {
  if (kDebugMode) {
    print(msg);
  }
}

Future<bool> isConnected() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}

launchURL(String url) async {
  customPrinter("launchURL $url");
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    customPrinter('Could not launch $url');
  }
}

Future<void> initDynamicLinks() async {
  FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    handleLinkData(dynamicLinkData.link);
  }).onError((error) {
    customPrinter(error.toString());
    showSnackBar(error.toString(), title: 'Deeplink error');
  });
}

void handleLinkData(Uri uri) {
  String? universityName;
  final queryParams = uri.queryParameters;
  if (queryParams.isNotEmpty) {
    if(uri.queryParameters.isNotEmpty){
      universityName = uri.queryParameters['universityName'];
    }
    customPrinter(uri.toString());
    deeplinkRouteHandler(uri.path, name: universityName);
  }
}

void deeplinkRouteHandler(String path, {String? name}) {
  switch (path) {
    case RoutePath.universityDetailsRoute:
      Get.offNamedUntil(RoutePath.universityRoute, (route) => true, arguments: name);
      break;
    case RoutePath.universityRoute:
      Get.offNamedUntil(RoutePath.universityRoute, (route) => true);
      break;
    case RoutePath.loginRoute:
    default:
      Get.offAllNamed(RoutePath.loginRoute);
  }
}

Future<Uri> createDynamicLink(String name) async {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://tablabsassignment.page.link',
    link: Uri.parse('https://tablabsassignment.page.link/universityDetailsScreen?universityName=$name'),
    androidParameters: const AndroidParameters(
      packageName: 'com.example.demo_assignment',
      minimumVersion: 1,
    ),
    iosParameters: const IOSParameters(
      bundleId: 'com.example.demo_assignment',
      minimumVersion: '1',
    ),
  );
  final dynamicLink =
  await FirebaseDynamicLinks.instance.buildLink(parameters);
  customPrinter(dynamicLink.queryParameters['link'].toString());
  return dynamicLink;
}
