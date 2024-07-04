import 'package:flutter/material.dart';

class SizeUtil {

  // [Orientation.portrait]
  bool isPortrait(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return orientation == Orientation.portrait;
  }

  bool isLandscape(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return orientation == Orientation.portrait;
  }
}