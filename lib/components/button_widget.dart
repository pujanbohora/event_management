import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const SignUpButtonWidget({Key? key, required this.onPressed, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFBB1F1F),
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.getFont(
                'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: const Color(0xFFFFFFFF),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
