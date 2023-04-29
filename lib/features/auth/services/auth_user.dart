import 'dart:convert';

import 'package:amazone_app1/comman/widgets/bottom_bar.dart';
import 'package:amazone_app1/constant/error_handling.dart';
import 'package:amazone_app1/constant/global_variable.dart';
import 'package:amazone_app1/constant/utils.dart';
import 'package:amazone_app1/models/user.dart';
import 'package:amazone_app1/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: "",
        token: '',
      );
      //   cart: []);

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; Charset=UTF-8'
        },
      );
      // ignore: use_build_context_synchronously
      httpErorHandler(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
              context, "Account has created! Login with the same credentials");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({"email": email, "password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json; Charset=UTF-8'
        },
      );

      // ignore: use_build_context_synchronously
      httpErorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          // ignore: use_build_context_synchronously
          Provider.of<UserProvider>(
            context,
            listen: false,
          ).setUser(res.body);
          await pref.setString('x-auth-tokem', jsonDecode(res.body)['token']);
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(
              context, BottomBar.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    // get User data
   
  }

   void getUserData(
      BuildContext context,
    ) async {
      try {
        SharedPreferences pref = await SharedPreferences.getInstance();
        String? token = pref.getString('x-auth-token');
        if (token == null) {
          pref.setString(
            'x-auth-token',
            '',
          );
        }

        http.Response tokenRes = await http
            .post(Uri.parse('$uri/validIsToken'), headers: <String, String>{
          'Content-Type': 'application/json; Charset=UTF-8',
          'x-auth-token': token!,
        });
        var response = jsonDecode(tokenRes.body);
        if (response == true) {
          http.Response userRes =
              await http.get(Uri.parse('$uri/'), headers: <String, String>{
            'Content-Type': 'application/json; Charset=UTF-8',
            'x-auth-token': token,
          });
          // ignore: use_build_context_synchronously
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setUser(userRes.body);
        }
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    }
}
