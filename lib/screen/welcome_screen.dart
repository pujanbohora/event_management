import 'package:eventmanagement/helper/sizebox_ex.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/button_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF9F9F9),
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(25, 109, 25, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome to the world of',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Poppins',
                    fontWeight: FontWeight.w300,
                    fontSize: 25,
                    color: const Color(0xFFAC3029),
                  ),
                ),
                Text(
                  'world',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Poppins',
                    fontWeight: FontWeight.w300,
                    fontSize: 25,
                    color: const Color(0xFFAC3029),
                  ),
                ),
                Text(
                  'of',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Poppins',
                    fontWeight: FontWeight.w300,
                    fontSize: 25,
                    color: const Color(0xFFAC3029),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 53),
                  width: 344,
                  height: 297,
                  child:
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/appLogo.png',
                        ),
                      ),
                    ),
                    child: const SizedBox(
                      // width: 344,
                      // height: 297,
                    ),
                  ),
                ),
                SignUpButtonWidget(
                  title: "Sign Up",
                  onPressed: () {
                    Navigator.pushNamed(context, "/register");
                    // Define your onPressed functionality here
                    print('Sign Up button pressed');
                  },
                ),
                20.sH,
                InkWell(
                  onTap: (){
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
            ),
          ),
        ),
      )
    );
  }
}
