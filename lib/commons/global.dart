import 'package:flutter/material.dart';

class Global {
  Global._privateConstructor();

  static final Global _instance = Global._privateConstructor();

  static Global get instance => _instance;

  BuildContext? loadingContext;

}