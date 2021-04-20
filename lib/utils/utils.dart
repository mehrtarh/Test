import 'package:flutter/material.dart';
import 'package:job/api/error/error_model.dart';
import 'package:job/presentation/colors_value.dart';
import 'package:job/servermodel/response/base_respons.dart';
import 'package:overlay_support/overlay_support.dart';

class Utils {
  Utils._();

  static  showToast(String message) {
    Widget _toastWidget() {
      return Center(
        child: Container(
            alignment: Alignment.center,
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
                color: ColorsValue.toast,
                borderRadius: BorderRadius.circular(16.0)),
            child: Text(
              message,
              style: TextStyle(
                  color: ColorsValue.toastText,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            )),
      );
    }

    showSimpleNotification(Center(child: _toastWidget()),
        elevation: 32, background: Colors.transparent);
  }

  static void manageError(BaseResponse response) {
    if (response.error != null) {
      if (response.error is ErrorModel) {
        ErrorModel errorModel = response.error;
        if (errorModel.message != null) showToast(errorModel.message);
      } else if (response.error is String) showToast(response.error);
    }
  }
}
