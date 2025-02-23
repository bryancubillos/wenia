import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wenia/features/common/menu/presentation/menu_page.dart';
import 'package:wenia/features/common/welcome/presentation/welcome_page.dart';
import 'package:wenia/features/security/security/bloc/security_bloc.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  // [Init state]
  @override
  void initState() {
    super.initState();

    // Get current user
    context.read<SecurityBloc>().add(DoGetSecurityUser());
  }

  // [Build]
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<SecurityBloc, SecurityState>(
      builder: (context, state) {
        if (state is SecurityLoaded) {
          if (state.user != null && state.user!.email != null && state.user!.email!.isNotEmpty) {
            return const MenuPage();
          } else {
            return const WelcomePage();
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    ));
  }
}