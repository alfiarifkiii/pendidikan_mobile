import 'package:flutter/foundation.dart';

import '../models/materi_model.dart';
import 'materi_data.dart';

class RiwayatItem {
  final Materi materi;
  final int nomorBab;
  final SubMateri subMateri;
  final double progress;

  const RiwayatItem({
    required this.materi,
    required this.nomorBab,
    required this.subMateri,
    required this.progress,
  });
}

class RiwayatBelajar {
  static final ValueNotifier<RiwayatItem> terakhirDibuka =
      ValueNotifier<RiwayatItem>(
        RiwayatItem(
          materi: daftarMateri[0],
          nomorBab: 1,
          subMateri: daftarMateri[0].poin[0],
          progress: 0.6,
        ),
      );

  static void simpan({
    required Materi materi,
    required int nomorBab,
    required SubMateri subMateri,
  }) {
    // Hitung persentase bab berdasarkan urutan bab dalam mata pelajaran
    final double hitungProgress = (nomorBab / materi.poin.length).clamp(
      0.25,
      1.0,
    );
    terakhirDibuka.value = RiwayatItem(
      materi: materi,
      nomorBab: nomorBab,
      subMateri: subMateri,
      progress: hitungProgress,
    );
  }
}
