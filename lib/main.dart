import 'package:doable_todo_list_app/widgets/doable_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Colors
Color blackColor = const Color(0xff0c120c);
Color blueColor = const Color(0xff4285F4);
Color whiteColor = const Color(0xffFDFDFF);
Color iconColor = const Color(0xff565656);
Color outlineColor = const Color(0xffD6D6D6);
Color descriptionColor = const Color(0xff565656);

void setPortraitOrientation() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

void main() {
  setPortraitOrientation();

  // Set system UI overlay (status/navigation bar color & brightness)
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: whiteColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: whiteColor,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: whiteColor,
    ),
  );

  runApp(const DoableApp());
}

// Padding helpers
double verticalPadding(BuildContext context) {
  return MediaQuery.of(context).size.height / 20;
}

double horizontalPadding(BuildContext context) {
  return MediaQuery.of(context).size.width / 20;
}

EdgeInsets textFieldPadding(BuildContext context) {
  return EdgeInsets.symmetric(
    horizontal: MediaQuery.of(context).size.width * 0.1,
    vertical: MediaQuery.of(context).size.height * 0.025,
  );
}
