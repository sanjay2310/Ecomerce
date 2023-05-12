import 'package:amazone_app1/constant/global_variable.dart';
import 'package:amazone_app1/features/acccount/widgets/below_appbar.dart';
import 'package:amazone_app1/features/acccount/widgets/orders.dart';
import 'package:amazone_app1/features/acccount/widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "assets/images/amazon_in.png",
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(Icons.notifications_outlined),
                  ),
                  Icon(Icons.search),
                ]),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: const [
          BelowAppBar(),
          SizedBox(
            height: 10,
          ),
          TopButton(),
          SizedBox(
            height: 10,
          ),
          Orders()
        ],
      ),
    );
  }
}
