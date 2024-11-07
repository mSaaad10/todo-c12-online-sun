import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading(context,
      {required String message, bool isDismissible = true}) {
    showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: Row(
          children: [
            Text(message),
            const Spacer(),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  static void hide(context) {
    Navigator.pop(context);
  }

// ok  cancel
  static void showMessage(
    context, {
    String? title,
    String? body,
    String? posActionTitle,
    String? negActionTitle,
    VoidCallback? posAction,
    VoidCallback? negAction,
  }) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: title != null ? Text(title) : null,
        content: body != null ? Text(body) : null,
        actions: [
          if (posActionTitle != null)
            MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  posAction?.call();
                },
                child: Text(posActionTitle)),
          if (negActionTitle != null)
            MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  negAction?.call();
                },
                child: Text(negActionTitle))
        ],
      ),
    );
  }
}
