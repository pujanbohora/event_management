import 'dart:convert';

import 'package:eventmanagement/screen/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

import '../api/repositories/user_repository.dart';
import '../components/profile_menu_widget.dart';
import '../config/preference_utils.dart';
import '../helper/custom_loader.dart';
import '../helper/snack_this.dart';
import '../model/response/login_response.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  final SharedPreferences localStorage = PreferenceUtils.instance;

  User? user;

  getUser() async {
    String? userData = localStorage.getString('_auth_');
    Map<String, dynamic> userMap = json.decode(userData!);
    User userD = User.fromJson(userMap);
    setState(() {
      user = userD;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.getFont(
            'Raleway',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: const Color(0xFF1B153D),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(image: AssetImage("assets/images/appLogo.png"))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.yellow),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(user?.fullname ?? "N/A", ),
              const Text("Event Manager"),
              const SizedBox(height: 20),

              /// -- BUTTON
              // SizedBox(
              //   width: 200,
              //   child: ElevatedButton(
              //     onPressed: () {
              //       Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateProfileScreen()));
              //     },
              //     style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.black, side: BorderSide.none, shape: const StadiumBorder()),
              //     child: const Text("tEditProfile", style: TextStyle(color: Colors.black)),
              //   ),
              // ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: Icons.logout,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    showAlertDialog(context, localStorage);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context,SharedPreferences localStorage) {

    // set up the button
    Widget okButton = TextButton(
      child: const Text("Log out"),
      onPressed: () async{
        try{
          customLoadStart();
          final res = await UserRepository().logOutUser();

          print("RES::${res.message}");

          if (res.success == true) {
            toastification.show(
                context: context,
                icon: Icon(Icons.check_circle, color: Colors.green,),
                title: Text("Logout Success"),
                autoCloseDuration: const Duration(seconds: 2),
                showProgressBar: false
            );

            if(context.mounted){
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
              localStorage.clear();

            }
          } else {
            errorSnackThis(
                content: Text(res.message.toString()),
                context: context);
          }

        } on Exception catch (e) {
          toastification.show(
              context: context,
              icon: Icon(Icons.warning, color: Colors.red,),
              title: Text(e.toString()),
              autoCloseDuration: const Duration(seconds: 2),
              showProgressBar: false
          );

        }finally {
          customLoadStop();

        }
      }
    );

    // set up the button
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: const Text("Are you sure? You want to log out"),
      actions: [
        okButton,
        cancelButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
