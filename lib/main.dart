import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wenia/core/config/environment_config.dart';
import 'package:wenia/core/router/routes.dart';
import 'package:wenia/core/utils/style/theme_app.dart';
import 'package:wenia/features/common/menu/bloc/menu_bloc.dart';
import 'package:wenia/features/crypto/card/bloc/card_bloc.dart';
import 'package:wenia/features/crypto/list/bloc/crypto_list_bloc.dart';
import 'package:wenia/features/security/account/bloc/account_bloc.dart';
import 'package:wenia/features/security/change_password/bloc/change_password_bloc.dart';
import 'package:wenia/features/security/login/bloc/login_bloc.dart';
import 'package:wenia/features/security/new_account/bloc/new_account_bloc.dart';
import 'package:wenia/features/security/profile/bloc/profile_bloc.dart';
import 'package:wenia/features/security/security/bloc/security_bloc.dart';
import 'package:wenia/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase authentication
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Bloc
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<MenuBloc>(
        create: (BuildContext context) => MenuBloc(),
      ),
      BlocProvider<LoginBloc>(
        create: (BuildContext context) => LoginBloc(),
      ),
      BlocProvider<SecurityBloc>(
        create: (BuildContext context) => SecurityBloc(),
      ),
      BlocProvider<ProfileBloc>(
        create: (BuildContext context) => ProfileBloc(),
      ),
      BlocProvider<NewAccountBloc>(
        create: (BuildContext context) => NewAccountBloc(),
      ),
      BlocProvider<ChangePasswordBloc>(
        create: (BuildContext context) => ChangePasswordBloc(),
      ),
      BlocProvider<AccountBloc>(
        create: (BuildContext context) => AccountBloc(),
      ),
      BlocProvider<CryptoListBloc>(
        create: (BuildContext context) => CryptoListBloc(),
      ),
      BlocProvider<CardBloc>(
        create: (BuildContext context) => CardBloc(),
      ),
    ],
    child: const MyApp()
  ));  
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: EnvironmentConfig.weniaAppTitle,
      initialRoute: Routes.security,
      routes: Routes.getAppRoutes(),
      onGenerateRoute: Routes.onGenerateRoute,
      theme: ThemeApp.lightTheme,
    );
  }
}