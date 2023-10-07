// // ignore_for_file: avoid_print

// ignore_for_file: avoid_print
// print("\nData Alternatif yang Dinormalisasi:");
// for (int i = 0; i < summedResults.length; i++) {
//   List<String> rowValues = [];
//   for (int j = 0; j < summedResults[i]; j++) {
//     String columnName = columnNames[j] ?? "Kolom $j";
//     rowValues.add("$columnName: ${summedResults[i]}");
//   }
//   print("Baris $i: ${rowValues.join(', ')}");
// }

import 'dart:math';

void main() {
  List<List<int>> dataAlternatif = [
    [4, 3, 3, 4, 4],
    [4, 3, 3, 3, 3],
    [3, 3, 4, 3, 4],
    [3, 3, 4, 4, 2],
    [4, 3, 4, 4, 4],
    [3, 3, 3, 3, 4],
  ];

  List<String> jenisKriteria = [
    "Benefit",
    "Benefit",
    "Benefit",
    "Benefit",
    "Benefit"
  ];
  List<double> bobot = [3, 2.2, 1.5, 2.5, 0.8];

  List<List<double>> normalizedData =
      calculateNormalizedData(dataAlternatif, jenisKriteria);

  print("\nData Alternatif yang Dinormalisasi:");
  for (int i = 0; i < normalizedData.length; i++) {
    print("Hasil Dinormalisasi ${normalizedData[i]}");
  }

  print(
      "\n========================================================================\n");

  List<List<double>> weightedResults =
      calculateWeightedResults(normalizedData, bobot);

  List<double> totalWeightedSum = calculateTotalWeightedSum(weightedResults);

  print("STEP 1");
  for (int i = 0; i < weightedResults.length; i++) {
    print(weightedResults[i]);
  }
  print("----------------------------------------------------");
  print("Hasil Penjumlahan lalu dikali 0.5: $totalWeightedSum");

  List<List<double>> poweredResults =
      calculatePoweredResults(normalizedData, bobot);
  print(
      "\n========================================================================\n");
  print("STEP 2");
  for (int i = 0; i < poweredResults.length; i++) {
    print(poweredResults[i]);
  }
  List<double> finalResults = calculateFinalResults(poweredResults);
  print("----------------------------------------------------");
  print("Hasil Penjumlahan lalu dikali 0.5: $finalResults");

  List<double> summedResults = sumResults(totalWeightedSum, finalResults);

  print(
      "\n========================================================================\n");
  print(
      "-->>>Hasil penjumlahan setiap data dalam result1 dan result2:$summedResults");
}

//mencari nilai max
// List<int> calculateMaxForEachColumn(List<List<int>> data) {
//   List<int> maxValues = List.filled(data[0].length, 0);

//   for (int i = 0; i < data.length; i++) {
//     for (int j = 0; j < data[i].length; j++) {
//       if (data[i][j] > maxValues[j]) {
//         maxValues[j] = data[i][j];
//       }
//     }
//   }

//   return maxValues;
// }

// //mencari nilai min
// List<int> calculateMinForEachColumn(List<List<int>> data) {
//   List<int> minValues = List.filled(data[0].length, data[0][0]);

//   for (int i = 0; i < data.length; i++) {
//     for (int j = 0; j < data[i].length; j++) {
//       if (data[i][j] < minValues[j]) {
//         minValues[j] = data[i][j];
//       }
//     }
//   }

//   return minValues;
// }

// //melakukan normalisasi
// List<List<double>> calculateNormalizedData(
//     List<List<int>> data, List<String> jenis) {
//   List<int> maxValues = calculateMaxForEachColumn(data);
//   List<int> minValues = calculateMinForEachColumn(data);

//   List<List<double>> normalizedData = [];

//   for (int i = 0; i < data.length; i++) {
//     List<double> normalizedRow = [];
//     for (int j = 0; j < data[i].length; j++) {
//       if (jenis[j] == "Benefit") {
//         normalizedRow.add(data[i][j] / maxValues[j]);
//       } else if (jenis[j] == "Cost") {
//         normalizedRow.add(minValues[j] / data[i][j]);
//       }
//     }
//     normalizedData.add(normalizedRow);
//   }

//   return normalizedData;
// }

// //step 1.1
// List<List<double>> calculateWeightedResults(
//     List<List<double>> normalizedData, List<double> weights) {
//   List<List<double>> weightedResults = [];

//   for (int i = 0; i < normalizedData.length; i++) {
//     List<double> weightedRow = [];
//     for (int j = 0; j < normalizedData[i].length; j++) {
//       weightedRow.add(normalizedData[i][j] * weights[j]);
//     }
//     weightedResults.add(weightedRow);
//   }

//   return weightedResults;
// }

// //step 1.2
// List<double> calculateTotalWeightedSum(List<List<double>> weightedResults) {
//   List<double> finalResults = [];

//   for (int i = 0; i < weightedResults.length; i++) {
//     double totalWeightedSum = 0.0;
//     for (int j = 0; j < weightedResults[i].length; j++) {
//       totalWeightedSum += weightedResults[i][j];
//     }
//     finalResults.add(totalWeightedSum * 0.5);
//   }

//   return finalResults;
// }

