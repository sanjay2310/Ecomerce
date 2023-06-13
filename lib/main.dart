import 'package:amazone_app1/comman/widgets/bottom_bar.dart';
import 'package:amazone_app1/constant/global_variable.dart';
import 'package:amazone_app1/features/admin/screens/admin_screen.dart';
import 'package:amazone_app1/features/auth/screens/auth_screen.dart';
import 'package:amazone_app1/features/auth/services/auth_user.dart';
import 'package:amazone_app1/provider/user_provider.dart';
import 'package:amazone_app1/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amazon Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          if (userProvider.user.token.isNotEmpty) {
            if (userProvider.user.type == 'user') {
              return const BottomBar();
            } else {
              return const AdminScreen();
            }
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
