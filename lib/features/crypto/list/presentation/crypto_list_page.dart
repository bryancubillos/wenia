import 'package:flutter/material.dart';

import 'package:wenia/core/utils/style/theme_app.dart';

class CryptoListPage extends StatefulWidget {
  const CryptoListPage({super.key});

  @override
  State<CryptoListPage> createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Title List',
          style: ThemeApp.textTheme.bodySmall?.copyWith(color: ThemeApp.primaryColor)
        ),
      ),
      body: Center(
        child: Text(
          "List",
          style: ThemeApp.textTheme.bodySmall?.copyWith(color: Colors.black),
        ))
      );
  }
}