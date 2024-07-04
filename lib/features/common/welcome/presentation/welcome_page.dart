import 'package:flutter/material.dart';

import 'package:wenia/core/router/routes.dart';
import 'package:wenia/core/service/culture_service.dart';
import 'package:wenia/core/utils/device/size_util.dart';
import 'package:wenia/core/utils/style/theme_app.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  
  // [Constructor]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 80, bottom: 20),
              color: ThemeApp.primaryColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    getHiTitle(),
                    const SizedBox(height: 15),
                    getWelcomeDescription(),
                    const SizedBox(height: 15),
                    getLoginButton()
                  ],
                ),
              ),
            ),
            SizeUtil().isLandscape(context) ? const SizedBox(height: 120) : const SizedBox(height: 60),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: getImageAndDescription(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // [Methods]
  Widget getHiTitle() {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Text(
        CultureService().getLocalResource("welcome-hi"),
        style: ThemeApp.textTheme.titleLarge?.copyWith(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget getWelcomeDescription() {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Text(
        CultureService().getLocalResource("welcome-title"),
        style: ThemeApp.textTheme.bodyMedium?.copyWith(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget getLoginButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.login);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: ThemeApp.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        foregroundColor: ThemeApp.primaryColor,
      ),
      child: Text(
        CultureService().getLocalResource("welcome-login"), 
        style: ThemeApp.textTheme.bodySmall?.copyWith(color: ThemeApp.primaryColor),
      ),
    );
  }

  List<Widget> getImageAndDescription() {
    return [
      Image.asset(
        'lib/core/assets/img/wenia-logo.png',
        width: 200,
        height: 200,
      ),
      const SizedBox(height: 10),
      Text(
        CultureService().getLocalResource("welcome-second-title"),
        style: ThemeApp.textTheme.bodyMedium?.copyWith(color: Colors.grey),
      ),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Text(
          CultureService().getLocalResource("welcome-third-title"),
          style: ThemeApp.textTheme.bodySmall?.copyWith(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      )
    ];
  }
}
