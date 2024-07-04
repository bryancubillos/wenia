import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wenia/core/service/culture_service.dart';
import 'package:wenia/core/utils/style/theme_app.dart';
import 'package:wenia/features/common/message/message.dart';
import 'package:wenia/features/security/profile/bloc/profile_bloc.dart';
import 'package:wenia/features/security/security/bloc/security_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  // [Init state]
  @override
  void initState() {
    super.initState();

    // Get menu options
    context.read<ProfileBloc>().add(DoGetProfileUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Header
          Container(
            padding: const EdgeInsets.only(top: 80, bottom: 20),
              color: ThemeApp.secondColor,
              child: Center(
                child: 
                BlocBuilder<ProfileBloc, ProfileState>(
                  buildWhen: (previous, current) => current is ProfileLoaded,
                  builder: (context, state) {
                    if(state is ProfileLoaded) {
                      if(state.userLoaded == null) {
                        // Read user again
                        context.read<SecurityBloc>().add(DoGetSecurityUser());

                        // Show loading
                        return const Center(child: CircularProgressIndicator());
                      }
                      else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getAvatarIcon(),
                            const SizedBox(height: 15),
                            getUserName(state.userLoaded?.email ?? ""),
                            getUserEmail(state.userLoaded?.displayName ?? "")
                          ]
                        );
                      }
                    }
                    else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }
                ),
              ),
          ),     
          // Body
          Expanded(
            child: Column(
              children: <Widget>[
                getAccount(),
                getChangePassword(),
                const Spacer(),
                getGoOut(),
              ]
            ),
          ),
        ]
      ),
    );
  }

  // [Methods]
  
  // Header
  Widget getAvatarIcon() {
    return CircleAvatar(
      backgroundColor: ThemeApp.white,
      radius: 50,
      child: Container(
        padding: const EdgeInsets.all(27),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: ThemeApp.primaryColor,
            width: 2,
          ),
        ),
        child: const Icon(Icons.person,
          size: 40,
          color: ThemeApp.primaryColor,
        ),
      )
    ); 
  }

  Widget getUserName(String userName) {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child:
        Text(
          userName,
          style: ThemeApp.textTheme.bodyMedium?.copyWith(color: Colors.black45),
          textAlign: TextAlign.center,
        )
    );
  }

  Widget getUserEmail(userEmail) {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 2),
      child:
        Text(
          userEmail,
          style: ThemeApp.textTheme.bodySmall?.copyWith(color: Colors.black45),
          textAlign: TextAlign.center,
        )
    );
  }

  // Body
  Widget getAction(Icon actionIcon, String actionName, Color actionColor, bool topLine, bool bottomLine, VoidCallback onPressedAction) {
    Widget action = Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: TextButton(
            onPressed: onPressedAction,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.only(left: 6.0, right: 6.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  actionName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: actionColor),
                ),
                actionIcon,
              ],
            ),
          ),
        );

    Widget line = const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Divider(color: ThemeApp.secondColor, height: 1)
    );

    List<Widget> result = [];

    if(topLine && bottomLine) {
      result.add(line);
      result.add(action);
      result.add(line);
    }
    else if(topLine) {
      result.add(line);
      result.add(action);
    }
    else {
      result.add(action);
      result.add(line);
    }

    return Column(
      children: result
    );
  }

  Widget getAccount() {
    return getAction(const Icon(Icons.person_outline, color: ThemeApp.thirdColor),
      CultureService().getLocalResource("profile-account"),
      ThemeApp.thirdColor,
      false,
      true,
      () {
      });
  }

  Widget getChangePassword() {
    return getAction(const Icon(Icons.security, color: ThemeApp.thirdColor),
      CultureService().getLocalResource("profile-change-password"),
      ThemeApp.thirdColor,
      false,
      true,
      () {
      });
  }

  Widget getGoOut() {
    return getAction(const Icon(Icons.logout, color: Colors.red),
      CultureService().getLocalResource("profile-log-out"),
      Colors.red,
      true,
      false,
      () {
        // Show message to confim
        Message().showMessageWithActions(context,
          CultureService().getLocalResource("profile-log-out-confirmation"),
          () {
            // Log out user
            context.read<ProfileBloc>().add(DoLogOutProfileUser());
          }
        );       
      });
  }
}