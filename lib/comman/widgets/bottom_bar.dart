import 'package:amazone_app1/constant/global_variable.dart';
import 'package:amazone_app1/features/acccount/screens/account_screen.dart';
import 'package:amazone_app1/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class BottomBar extends StatefulWidget {
  static const String routeName = "/actual-home";
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const Text('cart')
  ];
  final double bottombarwidth = 42;
  int _page = 0;
  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottombarwidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 0
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottombarwidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 1
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor),
                ),
              ),
              child: const Icon(Icons.person_outline_outlined),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Container(
                width: bottombarwidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: _page == 2
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor),
                  ),
                ),
                child: const badges.Badge(
                  badgeContent: Text('2'),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Colors.white,
                  ),
                  child: Icon(Icons.shopping_cart_outlined),
                )),
            label: "",
          ),
        ],
      ),
    );
  }
}
