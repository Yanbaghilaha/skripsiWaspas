// ignore_for_file: avoid_print

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:spk_app/final_conclusion.dart';

import '../material/colors.dart';

class DecisionMakingPageReal extends StatefulWidget {
  const DecisionMakingPageReal({super.key});

  @override
  _DecisionMakingPageRealState createState() => _DecisionMakingPageRealState();
}

class _DecisionMakingPageRealState extends State<DecisionMakingPageReal> {
  List<List<int>> selectedValues = [];
  List<String> alternatif = [];
  Map<String, Map<String, int>> subKriteriaData = {};
  List<String> jenisKriteria = [];
  List<double> bobotKriteria = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      // Ambil data alternatif
      QuerySnapshot<Map<String, dynamic>> alternatifSnapshot =
          await FirebaseFirestore.instance.collection('alternatif').get();
      alternatif = alternatifSnapshot.docs.map((doc) => doc.id).toList();

      // Ambil data kriteria dan subkriteria dari Firestore
      QuerySnapshot<Map<String, dynamic>> kriteriaSnapshot =
          await FirebaseFirestore.instance.collection('kriteria').get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc
          in kriteriaSnapshot.docs) {
        Map<String, dynamic> kriteria = doc.data();
        Map<String, int> subKriteria =
            Map<String, int>.from(kriteria['subKriteria']);

        // Urutkan nilai subkriteria dari yang terkecil ke terbesar
        var sortedSubKriteria = Map<String, int>.fromEntries(
            subKriteria.entries.toList()
              ..sort((a, b) => a.value.compareTo(b.value)));

        subKriteriaData[kriteria['nama']] = sortedSubKriteria;
        jenisKriteria.add(kriteria['jenis']);
        bobotKriteria.add(kriteria['bobot']);
      }

      setState(() {
        initSelectedValues();
      });
    } catch (error) {
      print('Error fetching data from Firestore: $error');
    }
  }

  void initSelectedValues() {
    selectedValues = List.generate(
      alternatif.length,
      (index) => List.generate(
        subKriteriaData.length,
        (index) => 0,
      ),
    );
  }

  //mencari nilai Max
  List<int> getMaxValuesInColumns(List<List<int>> matrix) {
    List<int> maxValues = List.filled(matrix[0].length, 0);

    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        if (matrix[i][j] > maxValues[j]) {
          maxValues[j] = matrix[i][j];
        }
      }
    }
    return maxValues;
  }

  //mencari nilai min
  List<int> getMinValuesInColumns(List<List<int>> matrix) {
    List<int> minValues = List.filled(matrix[0].length,
        5); // Diinisialisasi dengan nilai maksimum yang mungkin

    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        if (matrix[i][j] < minValues[j]) {
          minValues[j] = matrix[i][j];
        }
      }
    }

    return minValues;
  }

  //normalisasi matriks
  List<List<double>> calculateNormalizedData(List<List<int>> matrix,
      List<String> jenisKriteria, List<int> maxValues, List<int> minValues) {
    List<List<double>> normalizedData = [];

    for (int i = 0; i < matrix.length; i++) {
      List<double> normalizedRow = [];
      for (int j = 0; j < matrix[i].length; j++) {
        double normalizedValue;
        if (jenisKriteria[j] == 'Benefit') {
          normalizedValue = matrix[i][j] / maxValues[j];
        } else if (jenisKriteria[j] == 'Cost') {
          normalizedValue = minValues[j] / matrix[i][j];
        } else {
          normalizedValue = 0.0;
        }
        normalizedRow.add(normalizedValue);
      }
      normalizedData.add(normalizedRow);
    }

    return normalizedData;
  }

  //menghitung nilai Qi
  List<List<double>> calculateQi(
      List<List<double>> normalizedData, List<double> bobot) {
    List<List<double>> weightedResults = [];

    for (int i = 0; i < normalizedData.length; i++) {
      List<double> weightedRow = [];
      for (int j = 0; j < normalizedData[i].length; j++) {
        double weightedValue = normalizedData[i][j] * bobot[j];
        weightedRow.add(weightedValue);
      }
      weightedResults.add(weightedRow);
    }

    return weightedResults;
  }

  List<double> calculateTotalWeightedSumPerRow(
      List<List<double>> weightedResults) {
    List<double> totalWeightedSumPerRow = [];

    for (int i = 0; i < weightedResults.length; i++) {
      double rowSum = weightedResults[i].reduce((sum, value) => sum + value);
      totalWeightedSumPerRow.add(rowSum);
    }

    return totalWeightedSumPerRow;
  }

  //total hasil qi (1)
  List<double> calculateQiFinal(List<double> totalWeightedSumPerRow) {
    List<double> qiFinal = [];

    for (int i = 0; i < totalWeightedSumPerRow.length; i++) {
      double qi = totalWeightedSumPerRow[i] * 0.5;
      qiFinal.add(qi);
    }

    return qiFinal;
  }

  //langkah 2
  List<double> calculateQ2(
      List<List<double>> normalizedData, List<double> bobot) {
    List<double> q2Values = [];

    for (int i = 0; i < normalizedData.length; i++) {
      double rowProduct = 1.0;
      for (int j = 0; j < normalizedData[i].length; j++) {
        rowProduct *= pow(normalizedData[i][j], bobot[j]);
      }
      double q2 = rowProduct * 0.5;
      q2Values.add(q2);
    }

    return q2Values;
  }

  //this last function pliss, i've no idea no more :)
  List<double> totalPerColumn(List<double> data1, List<double> data2) {
    assert(data1.length == data2.length);

    List<double> result = List.filled(data1.length, 0.0);

    for (int i = 0; i < data1.length; i++) {
      result[i] = data1[i] + data2[i];
    }
    return result;
  }

  int kriteriaIndex = 0;
  int subKriteriaIndex = 0;
  int alternatifIndex = 0;
  bool isSubKriteriaSelected = false;
  final PageController _pageController = PageController(initialPage: 0);

  void goToNext() {
    // Check if all values in the current subkriteria are selected

    setState(() {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      subKriteriaIndex++;

      if (subKriteriaIndex >=
          subKriteriaData[subKriteriaData.keys.elementAt(kriteriaIndex)]!
              .length) {
        subKriteriaIndex = 0;
        kriteriaIndex++;

        if (kriteriaIndex >= subKriteriaData.keys.length) {
          kriteriaIndex = 0;
          alternatifIndex++;

          if (alternatifIndex >= alternatif.length) {
            alternatifIndex = 0;
          }
        }
      }
    });
  }
  // buat nanti jika belum mengisi radiobutton maka akan keluar showmodalbottomsheet
  // void goToNext() {
  //   // Check if all values in the current subkriteria are selected
  //   bool isAllSelected = selectedValues[alternatifIndex][subKriteriaIndex] != 0;

  //   if (!isAllSelected) {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text('Peringatan'),
  //           content: const Text(
  //               'Pilih nilai pada kriteria saat ini sebelum melanjutkan.'),
  //           actions: [
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   } else {
  //     setState(() {
  //       _pageController.nextPage(
  //           duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  //       subKriteriaIndex++;

  //       if (subKriteriaIndex >=
  //           subKriteriaData[subKriteriaData.keys.elementAt(kriteriaIndex)]!
  //               .length) {
  //         subKriteriaIndex = 0;
  //         kriteriaIndex++;

  //         if (kriteriaIndex >= subKriteriaData.keys.length) {
  //           kriteriaIndex = 0;
  //           alternatifIndex++;

  //           if (alternatifIndex >= alternatif.length) {
  //             alternatifIndex = 0;
  //           }
  //         }
  //       }
  //     });
  //   }
  // }

  void loadNextSubKriteria() {
    setState(() {
      subKriteriaIndex++;
      isSubKriteriaSelected = false;

      if (subKriteriaIndex >=
          subKriteriaData[subKriteriaData.keys.elementAt(kriteriaIndex)]!
              .length) {
        subKriteriaIndex = 0;
        kriteriaIndex++;

        if (kriteriaIndex >= subKriteriaData.keys.length) {
          kriteriaIndex = 0;
          alternatifIndex++;

          if (alternatifIndex >= alternatif.length) {
            alternatifIndex = 0;
          }
        }
      }
    });
  }

  void onRadioValueChanged(
      int alternatifIndex, int kriteriaIndex, int newValue) {
    setState(() {
      selectedValues[alternatifIndex][kriteriaIndex] = newValue;

      if (selectedValues[alternatifIndex]
              .where((value) => value == 0)
              .isEmpty &&
          kriteriaIndex == subKriteriaIndex) {
        isSubKriteriaSelected = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          itemCount: alternatif.length,
          itemBuilder: (context, index) {
            bool isLastPage = index == alternatif.length - 1;

            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      pinned: true,
                      expandedHeight: 70,
                      backgroundColor: AppColors.primary,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          alternatif[index],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            color: AppColors.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 700,
                          child: ListView(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var kriteriaIndex = 0;
                                      kriteriaIndex <
                                          subKriteriaData.keys.length;
                                      kriteriaIndex++)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${subKriteriaData.keys.elementAt(kriteriaIndex)} ${alternatif[index]}",
                                          style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 24,
                                              color: AppColors.green),
                                        ),
                                        const SizedBox(height: 20),
                                        Column(
                                          children: subKriteriaData[
                                                  subKriteriaData.keys
                                                      .elementAt(
                                                          kriteriaIndex)]!
                                              .entries
                                              .map(
                                            (entry) {
                                              return GestureDetector(
                                                onTap: () {
                                                  onRadioValueChanged(
                                                      index,
                                                      kriteriaIndex,
                                                      entry.value);
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8.0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: selectedValues[
                                                                      index][
                                                                  kriteriaIndex] ==
                                                              entry.value
                                                          ? AppColors.blue
                                                          : Colors.transparent,
                                                      border: Border.all(
                                                        color: AppColors.border,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20.0),
                                                          child: Text(
                                                            entry.key,
                                                            style: GoogleFonts
                                                                .lato(
                                                              color: selectedValues[
                                                                              index]
                                                                          [
                                                                          kriteriaIndex] ==
                                                                      entry
                                                                          .value
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20.0),
                                                          child: Image.asset(
                                                            'assets/emoji/${entry.value}.png', // Sesuaikan nama file gambar
                                                            width:
                                                                32, // Sesuaikan ukuran gambar
                                                            height: 32,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                        const SizedBox(height: 30.0),
                                        Container(
                                          width: double.infinity,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: AppColors.border,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        const SizedBox(height: 30.0),
                                      ],
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                isLastPage
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
                                _pageController.previousPage(
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
                                  List<int> maxValues =
                                      getMaxValuesInColumns(selectedValues);
                                  List<int> minValues =
                                      getMinValuesInColumns(selectedValues);
                                  List<List<double>> normalizedData =
                                      calculateNormalizedData(selectedValues,
                                          jenisKriteria, maxValues, minValues);
                                  List<List<double>> weightedResults =
                                      calculateQi(
                                          normalizedData, bobotKriteria);

                                  List<double> totalWeightedSumPerRow =
                                      calculateTotalWeightedSumPerRow(
                                          weightedResults);
                                  List<double> q1Values =
                                      calculateQiFinal(totalWeightedSumPerRow);
                                  List<double> q2Values = calculateQ2(
                                      normalizedData, bobotKriteria);
                                  List<double> totalWeightedSumColumn =
                                      totalPerColumn(
                                    q1Values,
                                    q2Values,
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FinalConclusion(
                                          alternatif: alternatif,
                                          totalWeightedSumColumn:
                                              totalWeightedSumColumn),
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
                                _pageController.previousPage(
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
                                  goToNext();
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
            );
          },
        ),
      ),
    );
  }
}
