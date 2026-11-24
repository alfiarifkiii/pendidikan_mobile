import 'package:flutter/foundation.dart';

import '../models/materi_model.dart';
import '../models/soal_model.dart';
import 'materi_data.dart';
import 'soal_data.dart';

class HasilKuisMurid {
  final String namaMurid;
  final String mataPelajaran;
  final int skor;
  final int benar;
  final int totalSoal;
  final String waktu;

  const HasilKuisMurid({
    required this.namaMurid,
    required this.mataPelajaran,
    required this.skor,
    required this.benar,
    required this.totalSoal,
    required this.waktu,
  });
}

class AppSession {
  static String namaUser = 'Juara';
  static bool isAdmin = false;

  static final List<Materi> materiAktif = daftarMateri
      .map(
        (m) => Materi(
          judul: m.judul,
          deskripsi: m.deskripsi,
          icon: m.icon,
          warna: m.warna,
          poin: List<SubMateri>.from(m.poin),
        ),
      )
      .toList();

  static final List<Soal> soalAktif = List<Soal>.from(daftarSoal);

  static final ValueNotifier<List<HasilKuisMurid>> daftarHasilKuis =
      ValueNotifier<List<HasilKuisMurid>>([
        const HasilKuisMurid(
          namaMurid: 'Rina',
          mataPelajaran: 'Matematika',
          skor: 80,
          benar: 4,
          totalSoal: 5,
          waktu: 'Hari ini, 09:15',
        ),
        const HasilKuisMurid(
          namaMurid: 'Dimas',
          mataPelajaran: 'IPA',
          skor: 100,
          benar: 5,
          totalSoal: 5,
          waktu: 'Hari ini, 10:05',
        ),
      ]);

  static void loginSebagaiMurid(String nama) {
    namaUser = nama.trim().isEmpty ? 'Juara' : nama.trim();
    isAdmin = false;
  }

  static void loginSebagaiAdmin(String nama) {
    namaUser = nama.trim().isEmpty ? 'Admin Guru' : nama.trim();
    isAdmin = true;
  }

  static void tambahSubMateri(String judulMapel, SubMateri subBaru) {
    final index = materiAktif.indexWhere((m) => m.judul == judulMapel);
    if (index != -1) {
      materiAktif[index].poin.add(subBaru);
    }
  }

  static void hapusSubMateri(String judulMapel, int indexSub) {
    final index = materiAktif.indexWhere((m) => m.judul == judulMapel);
    if (index != -1 &&
        indexSub >= 0 &&
        indexSub < materiAktif[index].poin.length) {
      materiAktif[index].poin.removeAt(indexSub);
    }
  }

  static void tambahSoalBaru(Soal soalBaru) {
    soalAktif.add(soalBaru);
  }

  static void hapusSoal(Soal soalTarget) {
    soalAktif.remove(soalTarget);
  }

  static void catatHasilKuis({
    required String mataPelajaran,
    required int skor,
    required int benar,
    required int totalSoal,
  }) {
    final now = DateTime.now();
    final jam = now.hour.toString().padLeft(2, '0');
    final menit = now.minute.toString().padLeft(2, '0');

    final dataBaru = HasilKuisMurid(
      namaMurid: isAdmin ? '$namaUser (Admin)' : namaUser,
      mataPelajaran: mataPelajaran,
      skor: skor,
      benar: benar,
      totalSoal: totalSoal,
      waktu: 'Hari ini, $jam:$menit',
    );

    daftarHasilKuis.value = [dataBaru, ...daftarHasilKuis.value];
  }
}
