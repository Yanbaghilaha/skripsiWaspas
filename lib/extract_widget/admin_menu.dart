import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../material/colors.dart';

class AdminMenu extends StatelessWidget {
  const AdminMenu({
    super.key,
    required this.subJudul,
    required this.judul,
    required this.imageAssets,
    required this.colorBackgroundIcon,
    required this.onTap,
  });

  final String subJudul, judul, imageAssets;
  final Color colorBackgroundIcon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: IntrinsicHeight(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.whiteLight,
              border: Border.all(
                color: Colors.white24,
              ),
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 10, right: 10, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //image preview
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorBackgroundIcon,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Image.asset(
                        imageAssets,
                        height: 170,
                      ),
                    ),
                  ),
                  //end image

                  const SizedBox(
                    height: 20,
                  ),
                  //Judul
                  Text(
                    judul,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.lato(
                      color: AppColors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  //end Judul

                  //subtitle
                  Text(
                    subJudul,
                    style: GoogleFonts.lato(
                      color: Colors.white54,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                  //end subtitle
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
