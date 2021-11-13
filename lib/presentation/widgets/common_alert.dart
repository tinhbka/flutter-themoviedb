
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_themoviedb/commons/utils/navigator.dart';

showDialogAnimated({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = false,
  bool enableScale = true,
  Color barrierColor = Colors.black54,
  Duration? duration,
}) {
  Timer? timer;
  if (duration != null) {
    timer = Timer(duration, () {
      pop(context);
    });
  }
  showGeneralDialog(
    context: context,
    barrierColor: barrierColor,
    barrierLabel: '',
    barrierDismissible: barrierDismissible,
    transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final progress = animation.value; //max(animation.value, 0.8);
      return Transform.scale(
        scale: enableScale ? progress : 1.0,
        child: Opacity(
          opacity: animation.value,
          child: child,
        ),
      );
    },
  ).then((value) {
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
  });
}

Future<void> showMessage(BuildContext context, String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: null,
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}