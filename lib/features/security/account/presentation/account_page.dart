import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wenia/core/Entities/security/user_entity.dart';

import 'package:wenia/core/service/culture_service.dart';
import 'package:wenia/core/utils/style/theme_app.dart';
import 'package:wenia/features/common/message/message.dart';
import 'package:wenia/features/security/account/bloc/account_bloc.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // [Properties]
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  // [Init state]
  @override
  void initState() {
    super.initState();

    // Get current user
    context.read<AccountBloc>().add(DoAccountLoad());
  }

  // [Contructor]
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text(
          CultureService().getLocalResource("account-title"),
          style: ThemeApp.textTheme.bodyLarge?.copyWith(color: Colors.black45)
        ),
      ),
      body: BlocListener<AccountBloc, AccountState>(
        listener: (context, state) {
          if(state is AccountSuccess) {
            if(state.message != null && state.message!.isNotEmpty) {
              Message().showMessage(context, CultureService().getLocalResource(state.message ?? ""));
            }
          }
          else if(state is AccountError) {
            if(state.message != null && state.message!.isNotEmpty) {
              Message().showMessage(context, CultureService().getLocalResource(state.message ?? ""));
            }
          }
        },
        child: SafeArea(
          child: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              UserEntity? user;

              if(state is AccountLoaded) {
                user = state.user;
              }

              if(user == null) {
                return const Center(child: CircularProgressIndicator());
              }else {
                return Column(
                  children: [
                    getUserEmail(user),
                    getUserName(user),
                    getUserId(user),
                    getUserBirthday(user),
                    const SizedBox(height: 15),
                    getSaveAction()
                  ]
                );
              }
            },
          )
        )
      )
    );
  }

  // [Methods]
  Widget getFieldBase(String titleInput, TextEditingController controllerField, UserEntity user, bool diabledField) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 14, right: 18, top: 4, bottom: 4),
      padding: const EdgeInsets.only(left: 14, right: 0, top: 4, bottom: 4),
      decoration: BoxDecoration(
        border: Border.all(color: ThemeApp.secondColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        readOnly: diabledField,
        controller: controllerField,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@ /._-]')),
        ],
        style: ThemeApp.textTheme.bodyLarge?.copyWith(color: diabledField ? ThemeApp.grey : Colors.black),
        decoration: InputDecoration(
          labelText: CultureService().getLocalResource(titleInput),
          border: InputBorder.none,
          counterText: "",
          labelStyle: ThemeApp.textTheme.bodyMedium?.copyWith(color: ThemeApp.thirdColor),
        ),
      ),
    );
  }

  Widget getUserEmail(UserEntity user) {
    TextEditingController userEmailController = TextEditingController();
    userEmailController.text = user.email ?? "";

    return getFieldBase("account-email", userEmailController, user, true);
  }

  Widget getUserName(UserEntity user) {
    _nameController.text = user.name ?? "";

    return getFieldBase("account-name", _nameController, user, false);
  }

  Widget getUserId(UserEntity user) {
    _idController.text = user.userId ?? "";

    return getFieldBase("account-id", _idController, user, false);
  }

  Widget getUserBirthday(UserEntity user) {
    _birthdayController.text = user.birthDate != null ? user.birthDate.toString() : "";

    return getFieldBase("account-birthday", _birthdayController, user, false);
  }

  Widget getSaveAction() {
    return BlocBuilder<AccountBloc, AccountState>(
      buildWhen: (previous, current) => current is AccountInitial || current is AccountLoaded,
      builder: (context, state) {
        if (state is AccountLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ElevatedButton(
              onPressed: () {
                UserEntity currentUser = UserEntity();
                
                currentUser.name = _nameController.text;
                currentUser.userId = _idController.text;
                currentUser.birthDate = DateTime.now();
                
                // Action save in BLOC
                BlocProvider.of<AccountBloc>(context).add(DoAccountUpdate(currentUser));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeApp.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  foregroundColor: ThemeApp.primaryColor),
              child: Text(
                CultureService().getLocalResource("account-save-action"),
                style: ThemeApp.textTheme.bodySmall?.copyWith(color: ThemeApp.primaryColor),
              ));
        }
      });
  }
}