import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:politics/app.dart';
import 'package:politics/utils/colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: primaryDark
  ));
  runApp(App());
}
