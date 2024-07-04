import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wenia/core/utils/style/theme_app.dart';
import 'package:wenia/features/common/menu/bloc/menu_bloc.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // [Properties]

  // [Init state]
  @override
  void initState() {
    super.initState();
    
    // Get menu options
    context.read<MenuBloc>().add(DoGetMenu());
  }
  
  // [Build]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MenuBloc, MenuState>(
        buildWhen: (previous, current) => current is MenuLoaded,
        builder: (context, state) {
          if (state is MenuLoaded) {
            final pages = state.pages;
            final selectedIndex = state.selectedIndex;
            return pages[selectedIndex];
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: BlocBuilder<MenuBloc, MenuState>(
        buildWhen: (previous, current) => current is MenuLoaded,
        builder: (context, state) {
          if (state is MenuLoaded) {
            return BottomNavigationBar(
              backgroundColor: ThemeApp.white,
              items: state.menuItems,
              currentIndex: state.selectedIndex,
              selectedItemColor: ThemeApp.primaryColor,
              onTap: (index) {
                context.read<MenuBloc>().add(DoChangePage(index));
              },
            );
          }
          return Container(height: 0);
        }),
    );
  }
}