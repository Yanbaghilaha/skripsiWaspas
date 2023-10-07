import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../material/colors.dart';

class ListJudulSkripsi extends StatelessWidget {
  const ListJudulSkripsi({super.key, required this.judul, required this.tema});

  final String judul, tema;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xff282B34),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.white30)),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          tema,
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 280,
                    child: Text(
                      judul,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                        fontSize: 18,
                      ),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            ],
          ),
          const Icon(
            IconlyLight.arrow_right_2,
            color: AppColors.white,
          )
        ],
      ),
    );
  }
}
