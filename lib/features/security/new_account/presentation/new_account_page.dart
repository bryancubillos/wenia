import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wenia/core/config/environment_config.dart';
import 'package:wenia/core/service/culture_service.dart';
import 'package:wenia/core/utils/style/theme_app.dart';
import 'package:wenia/features/common/message/message.dart';
import 'package:wenia/features/security/login/bloc/login_bloc.dart';
import 'package:wenia/features/security/new_account/bloc/new_account_bloc.dart';

class NewAccountPage extends StatefulWidget {
  const NewAccountPage({super.key});

  @override
  State<NewAccountPage> createState() => _NewAccountPageState();
}

class _NewAccountPageState extends State<NewAccountPage> {
  // [Properties]
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _hidePassword = true;
  bool _isChecked = false;

  // [Contructor]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CultureService().getLocalResource("login-new-account-title"), style: ThemeApp.textTheme.bodyLarge?.copyWith(color: ThemeApp.thirdColor)),
      ),
      body: BlocListener<NewAccountBloc, NewAccountState>(
          listener: (context, state) {
            if (state is NewAccountError) {
              if(state.message.isNotEmpty) {
                Message().showMessage(context, state.message);
              }
            }
            else if(state is NewAccountSuccess) {
              // Get menu page
              context.read<LoginBloc>().add(const DoNotifyRegistrerSuccess());

              // Close register page
              Navigator.pop(context);
            }
          },
          child: SafeArea(
            child: Column(
              children: [
                getUserName(),
                getPassword(),
                getVerifyAgeInput(),
                getRegistrerButton(),
              ],
            )
          )
      ),
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

  Widget getVerifyAgeInput() {
    return Container(
      padding: const EdgeInsets.only(left: 4, right: 0, top: 0, bottom: 4),
      child: Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value!;
            });
          },
          activeColor: ThemeApp.primaryColor,
          checkColor: Colors.white,
        ),
        Text(
          CultureService().getLocalResource("login-registrer-age-confirmation"),
          style: ThemeApp.textTheme.bodyMedium?.copyWith(color: ThemeApp.thirdColor),
        ),
      ])
    );
  }

  Widget getRegistrerButton()  {
    return BlocBuilder<NewAccountBloc, NewAccountState>(
      buildWhen: (previous, current) => current is NewAccountInitial || current is NewAccountLoading || current is NewAccountError || current is NewAccountSuccess,
      builder: (context, state) {
        if (state is NewAccountLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ElevatedButton(
              onPressed: () {
                BlocProvider.of<NewAccountBloc>(context).add(DoRegistrer(
                  _accountNameController.text,
                  _passwordController.text,
                  _isChecked)
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeApp.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  foregroundColor: ThemeApp.primaryColor),
              child: Text(
                CultureService().getLocalResource("login-new-account-action"),
                style: ThemeApp.textTheme.bodySmall?.copyWith(color: ThemeApp.primaryColor),
              ));
        }
      });
  }
}