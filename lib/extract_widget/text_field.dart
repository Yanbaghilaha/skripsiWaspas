import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spk_app/material/colors.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    this.hintText = "",
    this.labelText = "",
    this.maxLines = 1,
    this.readOnly = false,
    this.showPassword = false,
    required this.controller,
    this.keyboardType = false,
    this.autoFill,
    this.showHint = false,
    this.textController = "",
    this.isShowLabelText = false,
    this.textAlign = TextAlign.start,
    this.textColor = AppColors.white2,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
  });

  final TextEditingController controller;
  final String hintText, labelText, textController;
  final Iterable<String>? autoFill;
  final int maxLines;
  final TextAlign textAlign;
  final Color textColor;
  final bool readOnly, showPassword, keyboardType, showHint, isShowLabelText;

  final ValueChanged<String>? onChanged, onEditingComplete, onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: double.infinity,
      child: TextField(
        onEditingComplete: () {
          onEditingComplete;
        },
        textAlign: textAlign,
        maxLines: maxLines,
        controller: controller,
        readOnly: readOnly,
        onChanged: (value) {
          onChanged!(value);
        },
        onTap: () {
          onTap;
        },
        autocorrect: false,
        keyboardType: keyboardType ? TextInputType.number : TextInputType.name,
        style: GoogleFonts.lato(
          textStyle: TextStyle(
            color: textColor,
          ),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        obscureText: showPassword,
        showCursor: true,
        cursorWidth: 4,
        cursorColor: AppColors.blue,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Colors.white12,
          ),
          labelText: isShowLabelText ? labelText : null,
          contentPadding: const EdgeInsets.all(20),
          labelStyle: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white30,
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
      ),
    );
  }
}
