
import 'package:flutter/material.dart';
import 'package:flutter_themoviedb/commons/global.dart';
import 'package:flutter_themoviedb/commons/utils/navigator.dart';
import 'package:flutter_themoviedb/presentation/widgets/loading_alert.dart';

abstract class BaseStatefulState<T extends StatefulWidget> extends State<T> {

  dismissLoadingDialog(BuildContext context) {
    if (Global.instance.loadingContext != null) {
      Global.instance.loadingContext = null;
      pop(context);
    }
  }

  showLoadingDialog(BuildContext context) {
    if (Global.instance.loadingContext != null) return;
    showLoaderDialog(context);
    Global.instance.loadingContext = context;
  }

}