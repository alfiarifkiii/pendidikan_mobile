import 'package:flutter/material.dart';

class SubMateri {
  final String judulRingkas;
  final String penjelasanLengkap;
  final String contoh;
  final String youtubeUrl;

  const SubMateri({
    required this.judulRingkas,
    required this.penjelasanLengkap,
    required this.contoh,
    required this.youtubeUrl,
  });
}

class Materi {
  final String judul;
  final String deskripsi;
  final IconData icon;
  final Color warna;
  final List<SubMateri> poin;

  const Materi({
    required this.judul,
    required this.deskripsi,
    required this.icon,
    required this.warna,
    required this.poin,
  });
}
