import 'package:easy_bank/core/common/widgets/app_bar.dart';
import 'package:easy_bank/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const BottomNavBar({super.key, required this.navigationShell});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: MyAppBar(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 28,
          currentIndex: widget.navigationShell.currentIndex,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Theme.of(context).textTheme.bodyMedium!.color!,
          elevation: 48,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
                icon: Icon(
              Icons.home,
              color: widget.navigationShell.currentIndex == 0
                  ? AppColors.primary
                  : Theme.of(context).textTheme.bodyMedium!.color!,
            )),
            BottomNavigationBarItem(
                label: 'History',
                icon: Icon(
              Icons.history,
              color: widget.navigationShell.currentIndex == 1
                  ? AppColors.primary
                  : Theme.of(context).textTheme.bodyMedium!.color!,
            )),
            BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(
              Icons.person,
              color: widget.navigationShell.currentIndex == 2
                  ? AppColors.primary
                  : Theme.of(context).textTheme.bodyMedium!.color!,
            )),
          ]),
    );
  }
}
