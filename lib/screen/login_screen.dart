import 'dart:convert';

import 'package:eventmanagement/helper/sizebox_ex.dart';
import 'package:eventmanagement/helper/snack_this.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

import '../api/repositories/user_repository.dart';
import '../components/button_widget.dart';
import '../components/inpurt_field_widget.dart';
import '../config/preference_utils.dart';
import '../helper/custom_loader.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SharedPreferences localStorage = PreferenceUtils.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  bool passwordVisible = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF9F9F9),
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(25, 29.5, 25, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                20.sH,
                Container(
                  width: 127,
                  height: 115,
                  decoration: const BoxDecoration(
                  ),
                  child:
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/images/appLogo.png",
                        ),
                      ),
                    ),
                    child: Container(
                      // width: 127,
                      // height: 115,
                    ),
                  ),
                ),
                Container(
                  // margin: EdgeInsets.fromLTRB(7, 0, 0, 44),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(23.4, 0, 23.4, 51),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'LOGIN HERE',
                            style: GoogleFonts.getFont(
                              'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 32,
                              color: const Color(0xFFAC3029),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Welcome back you’ve ',
                      textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: const Color(0xFF000000),
                        ),
                      ),
                      Text(
                        'been missed!!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                ),
                20.sH,
                inputFieldWidget(
                  title: 'Email',
                  controller: _emailController,
                ),
                20.sH,
                // inputFieldWidget(
                //   title: 'Password',
                //   controller: _passwordController,
                // ),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFFDE8DE)),
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFFDE8DE),
                ),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.fromLTRB(18.3, 18, 18.3, 18),
                    hintText: "Password",
                    hintStyle: GoogleFonts.getFont(
                      'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: const Color(0xFF626262),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                  style: GoogleFonts.getFont(
                    'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: const Color(0xFF626262),
                  ),
                ),
              ),
                20.sH,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SignUpButtonWidget(
                    title: "Sign in",
                    onPressed: () async{
                      try{
                        customLoadStart();
                        String data = jsonEncode({
                          "email": _emailController.text,
                          "password": _passwordController.text,
                        });
                        print("DATA::::$data");
                        final res = await UserRepository().loginUser(data);

                        print("RES::${res.message}");

                        if (res.success == true) {
                          toastification.show(
                              context: context,
                              icon: Icon(Icons.check_circle, color: Colors.green,),
                              title: Text("Login Success"),
                              autoCloseDuration: const Duration(seconds: 2),
                              showProgressBar: false
                          );

                          if(context.mounted){
                            localStorage.setString("_auth_", jsonEncode(res.user));
                            localStorage.setString("token", res.token.toString());
                            localStorage.setString("username", _emailController.text);
                            localStorage.setString("password", _passwordController.text);

                            _emailController.clear();
                            _passwordController.clear();

                            Navigator.pushReplacementNamed(context, "/navigation");
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
                    },
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
