import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../material/colors.dart';

class MyNavBar extends StatelessWidget {
  const MyNavBar({super.key, required this.judul});
  final String judul;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            IconlyLight.arrow_left_2,
            color: AppColors.white,
            size: 24,
          ),
        ),
        SizedBox(
          child: Center(
            child: Text(
              judul,
              style: GoogleFonts.lato(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: AppColors.orange),
            ),
          ),
        ),
        const Icon(null),
      ],
    );
  }
}
