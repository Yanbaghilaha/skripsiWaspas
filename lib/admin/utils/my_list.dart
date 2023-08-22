import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:spk_app/extract_widget/pop_up.dart';

import '../../extract_widget/pop_up2.dart';
import '../../extract_widget/text_field_popup.dart';
import '../../material/colors.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({
    super.key,
    required this.myText,
    this.bobotOnly = true,
    this.bobotValue = "",
    required this.onPressed,
    required this.controller,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onAddEdit,
    required this.onAddData,
    required this.isTextField,
  });

  final String myText, bobotValue;
  final bool bobotOnly, isTextField;
  final VoidCallback onPressed,
      onEditPressed,
      onDeletePressed,
      onAddEdit,
      onAddData;
  final TextEditingController controller;

  get lottieAssetsVisible => null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    myText,
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          bobotOnly
              ? Flexible(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () async {
                            final value = await showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              context: context,
                              builder: (BuildContext build) {
                                return PopUp2(
                                  onAddPressed: onAddEdit,
                                  controller: controller,
                                  isTextField: true,
                                  onEditPressed: onEditPressed,
                                  onPressed: onPressed,
                                  lottieAssetsVisible: false,
                                  namaTema: "Edit Tema",
                                  textButton: "Edit",
                                  hintTextTextField: "Edit Tema Skripsi",
                                  showSuffixIconTextField: true,
                                );
                              },
                            );
                            // ignore: avoid_print
                            print(value);
                          },
                          child: Container(
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.orange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              IconlyBold.edit,
                              color: AppColors.blue,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      //delete button
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () async {
                            final value = await showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                context: context,
                                builder: (BuildContext build) {
                                  return SizedBox(
                                    height: 300,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 30,
                                        left: 20,
                                        right: 20,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "namaTema",
                                                  style: GoogleFonts.lato(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 26,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                isTextField
                                                    ? TextFieldPopUp(
                                                        hintText: "",
                                                        controller: controller,
                                                      )
                                                    : lottieAssetsVisible
                                                        ? Center(
                                                            child: Container(
                                                              height: 250,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .red[90],
                                                              ),
                                                              child:
                                                                  LottieBuilder
                                                                      .asset(
                                                                          ""),
                                                            ),
                                                          )
                                                        : Flexible(
                                                            child: ListView
                                                                .separated(
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return Container(
                                                                  child:
                                                                      const Text(
                                                                          ""),
                                                                );
                                                              },
                                                              separatorBuilder:
                                                                  (context,
                                                                          index) =>
                                                                      Container(
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 20,
                                                      ),
                                                      child: Text(
                                                        "Batal",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.lato(
                                                          fontSize: 24,
                                                          color: Colors.black38,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              //right button
                                              Expanded(
                                                child: TextButton(
                                                  onPressed: onDeletePressed,
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: AppColors.red,
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 20,
                                                        horizontal: 20,
                                                      ),
                                                      child: Text(
                                                        "textButton",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.lato(
                                                          fontSize: 24,
                                                          color:
                                                              AppColors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                });
                            // ignore: avoid_print
                            print(value);
                          },
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              IconlyBold.delete,
                              color: AppColors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () async {
                      final value = await showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          context: context,
                          builder: (BuildContext build) {
                            return PopUp(
                              controller: controller,
                              lottieAssetsVisible: true,
                              isTextField: false,
                              onDeletePressed: onDeletePressed,
                              namaTema: "Apakah Anda Yakin Ingin Menghapusnya?",
                              textButton: "ngga",
                              height: 467,
                              hintTextTextField: "Edit Tema Skripsi",
                              showSuffixIconTextField: true,
                              buttonColor: AppColors.red,
                              lottieAssets: "assets/animation/sad-animation",
                            );
                          });
                      // ignore: avoid_print
                      print(value);
                    },
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          bobotValue,
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w800,
                              fontSize: 22,
                              color: AppColors.blue),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
