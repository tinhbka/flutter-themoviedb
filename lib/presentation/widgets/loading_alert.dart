import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'common_alert.dart';

showLoaderDialog(BuildContext context) {
  final loadingView = Center(
    child: SpinKitCircle(
      color: Colors.blue,
      size: 48,
      duration: Duration(milliseconds: 800),
    ),
  );
  showDialogAnimated(
    barrierDismissible: false,
    enableScale: false,
    barrierColor: Colors.black38,
    context: context,
    builder: (BuildContext context) {
      return loadingView;
    },
  );
}