// //step 2.1
// List<List<double>> calculatePoweredResults(
//     List<List<double>> normalizedData, List<double> weights) {
//   List<List<double>> poweredResults = [];

//   for (int i = 0; i < normalizedData.length; i++) {
//     List<double> poweredRow = [];
//     for (int j = 0; j < normalizedData[i].length; j++) {
//       poweredRow.add(pow(normalizedData[i][j], weights[j]).toDouble());
//     }
//     poweredResults.add(poweredRow);
//   }

//   return poweredResults;
// }

// //step 2.2
// List<double> calculateFinalResults(List<List<double>> multipliedResults) {
//   List<double> finalResults = [];

//   for (int i = 0; i < multipliedResults.length; i++) {
//     double rowProduct = 1.0;
//     for (int j = 0; j < multipliedResults[i].length; j++) {
//       rowProduct *= multipliedResults[i][j];
//     }
//     finalResults.add(rowProduct * 0.5);
//   }

//   return finalResults;
// }

// //pemjumlahan step 1 dan step 2
// List<double> sumResults(List<double> results1, List<double> results2) {
//   assert(results1.length == results2.length);

//   List<double> summedResults = [];

//   for (int i = 0; i < results1.length; i++) {
//     summedResults.add(results1[i] + results2[i]);
//   }

//   return summedResults;
// }

//------------------------------------------------------------
// Mencari nilai maksimum untuk setiap kolom
List<int> calculateMaxForEachColumn(List<List<int>> data) {
  List<int> maxValues = List.filled(data[0].length, 0);

  for (int i = 0; i < data.length; i++) {
    for (int j = 0; j < data[i].length; j++) {
      if (data[i][j] > maxValues[j]) {
        maxValues[j] = data[i][j];
      }
    }
  }

  return maxValues;
}

// Mencari nilai minimum untuk setiap kolom
List<int> calculateMinForEachColumn(List<List<int>> data) {
  List<int> minValues = List.filled(data[0].length, data[0][0]);

  for (int i = 0; i < data.length; i++) {
    for (int j = 0; j < data[i].length; j++) {
      if (data[i][j] < minValues[j]) {
        minValues[j] = data[i][j];
      }
    }
  }

  return minValues;
}

// Melakukan normalisasi
List<List<double>> calculateNormalizedData(
    List<List<int>> data, List<String> jenis) {
  List<int> maxValues = calculateMaxForEachColumn(data);
  List<int> minValues = calculateMinForEachColumn(data);

  List<List<double>> normalizedData = [];

  for (int i = 0; i < data.length; i++) {
    List<double> normalizedRow = [];
    for (int j = 0; j < data[i].length; j++) {
      if (jenis[j] == "Benefit") {
        normalizedRow.add(data[i][j] / maxValues[j]);
      } else if (jenis[j] == "Cost") {
        normalizedRow.add(minValues[j] / data[i][j]);
      }
    }
    normalizedData.add(normalizedRow);
  }

  return normalizedData;
}

// Step 1.1: Menghitung hasil perkalian antara normalized data dan bobot
List<List<double>> calculateWeightedResults(
    List<List<double>> normalizedData, List<double> weights) {
  List<List<double>> weightedResults = [];

  for (int i = 0; i < normalizedData.length; i++) {
    List<double> weightedRow = [];
    for (int j = 0; j < normalizedData[i].length; j++) {
      weightedRow.add(normalizedData[i][j] * weights[j]);
    }
    weightedResults.add(weightedRow);
  }

  return weightedResults;
}

// Step 1.2: Menghitung total weighted sum
List<double> calculateTotalWeightedSum(List<List<double>> weightedResults) {
  List<double> finalResults = [];

  for (int i = 0; i < weightedResults.length; i++) {
    double totalWeightedSum = 0.0;
    for (int j = 0; j < weightedResults[i].length; j++) {
      totalWeightedSum += weightedResults[i][j];
    }
    finalResults.add(totalWeightedSum * 0.5);
  }

  return finalResults;
}

// Step 2.1: Menghitung hasil pangkat antara normalized data dan bobot
List<List<double>> calculatePoweredResults(
    List<List<double>> normalizedData, List<double> weights) {
  List<List<double>> poweredResults = [];

  for (int i = 0; i < normalizedData.length; i++) {
    List<double> poweredRow = [];
    for (int j = 0; j < normalizedData[i].length; j++) {
      poweredRow.add(pow(normalizedData[i][j], weights[j]).toDouble());
    }
    poweredResults.add(poweredRow);
  }

  return poweredResults;
}

// Step 2.2: Menghitung hasil perkalian akhir dari powered results
List<double> calculateFinalResults(List<List<double>> poweredResults) {
  List<double> finalResults = [];

  for (int i = 0; i < poweredResults.length; i++) {
    double rowProduct = 1.0;
    for (int j = 0; j < poweredResults[i].length; j++) {
      rowProduct *= poweredResults[i][j];
    }
    finalResults.add(rowProduct * 0.5);
  }

  return finalResults;
}

// Pemjumlahan step 1 dan step 2
List<double> sumResults(List<double> results1, List<double> results2) {
  assert(results1.length == results2.length);

  List<double> summedResults = [];

  for (int i = 0; i < results1.length; i++) {
    summedResults.add(results1[i] + results2[i]);
  }

  return summedResults;
}
