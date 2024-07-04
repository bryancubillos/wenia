import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wenia/core/service/culture_service.dart';
import 'package:wenia/core/utils/style/theme_app.dart';

class Message {

  // Methods
  void showMessage(BuildContext context, String message) {
    if(Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (BuildContext ctx) {
            return CupertinoAlertDialog(
                content: getMessage(message, ThemeApp.black),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      // Close this modal
                      Navigator.of(ctx).pop();
                    },
                    child: getAction("common-ok", ThemeApp.primaryColor)
                  )
                ]);
          });
    }
    else {
      showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
              content: getMessage(message, ThemeApp.black),
              actions: [
                TextButton(
                    onPressed: (() => Navigator.of(ctx).pop()),
                    child: getAction("common-ok", ThemeApp.primaryColor)
                  ),
              ]);
        });
      }
  }

  void showMessageWithActionsAndColor(BuildContext currentContext, String message, VoidCallback onPressedYes, Color textColor) {
    if(Platform.isIOS) {
      showCupertinoDialog(
          context: currentContext,
          builder: (BuildContext ctx) {
            return CupertinoAlertDialog(
                content: getMessage(message, textColor),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      // Action by widget
                      onPressedYes();

                      // Close this modal
                      Navigator.of(ctx).pop();
                    },
                    child: getAction("common-yes", ThemeApp.primaryColor)
                  ),
                  CupertinoDialogAction(
                    onPressed: () {
                      // Close this modal
                      Navigator.of(ctx).pop();
                    },
                    child: getAction("common-no", ThemeApp.black)
                  )
                ]);
          });
    }
    else {
      showDialog(
        context: currentContext,
        builder: (BuildContext ctx) {
          return AlertDialog(
              content: getMessage(message, textColor),
              actions: [
                TextButton(
                    onPressed: onPressedYes,
                    child: getAction("common-yes", ThemeApp.primaryColor)
                  ),
                TextButton(
                    onPressed: (() => Navigator.of(ctx).pop()),
                    child: getAction("common-no", ThemeApp.black)
                  ),
              ]);
        });
      }
  }

  void showMessageWithActions(BuildContext currentContext, String message, VoidCallback onPressedYes) {
    showMessageWithActionsAndColor(currentContext, message, onPressedYes, ThemeApp.black);
  }

  void showMessageWithAction(BuildContext context, String message, VoidCallback onPressedAction) {
    if(Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (BuildContext ctx) {
            return CupertinoAlertDialog(
                content: getMessage(message, ThemeApp.black),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      // Action by widget
                      onPressedAction();

                      // Close this modal
                      Navigator.of(ctx).pop();
                    },
                    child: getAction("common-ok", ThemeApp.primaryColor)
                  )
                ]);
          });
    }
    else {
      showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
              content: getMessage(message, ThemeApp.black),
              actions: [
                TextButton(
                    onPressed: (() {
                      // Action by widget
                      onPressedAction();

                      // Close this modal
                      Navigator.of(ctx).pop();
                    }),
                    child: getAction("common-ok", ThemeApp.primaryColor)
                  ),
              ]);
        });
      }
  }

  // Functions
  Widget getMessage(String message, Color textColor) {
    return Text(message,
      textAlign: TextAlign.center,
      style: ThemeApp.textTheme.bodyMedium?.copyWith(color: textColor)
    );
  }

  Widget getAction(String actionId, Color color) {
    return Text(
      CultureService().getLocalResource(actionId),
      style: ThemeApp.textTheme.bodySmall?.copyWith(color: color)
    );
  }
}
