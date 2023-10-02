import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../material/colors.dart';

class TextFieldPopUp extends StatelessWidget {
  const TextFieldPopUp({
    super.key,
    this.showSuffixIcon = true,
    required this.hintText,
    required this.controller,
    this.onChange,
    this.maxLines = 1,
  });

  final bool showSuffixIcon;
  final TextEditingController controller;
  final String hintText;
  final Function? onChange;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: true,
      // keyboardType: TextInputType.number,
      style: GoogleFonts.lato(
        textStyle: const TextStyle(
          color: Colors.black,
        ),
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      onChanged: (v) {
        onChange!(v);
      },
      showCursor: true,
      maxLines: maxLines,
      cursorWidth: 4,
      cursorColor: AppColors.blue,
      decoration: InputDecoration(
        suffixIcon: showSuffixIcon
            ? GestureDetector(
                onTap: () {
                  controller.clear();
                },
                child: const Icon(
                  PhosphorIcons.x_circle_fill,
                  color: Colors.black45,
                ),
              )
            : null,
        hintText: hintText,
        hintStyle: GoogleFonts.lato(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: Colors.black26,
        ),
        contentPadding: const EdgeInsets.all(20),
        border: InputBorder.none,
        fillColor: AppColors.white2,
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
