import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spk_app/extract_widget/top_navbar.dart';

import '../extract_widget/text_field.dart';
import '../material/colors.dart';

class TambahSubKriteria extends StatefulWidget {
  const TambahSubKriteria({super.key});

  @override
  State<TambahSubKriteria> createState() => _TambahSubKriteriaState();
}

class _TambahSubKriteriaState extends State<TambahSubKriteria> {
  //samaikan dengan nama metode (tambahDataSubKriteria)//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(
            children: [
              const MyNavBar(judul: "Tambah Sub Kriteria"),
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Masukan Sub Kriteria & Nilai",
                    style: GoogleFonts.lato(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 600,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        // final subkriteria = subkriteriaList[index];
                        final controller = TextEditingController(
                            // text: subkriteria['nilai'].toString(),
                            );
                        return Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: MyTextField(
                                onChanged: (value) {},
                                showHint: true,
                                hintText: "Masukan Data Sub-Kriteria",
                                controller: controller,
                                readOnly: true,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: MyTextField(
                                onChanged: (value) {},
                                textAlign: TextAlign.center,
                                isShowLabelText: false,
                                textColor: AppColors.green,
                                hintText: "HintText",
                                readOnly: true,
                                labelText: "Data Sub Kriteria",
                                controller: controller,
                              ),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: 5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
