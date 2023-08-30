import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:spk_app/extract_widget/text_field.dart';
import 'package:spk_app/extract_widget/top_navbar.dart';
import 'package:spk_app/material/colors.dart';

class EditDataSubKriteria extends StatefulWidget {
  final Map<String, dynamic> data;
  const EditDataSubKriteria({
    super.key,
    required this.data,
  });

  @override
  State<EditDataSubKriteria> createState() => EditDataSubKriteriaState();
}

class EditDataSubKriteriaState extends State<EditDataSubKriteria> {
  //final for controller in texfield

  final TextEditingController controller = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nilaiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //navbar
                  const MyNavBar(
                    judul: "Details Data Kriteria",
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  //data sub-kriteria
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Edit Data Sub Kriteria",
                              style: GoogleFonts.lato(
                                fontSize: 22,
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 70),
                              child: Text(
                                "Nilai",
                                style: GoogleFonts.lato(
                                  fontSize: 22,
                                  color: AppColors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Column(

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
                                      textController: _namaController.text,
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
                                      textController: _nilaiController.text,
                                      labelText: "Data Sub Kriteria",
                                      controller: controller,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        // hapusSubKriteria(subKriteriaName);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.red,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 5),
                                          child: Center(
                                            child: Icon(
                                              IconlyBold.delete,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemCount: 5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Data Sub kriteria
                  // Expanded(
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         "Jenis Atribut",
                  //         style: GoogleFonts.lato(
                  //           fontSize: 22,
                  //           color: AppColors.white,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //       const SizedBox(
                  //         height: 20,
                  //       ),
                  //       SizedBox(
                  //         height: 60,
                  //         child: ListView.separated(
                  //           shrinkWrap: true,
                  //           scrollDirection: Axis.horizontal,
                  //           itemBuilder: (context, index) {
                  //             return TemaSkripsi(
                  //               text: atribut[index][1],
                  //               isSelected: atribut[index][0],
                  //               onTap: () {
                  //                 temaTypeSelected(index);
                  //               },
                  //             );
                  //           },
                  //           separatorBuilder: (context, index) {
                  //             return const SizedBox(
                  //               width: 10,
                  //             );
                  //           },
                  //           itemCount: atribut.length,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
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
                          //ketika ingin data kriteria default
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
                                "Edit",
                                style: GoogleFonts.lato(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.white),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
