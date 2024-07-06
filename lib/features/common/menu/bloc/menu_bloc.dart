import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:wenia/core/service/culture_service.dart';
import 'package:wenia/features/crypto/list/presentation/crypto_list_page.dart';
import 'package:wenia/features/security/profile/presentation/profile_page.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  
  // [Properties]
  static int selectedIndex = 0;
  static List<BottomNavigationBarItem> menuItems = [];
  static List<Widget> pages = [];

  MenuBloc() : super(MenuInitial()) {
    // All events
    on<DoGetMenu>(_onGetMenu);
    on<DoChangePage>(_onChangePage);
    on<DoLogout>(_onLogout);
  }

  // [Events]
  Future<void> _onGetMenu(DoGetMenu event, Emitter<MenuState> emit) async {    
    // Prepare the menu items
    MenuBloc.menuItems = [
      BottomNavigationBarItem(
        icon: const Icon(Icons.monetization_on),
        label: CultureService().getLocalResource('menu-coins'),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        label: CultureService().getLocalResource('menu-profile'),
      ),
    ];

    // Prepare pages by index
    MenuBloc.pages = <Widget>[
      const CryptoListPage(),
      const ProfilePage()
    ];

    emit(MenuLoaded(MenuBloc.menuItems, MenuBloc.pages, MenuBloc.selectedIndex));
  }

  Future<void> _onChangePage(DoChangePage event, Emitter<MenuState> emit) async {
    // Save the selected index
    MenuBloc.selectedIndex = event.index;
    emit(MenuLoaded(MenuBloc.menuItems, MenuBloc.pages, MenuBloc.selectedIndex));
  }

  Future<void> _onLogout(DoLogout event, Emitter<MenuState> emit) async {
    MenuBloc.selectedIndex = 0;
  }
}
