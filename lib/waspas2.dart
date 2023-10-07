// ignore_for_file: avoid_print
import 'dart:math';

//menghitung dengan nilai max
List<double> calculateMaxColumnValues(List<List<double>> matrix) {
  List<double> maxColumnValues = List.filled(matrix[0].length, 0);

  for (int j = 0; j < matrix[0].length; j++) {
    double max = matrix[0][j];
    for (int i = 1; i < matrix.length; i++) {
      if (matrix[i][j] > max) {
        max = matrix[i][j];
      }
    }
    maxColumnValues[j] = max;
  }

  return maxColumnValues;
}

//menghitung dengan nilai min
List<double> calculateMinColumnValues(List<List<double>> matrix) {
  List<double> minValues = [];

  for (int j = 0; j < matrix[0].length; j++) {
    double min = matrix[0][j];
    for (int i = 1; i < matrix.length; i++) {
      if (matrix[i][j] < min) {
        min = matrix[i][j];
      }
    }
    minValues.add(min);
  }
  return minValues;
}

//normalisasi dengan max
List<List<double>> normalizeMatrixByMax(List<List<double>> matrix) {
  List<double> maxColumnValues = calculateMaxColumnValues(matrix);
  List<List<double>> normalizedMatrix = [];

  for (int i = 0; i < matrix.length; i++) {
    List<double> normalizedRow = [];
    for (int j = 0; j < matrix[i].length; j++) {
      normalizedRow.add(matrix[i][j] / maxColumnValues[j]);
    }
    normalizedMatrix.add(normalizedRow);
  }

  return normalizedMatrix;
}

List<List<double>> normalizeMatrixByMin(List<List<double>> matrix) {
  List<double> maxColumnValues = calculateMaxColumnValues(matrix);
  List<List<double>> normalizedMatrix = [];

  for (int i = 0; i < matrix.length; i++) {
    List<double> normalizedRow = [];
    for (int j = 0; j < matrix[i].length; j++) {
      normalizedRow.add(maxColumnValues[j] / matrix[i][j]);
    }
    normalizedMatrix.add(normalizedRow);
  }

  return normalizedMatrix;
}

//normalasisai dengan nilai min
// List<List<double>> normalizeMatrixByMin(List<List<double>> matrix) {
//   List<double> minValues = calculateMinColumnValues(matrix);
//   List<List<double>> normalizedMatrix = [];

//   for (int j = 0; j < matrix[0].length; j++) {
//     double sum = 0;
//     for (int i = 0; i < matrix.length; i++) {
//       sum += matrix[i][j] / minValues[j];
//     }

//     List<double> normalizedColumn = [];
//     for (int i = 0; i < matrix.length; i++) {
//       normalizedColumn
//           .add(calculateMinColumnValues(matrix)[j] / (matrix[i][j] * sum));
//     }

//     normalizedMatrix.add(normalizedColumn);
//   }

//   return normalizedMatrix;
// }

//perhitungan dengan mengkalikan dengan bobot
List<List<double>> multiplyMatrixWithWeights(
    List<List<double>> matrix, List<double> weights) {
  List<List<double>> resultMatrix = [];

  for (int i = 0; i < matrix.length; i++) {
    List<double> resultRow = [];
    for (int j = 0; j < matrix[i].length; j++) {
      resultRow.add(matrix[i][j] * weights[j]);
    }
    resultMatrix.add(resultRow);
  }

  return resultMatrix;
}

List<double> calculateAggregatedScores(List<List<double>> matrix) {
  List<double> aggregatedScores = [];

  for (int i = 0; i < matrix.length; i++) {
    double rowSum = matrix[i].reduce((value, element) => value + element);
    double finalScore = rowSum * 0.5;
    aggregatedScores.add(finalScore);
  }

  return aggregatedScores;
}

//step 2 pangkatkan dengan bobot
List<List<double>> normalizeAndPowerWithWeights(
    List<List<double>> matrix, List<double> weights) {
  List<List<double>> resultMatrix = [];

  for (int i = 0; i < matrix.length; i++) {
    List<double> resultRow = [];
    for (int j = 0; j < matrix[i].length; j++) {
      double poweredValue = pow(matrix[i][j], weights[j]).toDouble();
      resultRow.add(poweredValue);
    }
    resultMatrix.add(resultRow);
  }

  return resultMatrix;
}

List<double> calculateRowProductsAndScale(List<List<double>> matrix) {
  List<double> rowProducts = [];

  for (int i = 0; i < matrix.length; i++) {
    double rowProduct = matrix[i].reduce((value, element) => value * element);
    rowProducts.add(rowProduct * 0.5);
  }

  return rowProducts;
}

void main() {
  List<List<double>> matrix = [
    [4, 3, 3, 4, 4],
    [4, 3, 3, 3, 3],
    [3, 3, 4, 3, 4],
    [3, 3, 4, 4, 2],
    [4, 3, 4, 4, 4],
    [3, 3, 3, 3, 4]
  ];
  List<double> weights = [
    3.0,
    2.2,
    1.5,
    2.5,
    0.8,
  ];

  List<List<double>> normalizedMatrix = normalizeMatrixByMax(matrix);
  List<List<double>> normalizedMatrixmin = normalizeMatrixByMin(matrix);

  List<List<double>> resultMatrix =
      multiplyMatrixWithWeights(normalizedMatrix, weights);

  List<double> aggregatedScores = calculateAggregatedScores(resultMatrix);
  List<List<double>> poweredWithWeightsMatrix =
      normalizeAndPowerWithWeights(normalizedMatrix, weights);
  List<double> rowProductsScaled =
      calculateRowProductsAndScale(poweredWithWeightsMatrix);

  print("\nMatriks Hasil Setelah Normalisasi dengan Metode Max:");
  for (int i = 0; i < normalizedMatrix.length; i++) {
    print(normalizedMatrix[i]);
  }
  print("\nMatriks Hasil Setelah Normalisasi dengan Metode Min:");
  for (int i = 0; i < normalizedMatrix.length; i++) {
    print(normalizedMatrixmin[i]);
  }

  print("\nHasil Akhir Aggregated Scores:");
  for (int i = 0; i < aggregatedScores.length; i++) {
    print("Baris ${i + 1}: ${aggregatedScores[i]}");
  }
  print("\nHasil Akhir Setelah Perhitungan:");
  for (int i = 0; i < rowProductsScaled.length; i++) {
    print("Baris ${i + 1}: ${rowProductsScaled[i]}");
  }

  List<double> finalScores = [];
  for (int i = 0; i < matrix.length; i++) {
    finalScores.add(aggregatedScores[i] + rowProductsScaled[i]);
  }

  print("\n\nHasil Akhir Setelah Perhitungan:");
  for (int i = 0; i < finalScores.length; i++) {
    print("Baris ${i + 1}: ${finalScores[i]}");
  }
}
