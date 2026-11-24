import 'package:flutter/material.dart';

import '../data/app_session.dart';
import '../models/soal_model.dart';
import '../widgets/clay_card.dart';
import '../widgets/responsive_container.dart';

class KuisPage extends StatefulWidget {
  const KuisPage({super.key});

  @override
  State<KuisPage> createState() => _KuisPageState();
}

class _KuisPageState extends State<KuisPage> {
  String? _mapelDipilih;
  Color _warnaAktif = const Color(0xFF7C5CFA);
  List<Soal> _soalAktif = [];

  int _nomor = 0;
  int _skor = 0;
  int? _jawabanDipilih;
  bool _selesai = false;

  void _mulaiKuis(String mapel, Color warna) {
    final bool isSemuaPelajaran = mapel == 'Semua Pelajaran';

    final List<Soal> sumberSoal = isSemuaPelajaran
        ? List<Soal>.from(AppSession.soalAktif)
        : AppSession.soalAktif.where((s) => s.mataPelajaran == mapel).toList();

    sumberSoal.shuffle();

    final int batasSoal = isSemuaPelajaran ? 20 : 10;
    final List<Soal> soalTerpilih = sumberSoal.take(batasSoal).toList();

    setState(() {
      _mapelDipilih = mapel;
      _warnaAktif = warna;
      _soalAktif = soalTerpilih;
      _nomor = 0;
      _skor = 0;
      _jawabanDipilih = null;
      _selesai = false;
    });
  }

  void _kembaliPilihMapel() {
    setState(() {
      _mapelDipilih = null;
      _selesai = false;
    });
  }

  void _jawab(int index) {
    if (_jawabanDipilih != null) return;
    setState(() {
      _jawabanDipilih = index;
      if (index == _soalAktif[_nomor].jawaban) _skor++;
    });
  }

