import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../material/colors.dart';

class NilaiDnsList extends StatelessWidget {
  final String namaMatkul, nilai;
  const NilaiDnsList({
    super.key,
    required this.namaMatkul,
    required this.nilai,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10, top: 10),
      decoration: BoxDecoration(
          color: AppColors.blue, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            namaMatkul,
            style: GoogleFonts.lato(
                fontWeight: FontWeight.w600,
                height: 1.2,
                fontSize: 18,
                color: AppColors.white),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 17,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.orange),
            child: Text(
              nilai,
              style: GoogleFonts.lato(
                color: AppColors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
