class KriteriaDetail {
  final String nama;
  final double bobot;
  final String jenis;
  final Map<String, dynamic> subkriteria;

  KriteriaDetail({
    required this.nama,
    required this.bobot,
    required this.jenis,
    required this.subkriteria,
  });

  factory KriteriaDetail.fromFirestore(Map<String, dynamic> data) {
    return KriteriaDetail(
      nama: data['nama'] ?? '',
      bobot: (data['bobot'] ?? 0).toDouble(),
      jenis: data['jenis'] ?? '',
      subkriteria: Map<String, dynamic>.from(data['subkriteria'] ?? {}),
    );
  }
}
