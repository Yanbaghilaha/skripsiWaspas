// ignore_for_file: avoid_print
import 'dart:math';

void main() {
  // Langkah 1: Membuat matriks keputusan
  List<List<double>> matriksKeputusan = [
    [4, 3, 3, 4, 4],
    [4, 3, 3, 3, 3],
    [3, 3, 4, 3, 4],
    [3, 3, 4, 4, 2],
    [4, 3, 4, 4, 4],
    [3, 3, 3, 3, 4]
  ];

  // Langkah 2: Menentukan jenis kriteria
  List<String> jenisKriteria = [
    'Benefit',
    'Benefit',
    'Benefit',
    'Benefit',
    'Benefit'
  ];

  // Langkah 3: Menghitung nilai bobot (w) untuk setiap kriteria
  List<double> bobotKriteria = [
    3.0,
    2.2,
    1.5,
    2.5,
    0.8,
  ];

  // Langkah 4: Melakukan normalisasi terhadap matriks
  List<List<double>> matriksNormalisasi =
      normalizeMatrix(matriksKeputusan, jenisKriteria);

  // Menampilkan matriks normalisasi
  print("Matriks Normalisasi:");
  for (int i = 0; i < matriksNormalisasi.length; i++) {
    print(matriksNormalisasi[i]);
  }

  // Langkah 5: Menghitung nilai Qi
  List<double> qiValues = calculateQiValues(matriksNormalisasi, bobotKriteria);

  // Menampilkan hasil nilai Qi
  print("Nilai Qi:");
  for (int i = 0; i < qiValues.length; i++) {
    print("Q${i + 1}: ${qiValues[i].toStringAsFixed(2)}");
  }
}

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

List<List<double>> normalizeMatrix(
    List<List<double>> matrix, List<String> criteria) {
  List<List<double>> normalizedMatrix = [];

  for (int j = 0; j < matrix[0].length; j++) {
    double sum = 0;
    for (int i = 0; i < matrix.length; i++) {
      sum += matrix[i][j];
    }

    List<double> normalizedColumn = [];
    for (int i = 0; i < matrix.length; i++) {
      double value = matrix[i][j] / sum;
      int criteriaIndex =
          j % criteria.length; // Cycle through criteria cyclically
      if (criteria[criteriaIndex] == 'Cost') {
        value = 1 / value;
      }
      normalizedColumn.add(value);
    }

    normalizedMatrix.add(normalizedColumn);
  }

  return normalizedMatrix;
}

List<double> calculateQiValues(
    List<List<double>> normalizedMatrix, List<double> weights) {
  List<double> qiValues = [];

  for (int i = 0; i < normalizedMatrix.length; i++) {
    double qi = 1;
    for (int j = 0; j < normalizedMatrix[i].length; j++) {
      qi *= pow(normalizedMatrix[i][j], weights[j]);
    }
    qiValues.add(pow(qi, 0.5).toDouble());
  }

  return qiValues;
}
