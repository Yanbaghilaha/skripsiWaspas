// void main() {
//   List<Map<String, dynamic>> kriteriaData = [
//     {
//       'bobot': 3.0,
//     },
//     {
//       'bobot': 2.2,
//     },
//     {
//       'bobot': 1.5,
//     },
//     {
//       'bobot': 2.5,
//     },
//   ];

//   List<Map<String, dynamic>> alternatifData = [
//     {
//       'nama': 'kriteria1',
//       'Minat Matkul': 4,
//       'Paham Matkul': 3,
//       'Penguasaan Matkul': 3,
//       'Penguasaan Metode': 4,
//       'Nilai Akademik': 4,
//     },
//     {
//       'nama': 'kriteria2',
//       'Minat Matkul': 4,
//       'Paham Matkul': 3,
//       'Penguasaan Matkul': 3,
//       'Penguasaan Metode': 3,
//       'Nilai Akademik': 3,
//     },
//     {
//       'nama': 'kriteria3',
//       'Minat Matkul': 3,
//       'Paham Matkul': 3,
//       'Penguasaan Matkul': 4,
//       'Penguasaan Metode': 3,
//       'Nilai Akademik': 4,
//     },
//     {
//       'nama': 'kriteria4',
//       'Minat Matkul': 3,
//       'Paham Matkul': 3,
//       'Penguasaan Matkul': 4,
//       'Penguasaan Metode': 4,
//       'Nilai Akademik': 2,
//     },
//     {
//       'nama': 'kriteria5',
//       'Minat Matkul': 4,
//       'Paham Matkul': 3,
//       'Penguasaan Matkul': 4,
//       'Penguasaan Metode': 4,
//       'Nilai Akademik': 4,
//     },
//     {
//       'nama': 'kriteria6',
//       'Minat Matkul': 3,
//       'Paham Matkul': 3,
//       'Penguasaan Matkul': 3,
//       'Penguasaan Metode': 3,
//       'Nilai Akademik': 4,
//     },
//   ];

//   // Langkah 1: Normalisasi Data
//   List<List<double>> normalizedMatrix = [];
//   for (var i = 0; i < alternatifData.length; i++) {
//     List<double> normalizedValues = [];
//     for (var j = 1; j <= kriteriaData.length; j++) {
//       double nilai = alternatifData[i]['kriteria$j'] / 100.0;
//       normalizedValues.add(nilai);
//     }
//     normalizedMatrix.add(normalizedValues);
//   }

//   // Langkah 2: Perhitungan Nilai Preferensi (Weighted Sum)
//   List<double> weightedSumValues = [];
//   for (var i = 0; i < alternatifData.length; i++) {
//     double weightedSum = 0;
//     for (var j = 0; j < kriteriaData.length; j++) {
//       double bobot = kriteriaData[j]['bobot'];
//       weightedSum += normalizedMatrix[i][j] * bobot;
//     }
//     weightedSumValues.add(weightedSum);
//   }

//   // Langkah 3: Menentukan Alternatif Terbaik
//   double maxWeightedSum = weightedSumValues
//       .reduce((value, element) => value > element ? value : element);
//   int indexMax = weightedSumValues.indexOf(maxWeightedSum);

//   String alternatifTerbaik = alternatifData[indexMax]['nama'];

//   print("Alternatif terbaik: $alternatifTerbaik");
// }

// ignore_for_file: avoid_print

void main() {
  List<Map<String, dynamic>> kriteriaData = [
    {'bobot': 3.0, 'jenis': "benefit"},
    {'bobot': 2.2, 'jenis': "benefit"},
    {'bobot': 1.5, 'jenis': "benefit"},
    {'bobot': 2.5, 'jenis': "benefit"},
    {'bobot': 0.8, 'jenis': "benefit"},
  ];

  List<Map<String, dynamic>> alternatifData = [
    {
      'nama': 'Kriptografi',
      'kriteria1': 4,
      'kriteria2': 3,
      'kriteria3': 3,
      'kriteria4': 4,
      'kriteria5': 4,
    },
    {
      'nama': 'Data Mining',
      'kriteria1': 4,
      'kriteria2': 3,
      'kriteria3': 3,
      'kriteria4': 3,
      'kriteria5': 3,
    },
    {
      'nama': 'Sistem Pakar',
      'kriteria1': 3,
      'kriteria2': 3,
      'kriteria3': 4,
      'kriteria4': 3,
      'kriteria5': 4,
    },
    {
      'nama': 'Mikro',
      'kriteria1': 3,
      'kriteria2': 3,
      'kriteria3': 4,
      'kriteria4': 4,
      'kriteria5': 2,
    },
    {
      'nama': 'SPK',
      'kriteria1': 4,
      'kriteria2': 3,
      'kriteria3': 4,
      'kriteria4': 4,
      'kriteria5': 2,
    },
    {
      'nama': 'Jaringan',
      'kriteria1': 3,
      'kriteria2': 3,
      'kriteria3': 3,
      'kriteria4': 3,
      'kriteria5': 4,
    },
  ];

  // Langkah 1: Normalisasi Data
  List<List<double>> normalizedMatrix = [];
  for (var i = 0; i < alternatifData.length; i++) {
    List<double> normalizedValues = [];
    for (var j = 1; j <= kriteriaData.length; j++) {
      double nilai = alternatifData[i]['kriteria$j'] / 100.0;
      if (kriteriaData[j - 1]['jenis'] == 'cost') {
        nilai = 1 - nilai; // Invert nilai untuk kriteria cost
      }
      normalizedValues.add(nilai);
    }
    normalizedMatrix.add(normalizedValues);
  }

  // Langkah 2: Perhitungan Nilai Preferensi (Weighted Sum)
  List<double> weightedSumValues = [];
  for (var i = 0; i < alternatifData.length; i++) {
    double weightedSum = 0;
    for (var j = 0; j < kriteriaData.length; j++) {
      double bobot = kriteriaData[j]['bobot'];
      weightedSum += normalizedMatrix[i][j] * bobot;
    }
    weightedSumValues.add(weightedSum);
  }

  // Langkah 3: Menentukan Alternatif Terbaik
  double maxWeightedSum = weightedSumValues
      .reduce((value, element) => value > element ? value : element);
  int indexMax = weightedSumValues.indexOf(maxWeightedSum);

  String alternatifTerbaik = alternatifData[indexMax]['nama'];
  for (var i = 0; i < alternatifData.length; i++) {
    print("Alternatif: ${alternatifData[i]['nama']}");
    print("Nilai Akhir: ${weightedSumValues[i]}");
    print("---------------------------");
  }

  print("Alternatif terbaik: $alternatifTerbaik");
}
