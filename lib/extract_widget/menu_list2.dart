import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../material/colors.dart';

class MenuList2 extends StatelessWidget {
  const MenuList2({
    super.key,
    required this.judul,
    required this.subJudul,
    required this.picture,
    required this.rightButton,
    required this.ketikaDiTekan,
    required this.color,
    required this.textColor,
  });

  final String judul, subJudul, rightButton, picture;
  final Color color, textColor;
  final Function ketikaDiTekan;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ketikaDiTekan();
      },
      child: Container(
        padding: const EdgeInsets.only(
          right: 10,
          left: 10,
          top: 20,
          bottom: 10,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child: Column(
          children: [
            Text(
              judul,
              style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: textColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              subJudul,
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              picture,
              fit: BoxFit.fill,
              width: 200,
            ),
            const SizedBox(
              height: 20,
            ),

            //button
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: TextButton(
                    onPressed: () {
                      ketikaDiTekan();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(null),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            rightButton,
                            style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: AppColors.violet),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            PhosphorIcons.arrow_right_bold,
                            size: 20,
                            color: AppColors.violet,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
