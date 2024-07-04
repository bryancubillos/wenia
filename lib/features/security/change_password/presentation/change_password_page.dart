import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wenia/core/config/environment_config.dart';
import 'package:wenia/core/service/culture_service.dart';
import 'package:wenia/core/utils/style/theme_app.dart';
import 'package:wenia/features/common/message/message.dart';
import 'package:wenia/features/security/change_password/bloc/change_password_bloc.dart';
import 'package:wenia/features/security/profile/bloc/profile_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  // [Properties]
  bool _hidePassword = true;
  final TextEditingController _passwordController = TextEditingController();

  // [Contructor]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          CultureService().getLocalResource("security-change-password-title"),
          style: ThemeApp.textTheme.bodyLarge?.copyWith(color: Colors.black45)
        ),
      ),
      body: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordError) {
            if(state.message.isNotEmpty) {
              Message().showMessage(context, CultureService().getLocalResource(state.message));
            }
          }
          else if(state is ChangePasswordSuccess) {
            // Close register page
            Navigator.pop(context);
            
            // Get menu page
            context.read<ProfileBloc>().add(DoNotifyChangePasswordProfileUser());
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              getNewPassword(),
              const SizedBox(height: 15),
              getLoginButton(),
            ]
          )
        )
      )
    );
  }

  // [Methods]
  Widget getNewPassword()  {
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
          labelText: CultureService().getLocalResource("security-change-password-action"),
          border: InputBorder.none,
          counterText: "",
          labelStyle: ThemeApp.textTheme.bodyMedium?.copyWith(color: ThemeApp.thirdColor),
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
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) => current is ChangePasswordInitial || current is ChangePasswordLoading || current is ChangePasswordError,
      builder: (context, state) {
        if (state is ChangePasswordLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ElevatedButton(
              onPressed: () {
                BlocProvider.of<ChangePasswordBloc>(context).add(DoChangePassword(
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
                CultureService().getLocalResource("security-change-password-action"),
                style: ThemeApp.textTheme.bodySmall?.copyWith(color: ThemeApp.primaryColor),
              ));
        }
      });
  }
}
