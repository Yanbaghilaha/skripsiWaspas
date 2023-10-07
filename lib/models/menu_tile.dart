import 'dart:js';

import 'package:flutter/material.dart';

import '../admin/judulmahasiswa/daftar_judul_mahasiswa.dart';
import '../extract_widget/admin_menu.dart';
import '../material/colors.dart';

class MenuTile {
  final String judul, subJudul, imageAssets;
  final Color colorBackgroundIcon;
  final Function onTap;

  MenuTile(
    this.judul,
    this.subJudul,
    this.imageAssets,
    this.colorBackgroundIcon,
    this.onTap,
  );
}

List<AdminMenu> menuTile = [
  AdminMenu(
    onTap: () {
      Navigator.push(
          context as BuildContext,
          MaterialPageRoute(
              builder: (context) => const DaftarJudulMahasiswa()));
    },
    // onTap: () {
    //   Navigator.push(context as BuildContext,
    //       MaterialPageRoute(builder: (context) => const DaftarTemaSkripsi()));
    // },
    judul: "Daftar Tema Skripsi",
    subJudul:
        "Konfigurasi tema yang berada pada STIKOM Poltek Cirebon (Data Alternatif)",
    imageAssets: "assets/illustration/daftar-tema-skripsi.png",
    colorBackgroundIcon: AppColors.blue,
  ),
  AdminMenu(
    onTap: () {},
    judul: "Daftar Data Kriteria",
    subJudul: "Konfigurasi tema yang berada  pada STIKOM Poltek Cirebon)",
    imageAssets: "assets/illustration/daftar-tema-skripsi.png",
    colorBackgroundIcon: AppColors.green,
  ),
  AdminMenu(
    onTap: () {},
    judul: "Daftar Data Alternatif",
    subJudul: "Konfigurasi tema yang berada  pada STIKOM Poltek Cirebon)",
    imageAssets: "assets/illustration/daftar-tema-skripsi.png",
    colorBackgroundIcon: AppColors.red,
  ),
];
