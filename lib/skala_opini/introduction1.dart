import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../material/colors.dart';
import 'implementasiWaspas.dart';

class Introduction1 extends StatefulWidget {
  const Introduction1({super.key});

  @override
  State<Introduction1> createState() => _Introduction1State();
}

class _Introduction1State extends State<Introduction1> {
  final controller = PageController();

  bool isPageLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  //time growth
                  Flexible(
                    child: PageView(
                      controller: controller,
                      onPageChanged: (index) {
                        setState(() {
                          isPageLast = (index == 1);
                        });
                      },
                      children: [
                        Container(
                          // padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Container(
                                      height: 5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Container(
                                      height: 5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white38,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 40, right: 20),
                                decoration: BoxDecoration(
                                  color: AppColors.orange,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset('assets/intro1.png'),
                              ),

                              const SizedBox(
                                height: 30,
                              ),
                              // Title
                              Text(
                                "Bagaimana Cara Kerjanya?",
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // subtitle
                              Text(
                                "Kamu akan diberi beberapa pertanyaan skala opini kuesioner seputar Tema Skripsi yang berada di STIKOM Poltek Cirebon, yang nantinya akan digenerate oleh sistem",
                                style: GoogleFonts.lato(
                                  color: Colors.white70,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  height: 1.8,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    height: 5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Container(
                                    height: 5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 40, right: 20),
                              decoration: BoxDecoration(
                                color: AppColors.violet,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset('assets/intro1.png'),
                            ),

                            const SizedBox(
                              height: 30,
                            ),
                            // Title
                            Text(
                              "Bagaimana Cara Kerjanya?",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // subtitle
                            Text(
                              "Kamu akan diberi beberapa pertanyaan skala opini kuesioner seputar Tema Skripsi yang berada di STIKOM Poltek Cirebon, yang nantinya akan digenerate oleh sistem",
                              style: GoogleFonts.lato(
                                color: Colors.white70,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                height: 1.8,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                        Flexible(
                          fit: FlexFit.tight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DecisionMakingPageReal(),
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
                                    "Gaskeun Atuh",
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
                  ),
          ],
        ),
      ),
    );
  }
}
