import 'package:flutter/material.dart';
import 'package:mobile_customer/core/utilities/enums/snackbar_enum.dart';

class AppHelper {
  static sizeH(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static sizeW(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static customSnackBar(
      BuildContext context, String title, SnackBarEnum snackBarEnum) {
    return ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        backgroundColor: {
          SnackBarEnum.info: Colors.blue[200],
          SnackBarEnum.warning: Colors.amber[400],
          SnackBarEnum.success: Colors.green[300],
          SnackBarEnum.error: Colors.red,
        }[snackBarEnum],
        content: Text(title),
      ),
    );
  }
}
