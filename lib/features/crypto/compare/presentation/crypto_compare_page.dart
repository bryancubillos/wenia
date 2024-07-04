import 'package:flutter/material.dart';

import 'package:wenia/core/utils/style/theme_app.dart';

class CryptoComparePage extends StatefulWidget {
  const CryptoComparePage({super.key});

  @override
  State<CryptoComparePage> createState() => _CryptoComparePageState();
}

class _CryptoComparePageState extends State<CryptoComparePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Title Compare',
          style: ThemeApp.textTheme.bodySmall?.copyWith(color: ThemeApp.primaryColor)
        ),
      ),
      body: Center(
        child: Text(
          "Compare",
          style: ThemeApp.textTheme.bodySmall?.copyWith(color: Colors.black),
        ))
      );
  }
}