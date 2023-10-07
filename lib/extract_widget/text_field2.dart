import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spk_app/material/colors.dart';

class MyTextField2 extends StatelessWidget {
  const MyTextField2({
    super.key,
    this.hintText = "",
    required this.labelText,
    this.maxLines = 1,
    this.readOnly = false,
    required this.myText,
  });

  final String hintText, labelText, myText;
  final int maxLines;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(
        text: myText,
      ),
      maxLines: maxLines,
      autofocus: true,
      readOnly: readOnly,
      keyboardType: TextInputType.number,
      style: GoogleFonts.lato(
        textStyle: const TextStyle(
          color: Colors.white60,
        ),
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      showCursor: true,
      cursorWidth: 4,
      cursorColor: AppColors.blue,
      decoration: InputDecoration(
        // hintText: hintText,
        hintStyle: GoogleFonts.lato(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: const Color(0xff505668),
        ),
        labelText: labelText,
        contentPadding: const EdgeInsets.all(20),
        labelStyle: GoogleFonts.lato(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white60,
        ),
        border: InputBorder.none,
        fillColor: const Color(0xff282B34),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xff505668),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white60,
          ),
        ),
      ),
    );
  }
}
