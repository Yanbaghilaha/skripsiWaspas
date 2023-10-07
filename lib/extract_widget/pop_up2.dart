import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:spk_app/extract_widget/text_field_popup.dart';

import '../material/colors.dart';

class PopUp2 extends StatefulWidget {
  const PopUp2(
      {super.key,
      required this.namaTema,
      required this.textButton,
      required this.hintTextTextField,
      required this.showSuffixIconTextField,
      required this.isTextField,
      this.buttonColor = AppColors.blue,
      this.height = 300,
      this.lottieAssets = "",
      required this.lottieAssetsVisible,
      this.onPressed,
      required this.controller,
      this.onEditPressed,
      this.onDeletePressed,
      this.onAddPressed});

  final String namaTema, textButton, hintTextTextField, lottieAssets;
  final Color buttonColor;
  final double height;
  final bool showSuffixIconTextField, isTextField, lottieAssetsVisible;
  final VoidCallback? onPressed, onEditPressed, onDeletePressed, onAddPressed;
  final TextEditingController controller;
  // final VoidCallback okButton;

  @override
  State<PopUp2> createState() => _PopUp2State();
}

class _PopUp2State extends State<PopUp2> {
  final List ulaskanButtonList = [
    [
      "Ditolak",
      false,
    ],
    [
      "Diterima",
      false,
    ],
  ];

  void temaTypeSelected(int index) {
    setState(() {
      for (int i = 0; i < ulaskanButtonList.length; i++) {
        ulaskanButtonList[i][1] = false;
      }
      ulaskanButtonList[index][1] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
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
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.namaTema,
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              widget.isTextField
                  ? TextFieldPopUp(
                      controller: widget.controller,
                      showSuffixIcon: widget.showSuffixIconTextField,
                      hintText: widget.hintTextTextField,
                    )
                  : widget.lottieAssetsVisible
                      ? Center(
                          child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.red[90],
                            ),
                            child: LottieBuilder.asset(widget.lottieAssets),
                          ),
                        )
                      : Flexible(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return Container(
                                child: const Text(""),
                              );
                            },
                            separatorBuilder: (context, index) => Container(
                              width: 20,
                            ),
                            itemCount: 2,
                          ),
                        )
            ]),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: Text(
                          "Batal",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            fontSize: 24,
                            color: Colors.black38,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //right button
                Expanded(
                  child: TextButton(
                    onPressed: widget.onAddPressed,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: widget.buttonColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        child: Text(
                          widget.textButton,
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
          ],
        ),
      ),
    );
  }
}

class UlaskanBotton extends StatelessWidget {
  const UlaskanBotton({
    super.key,
    required this.text,
    required this.buttonColor,
    this.onTap,
    required this.isSelected,
  });
  final String text;
  final Color buttonColor;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(color: AppColors.blue, width: 5)
              : Border.all(color: Colors.transparent, width: 0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 55,
          ),
          child: Text(
            text,
            style: GoogleFonts.lato(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
