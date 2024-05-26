import 'dart:async';
import 'dart:convert';

import 'package:eventmanagement/screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/repositories/user_repository.dart';
import '../config/preference_utils.dart';
import '../helper/snack_this.dart';
import '../model/response/login_response.dart';
import '../viewModel/common_view_model.dart';
import 'login_screen.dart';
import 'navigation_screen.dart';

class Splashscreen extends StatefulWidget {
  static const String routeName = "/";
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  late CommonViewModel commonViewModel;

  final SharedPreferences localStorage = PreferenceUtils.instance;
  @override
  void initState() {
    super.initState();

    _checkLogin();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      commonViewModel = Provider.of<CommonViewModel>(context, listen: false);
    });
  }

  Future<void> _checkLogin() async {
    print("LOGIN CHECK:::");
    Timer(const Duration(seconds: 2), () async {
      if (localStorage.getString('token') != null) {

        print(localStorage.getString('token'));

        String? username = localStorage.getString('username');
        String? password = localStorage.getString('password');

        String data = jsonEncode({
          "email": username,
          "password": password,
        });

        try {
          final result = await UserRepository().loginUser(data);;
          if (result.success == true) {
            Navigator.pop(context);
            commonViewModel.setNavigationIndex(0);
            print("logged in using internet");
            // Navigator.of(context).pushNamed('/Pagerview');
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Navigation(currentIndex: 0),
                ));
          } else {
            localStorage.clear();
            snackThis(
              context: context,
              content: const Text("please check credentials and try again"),
              color: Colors.red.shade700,
            );
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const WelcomeScreen()));
          }
        } catch (e) {
          localStorage.clear();
          print("CATCH " + e.toString());
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const WelcomeScreen()));
          snackThis(
            context: context,
            content: Text(e.toString()),
            color: Colors.red.shade700,
          );
        }
      }
      else {
        print("TOKEN NOT FOUND:::");
        localStorage.clear();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const WelcomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/appLogo.png",
                  width: MediaQuery.of(context).size.width / 2,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Center(child: CircularProgressIndicator()),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 50.0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                          child: Text(
                            'Version: 1.0.0',
                            style: TextStyle(color: Colors.grey),
                          )),
                    ],
                  )),
            ),

          ],
        ),
      ),
    );
  }
}