  void _lanjut() {
    setState(() {
      if (_nomor < _soalAktif.length - 1) {
        _nomor++;
        _jawabanDipilih = null;
      } else {
        _selesai = true;
        final nilaiAkhir = (_skor / _soalAktif.length * 100).round();
        AppSession.catatHasilKuis(
          mataPelajaran: _mapelDipilih!,
          skor: nilaiAkhir,
          benar: _skor,
          totalSoal: _soalAktif.length,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_mapelDipilih == null) {
      return _layarPilihMapel();
    }
    if (_selesai) {
      return _layarHasilBintang();
    }
    return _layarPertanyaan();
  }

  // 1. LAYAR PILIH KATEGORI KUIS
  Widget _layarPilihMapel() {
    final daftarMapel = AppSession.materiAktif;

    return SingleChildScrollView(
      child: ResponsiveContainer(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 680;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClayCard(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7C5CFA), Color(0xFFA78BFA)],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Uji Kepintaranmu!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Pilih kuis campuran (20 soal) atau fokus pada satu mata pelajaran (10 soal acak)!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      Icon(
                        Icons.emoji_events_rounded,
                        color: Colors.amberAccent,
                        size: 64,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Pilih Kategori Kuis',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2D264B),
                  ),
                ),
                const SizedBox(height: 14),
                ClayCard(
                  onTap: () =>
                      _mulaiKuis('Semua Pelajaran', const Color(0xFF7C5CFA)),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDE9FE),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.all_inclusive_rounded,
                          color: Color(0xFF7C5CFA),
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Semua Pelajaran (20 Soal Acak)',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Color(0xFF2D264B),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Soal campuran dari seluruh mata pelajaran',
                              style: TextStyle(
                                fontSize: 12.5,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const CircleAvatar(
                        backgroundColor: Color(0xFF7C5CFA),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  itemCount: daftarMapel.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isWide ? 2 : 1,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: isWide ? 2.7 : 3.1,
                  ),
                  itemBuilder: (context, index) {
                    final m = daftarMapel[index];
                    return ClayCard(
                      onTap: () => _mulaiKuis(m.judul, m.warna),
                      child: Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: m.warna.withAlpha(35),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(m.icon, color: m.warna, size: 28),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Kuis ${m.judul}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15.5,
                                    color: Color(0xFF2D264B),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '5 soal acak khusus ${m.judul}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: m.warna,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // 2. LAYAR MENGERJAKAN SOAL
  Widget _layarPertanyaan() {
    final s = _soalAktif[_nomor];
    return SingleChildScrollView(
      child: ResponsiveContainer(
        maxWidth: 740,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: _kembaliPilihMapel,
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: const Text('Ganti Mapel'),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _warnaAktif.withAlpha(30),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    'Soal ${_nomor + 1} / ${_soalAktif.length}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _warnaAktif,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: (_nomor + 1) / _soalAktif.length,
                minHeight: 10,
                backgroundColor: Colors.white,
                color: _warnaAktif,
              ),
            ),
            const SizedBox(height: 20),
            ClayCard(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.mataPelajaran,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: _warnaAktif,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    s.pertanyaan,
                    style: const TextStyle(
                      fontSize: 18.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2D264B),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            for (int i = 0; i < s.pilihan.length; i++) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ClayCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  color: _jawabanDipilih == null
                      ? Colors.white
                      : i == s.jawaban
                      ? Colors.green.shade50
                      : i == _jawabanDipilih
                      ? Colors.red.shade50
                      : Colors.white,
                  onTap: () => _jawab(i),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: _warnaAktif.withAlpha(35),
                        child: Text(
                          String.fromCharCode(65 + i),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _warnaAktif,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          s.pilihan[i],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (_jawabanDipilih != null && i == s.jawaban)
                        const Icon(Icons.check_circle, color: Colors.green),
                      if (_jawabanDipilih != null &&
                          i == _jawabanDipilih &&
                          i != s.jawaban)
                        const Icon(Icons.cancel, color: Colors.red),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 10),
            if (_jawabanDipilih != null)
              ElevatedButton(
                onPressed: _lanjut,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _warnaAktif,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text(
                  _nomor == _soalAktif.length - 1
                      ? 'Lihat Pencapaian!'
                      : 'Soal Berikutnya',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // 3. LAYAR HASIL & LENCANA
  Widget _layarHasilBintang() {
    final nilai = (_skor / _soalAktif.length * 100).round();
    return SingleChildScrollView(
      child: ResponsiveContainer(
        maxWidth: 740,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClayCard(
              gradient: const LinearGradient(
                colors: [Color(0xFFEDE9FE), Color(0xFFD8B4FE)],
              ),
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kerja Bagus, ${AppSession.namaUser}!\nKamu Bintangnya! ⭐',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF2D264B),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Hasil kuis $_mapelDipilih otomatis tersimpan di riwayat nilai.',
                          style: const TextStyle(
                            fontSize: 13.5,
                            color: Color(0xFF4C1D95),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 82,
                    height: 82,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Icons.emoji_events_rounded,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Progres Kamu',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2D264B),
              ),
            ),
            const SizedBox(height: 10),
            ClayCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _statKolom(
                    'Skor Akhir',
                    '$nilai',
                    Icons.auto_stories,
                    const Color(0xFF7C5CFA),
                  ),
                  _statKolom(
                    'Jawaban Benar',
                    '$_skor/${_soalAktif.length}',
                    Icons.local_fire_department_rounded,
                    Colors.orange,
                  ),
                  _statKolom(
                    'Lencana',
                    '5',
                    Icons.military_tech_rounded,
                    Colors.amber.shade700,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Lencana Pencapaian',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2D264B),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _badgeItem(
                  Icons.pets_rounded,
                  'Langkah Awal',
                  const Color(0xFF7C5CFA),
                ),
                _badgeItem(
                  Icons.calculate_rounded,
                  'Jenius Angka',
                  Colors.orange,
                ),
                _badgeItem(
                  Icons.science_rounded,
                  'Bintang Sains',
                  Colors.green,
                ),
                _badgeItem(
                  Icons.menu_book_rounded,
                  'Suka Baca',
                  Colors.pinkAccent,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _kembaliPilihMapel,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(Icons.grid_view_rounded),
                    label: const Text('Pilih Mapel Lain'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _mulaiKuis(_mapelDipilih!, _warnaAktif),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7C5CFA),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text(
                      'Ulangi Kuis',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statKolom(String label, String nilai, IconData icon, Color warna) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Text(
              nilai,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color(0xFF2D264B),
              ),
            ),
            const SizedBox(width: 6),
            Icon(icon, color: warna, size: 22),
          ],
        ),
      ],
    );
  }

  Widget _badgeItem(IconData icon, String title, Color warna) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: warna.withAlpha(35),
              shape: BoxShape.circle,
              border: Border.all(color: warna.withAlpha(90), width: 2),
            ),
            child: Icon(icon, color: warna, size: 28),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
