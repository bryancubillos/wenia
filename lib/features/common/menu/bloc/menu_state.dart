part of 'menu_bloc.dart';

sealed class MenuState {
  const MenuState();
}

// [Life cicle]
final class MenuInitial extends MenuState {}

// [States]
final class MenuLoaded extends MenuState {
  final List<BottomNavigationBarItem> menuItems;
  final List<Widget> pages;
  final int selectedIndex;

  MenuLoaded(this.menuItems, this.pages, this.selectedIndex);
}