part of 'menu_bloc.dart';

sealed class MenuEvent {
  const MenuEvent();
}

class DoGetMenu extends MenuEvent {}

class DoChangePage extends MenuEvent {
  final int index;

  const DoChangePage(this.index);
}

class DoLogout extends MenuEvent {}