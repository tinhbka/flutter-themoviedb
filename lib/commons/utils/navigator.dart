
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> pushTo(BuildContext context, Widget widget) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Future<dynamic> presentTo(
    BuildContext context,
    Widget widget, {
      bool rootNavigator = false,
    }) {
  return Navigator.of(context, rootNavigator: rootNavigator).push(
    CupertinoPageRoute(
      fullscreenDialog: true,
      builder: (context) => widget,
    ),
  );
}

void pop(BuildContext context, {dynamic result}) {
  if (context == null) {
    return;
  }
  Navigator.of(context).pop(result);
}