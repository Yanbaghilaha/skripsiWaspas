import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../material/colors.dart';

class PercentageMatkul extends StatelessWidget {
  const PercentageMatkul({
    super.key,
    required this.namaMatkul,
    this.forHistory = false,
    required this.percentage,
    required this.lengthPercent,
  });

  final String namaMatkul, percentage;
  final double lengthPercent;
  final bool forHistory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                namaMatkul,
                style: GoogleFonts.lato(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    percentage,
                    style: GoogleFonts.lato(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "%",
                    style: GoogleFonts.lato(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xff3A3B77),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              forHistory
                  ? Container(
                      width: lengthPercent * 55,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(40),
                      ),
                    )
                  : Container(
                      width: lengthPercent * 75,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(40),
                      ),
                    )
            ],
          )
        ],
      ),
    );
  }
}
