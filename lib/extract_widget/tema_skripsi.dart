import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../material/colors.dart';

class TemaSkripsi extends StatelessWidget {
  const TemaSkripsi({
    super.key,
    required this.text,
    required this.isSelected,
    this.onTap,
  });

  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.border,
          ),
          color: isSelected ? AppColors.blue : Colors.white10,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 35,
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.lato(
                color: AppColors.white,
                fontWeight: FontWeight.w800,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
