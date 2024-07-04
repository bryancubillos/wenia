import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wenia/core/config/environment_config.dart';
import 'package:wenia/core/router/routes.dart';
import 'package:wenia/core/service/culture_service.dart';
import 'package:wenia/core/utils/style/theme_app.dart';
import 'package:wenia/features/common/message/message.dart';
import 'package:wenia/features/security/login/bloc/login_bloc.dart';
import 'package:wenia/features/security/security/bloc/security_bloc.dart';

class SecurityLoginPage extends StatefulWidget {
  const SecurityLoginPage({super.key});

  @override
  State<SecurityLoginPage> createState() => _SecurityLoginPageState();
}

class _SecurityLoginPageState extends State<SecurityLoginPage> {
  // [Properties]
  bool _hidePassword = true;
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // [Init state]
  @override
  void initState() {
    super.initState();

    // Init
    _accountNameController.text = "bryant_alejandro@hotmail.com";
    _passwordController.text = "12345678";
  }

  // [Constructor]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeApp.secondColor,
        title: Text(
          CultureService().getLocalResource("security-login-title"),
          style: ThemeApp.textTheme.bodyLarge?.copyWith(color: ThemeApp.black),
          textAlign: TextAlign.center),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: ThemeApp.thirdColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginError) {
              Message().showMessage(context, state.message);
            }
            else if(state is LoginSuccess) {
              // Get menu page
              context.read<SecurityBloc>().add(DoGetSecurityUser());
                            
              Navigator.pop(context);
            }
            else if(state is LoginLoaded) {
              if(state.message.isNotEmpty) {
                Message().showMessage(context, CultureService().getLocalResource(state.message));
              }
            }
          },
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 15),
                getUserName(),
                getPassword(),
                const SizedBox(height: 5),
                getLoginButton(),
                newAccountButton(),
              ]
            )
          )
      )
    );
  }

  // [Methods]
  Widget getUserName() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 14, right: 18, top: 4, bottom: 4),
      padding: const EdgeInsets.only(left: 14, right: 0, top: 4, bottom: 4),
      decoration: BoxDecoration(
        border: Border.all(color: ThemeApp.secondColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: _accountNameController,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]')),
        ],
        maxLength: EnvironmentConfig.maxAccountNameLength,
        style: ThemeApp.textTheme.bodyLarge?.copyWith(color: Colors.black),
        decoration: InputDecoration(
          labelText: CultureService().getLocalResource("login-email"),
          border: InputBorder.none,
          counterText: "",
          labelStyle: ThemeApp.textTheme.bodyMedium?.copyWith(color: ThemeApp.thirdColor),
        ),
      ),
    );
  }

  Widget getPassword() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 14, right: 18, top: 4, bottom: 4),
      padding: const EdgeInsets.only(left: 14, right: 6, top: 4, bottom: 4),
      decoration: BoxDecoration(
        border: Border.all(color: ThemeApp.secondColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: _passwordController,
        obscureText: _hidePassword,
        inputFormatters: [
          FilteringTextInputFormatter.deny(' '),
          FilteringTextInputFormatter.deny('\n'),
          FilteringTextInputFormatter.deny('\t'),
          FilteringTextInputFormatter.deny('\r')
        ],
        maxLength: EnvironmentConfig.maxPasswordLength,
        style: ThemeApp.textTheme.bodyLarge?.copyWith(color: Colors.black),
        decoration: InputDecoration(
          labelText: CultureService().getLocalResource("login-password"),
          border: InputBorder.none,
          counterText: "",
          labelStyle: ThemeApp.textTheme.bodyMedium
              ?.copyWith(color: ThemeApp.thirdColor),
          suffixIcon: IconButton(
            iconSize: 18,
            icon: Icon(_hidePassword ? Icons.visibility_off : Icons.visibility,
              color: ThemeApp.thirdColor),
            onPressed: () {
              setState(() => _hidePassword = !_hidePassword);
            },
          ),
        ),
      ),
    );
  }

  Widget getLoginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => current is LoginInitial || current is LoginLoading || current is LoginError || current is LoginSuccess,
      builder: (context, state) {
        if (state is LoginLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ElevatedButton(
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(DoLogin(
                  _accountNameController.text,
                  _passwordController.text)
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeApp.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  foregroundColor: ThemeApp.primaryColor),
              child: Text(
                CultureService().getLocalResource("login-action"),
                style: ThemeApp.textTheme.bodySmall?.copyWith(color: ThemeApp.primaryColor),
              ));
        }
      });
  }

  Widget newAccountButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.register);
      },
      child: Text(
        CultureService().getLocalResource("login-new-account"),
        style: ThemeApp.textTheme.bodySmall?.copyWith(color: ThemeApp.thirdColor),
      ),
    );
  }
}