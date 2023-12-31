import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:spk_app/material/colors.dart';

class PopUp3 extends StatelessWidget {
  final String text, lottieAssets, buttonText;
  final Color textColor;
  final VoidCallback? onAddPressed;
  final bool isTwoTimes;
  const PopUp3({
    super.key,
    required this.text,
    required this.lottieAssets,
    this.onAddPressed,
    this.textColor = AppColors.green,
    this.buttonText = "Selesai",
    this.isTwoTimes = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 30,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.red[90],
                    ),
                    child: LottieBuilder.asset(lottieAssets),
                  ),
                ),
              ],
            ),

            //right button
            Expanded(
              child: TextButton(
                onPressed: () {
                  isTwoTimes ? Navigator.pop(context) : Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: textColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: Text(
                      buttonText,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 24,
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
