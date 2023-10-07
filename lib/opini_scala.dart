import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:spk_app/models/questions.dart';

import '../../material/colors.dart';
import '../../nilai_dns.dart';
import '../home_screen.dart';

class ScalaOpini extends StatefulWidget {
  const ScalaOpini({super.key});

  @override
  State<ScalaOpini> createState() => _ScalaOpiniState();
}

class _ScalaOpiniState extends State<ScalaOpini> {
  final controller = PageController();

  bool isPageLast = false;
  int selected = 0;

  customRadio(text, String image, int index) {
    return TextButton(
      onPressed: () {
        setState(() {
          selected = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
            color: (selected == index) ? AppColors.violet : null,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: const Color(0xff505668))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: AppColors.white,
              ),
            ),
            Image.asset(image),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // img & subtitle
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  //title
                  //Question
                  Flexible(
                    child: PageView.builder(
                      controller: controller,
                      itemCount: sampleData.length,
                      onPageChanged: (index) {
                        setState(() {
                          isPageLast = (index == sampleData.length - 1);
                        });
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.violet,
                                      ),
                                      child: const Icon(
                                        IconlyBold.home,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        sampleData[index]['namaMatkul'],
                                        style: GoogleFonts.lato(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.orange),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: null,
                                    ),
                                    child: const Icon(null),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 30,
                              ),
                              Column(
                                children: [
                                  Text(
                                    sampleData[index]['pertanyaan'],
                                    style: GoogleFonts.lato(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white,
                                      height: 2,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              //Radiobutton picker
                              Column(
                                children: [
                                  customRadio(sampleData[index]['jawaban'][0],
                                      "assets/emoji/1.png", 1),
                                  customRadio(sampleData[index]['jawaban'][1],
                                      "assets/emoji/2.png", 2),
                                  customRadio(sampleData[index]['jawaban'][2],
                                      "assets/emoji/3.png", 3),
                                  customRadio(sampleData[index]['jawaban'][3],
                                      "assets/emoji/4.png", 4),
                                  customRadio(sampleData[index]['jawaban'][4],
                                      "assets/emoji/5.png", 5),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),

            //button
            isPageLast
                ? Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 20, top: 20),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      border: Border(
                        top: BorderSide(
                          color: Color(0xff2A3244),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.orange,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Kembali",
                                  style: GoogleFonts.lato(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const NilaiDns(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.violet,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Generate",
                                    style: GoogleFonts.lato(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    IconlyLight.arrow_right,
                                    size: 24,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 20, top: 20),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      border: Border(
                        top: BorderSide(
                          color: Color(0xff2A3244),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            controller.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.orange,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Kembali",
                                  style: GoogleFonts.lato(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: TextButton(
                            onPressed: () {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.violet,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Selanjutnya",
                                    style: GoogleFonts.lato(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    IconlyLight.arrow_right,
                                    size: 24,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
