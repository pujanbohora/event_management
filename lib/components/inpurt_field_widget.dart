import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget inputFieldWidget({required String title, required TextEditingController controller}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFFFDE8DE)),
      borderRadius: BorderRadius.circular(10),
      color: const Color(0xFFFDE8DE),
    ),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: const EdgeInsets.fromLTRB(18.3, 18, 18.3, 18),
        hintText: title,
        hintStyle: GoogleFonts.getFont(
          'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: const Color(0xFF626262),
        ),
      ),
      style: GoogleFonts.getFont(
        'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: const Color(0xFF626262),
      ),
    ),
  );
}
