import 'package:amazone_app1/comman/widgets/bottom_bar.dart';
import 'package:amazone_app1/features/admin/screens/add_product_screen.dart';
import 'package:amazone_app1/features/auth/screens/auth_screen.dart';
import 'package:amazone_app1/features/home/screens/category_deal_screen.dart';
import 'package:amazone_app1/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case AddProduct.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProduct(),
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Text('Dont exist'),
        ),
      );
  }
}
