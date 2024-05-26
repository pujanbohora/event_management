import 'dart:convert';

import 'package:eventmanagement/api/repositories/user_repository.dart';
import 'package:eventmanagement/helper/sizebox_ex.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

import '../components/button_widget.dart';
import '../components/inpurt_field_widget.dart';
import '../helper/custom_loader.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool passwordVisible = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(),
      body: Form(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF9F9F9),
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                      width: 127,
                      height: 115,
                    ),
                  ),
                  20.sH,
                  Container(
                    margin: const EdgeInsets.fromLTRB(1, 0, 0, 32),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        child:
                        Text(
                          'CREATE AN ACCOUNT',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 27,
                            color: Color(0xFFAC3029),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      inputFieldWidget(
                        title: 'Enter your text',
                        controller: _fullNameController,
                      ),
                      20.sH,
                      inputFieldWidget(
                        title: 'Contact No',
                        controller: _contactController,
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
                          title: "Sign Up",
                          onPressed: () async{
                            try{
                              customLoadStart();
                              String data = jsonEncode({
                                "fullname": _fullNameController.text,
                                "contact": _contactController.text,
                                "email": _emailController.text,
                                "password": _passwordController.text,
                              });
                              print("DATA::::$data");
                              final res = await UserRepository().registerUser(data);

                              _fullNameController.clear();
                              _contactController.clear();
                              _emailController.clear();
                              _passwordController.clear();

                              if (res.success == true) {
                                toastification.show(
                                    context: context,
                                    icon: Icon(Icons.check_circle, color: Colors.green,),
                                    title: Text(res.message.toString()),
                                    autoCloseDuration: const Duration(seconds: 2),
                                    showProgressBar: false
                                );

                                if(context.mounted){
                                  Navigator.pushNamed(context, "/login");
                                }
                              } else {
                                toastification.show(
                                    context: context,
                                    icon: Icon(Icons.warning, color: Colors.red,),
                                    title: Text(res.message.toString()),
                                    autoCloseDuration: const Duration(seconds: 2),
                                    showProgressBar: false
                                );
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
                      20.sH,
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/login");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFB9BCBE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child:
                            Center(
                              child: Text(
                                'Already have an account',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: const Color(0xFF494949),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
