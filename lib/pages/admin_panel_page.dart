import 'package:flutter/material.dart';

import '../data/app_session.dart';
import '../models/materi_model.dart';
import '../models/soal_model.dart';
import '../widgets/clay_card.dart';
import '../widgets/responsive_container.dart';

class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({super.key});

  @override
  State<AdminPanelPage> createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  int _subTab = 0; // 0 = Hasil Kuis, 1 = Kelola Materi, 2 = Kelola Soal

  // Controller Tambah Materi
  String _mapelMateri = AppSession.materiAktif.first.judul;
  final _judulRingkasCtrl = TextEditingController();
  final _penjelasanCtrl = TextEditingController();
  final _contohCtrl = TextEditingController();
  final _youtubeCtrl = TextEditingController();

  // Controller Tambah Soal
  String _mapelSoal = AppSession.materiAktif.first.judul;
  final _pertanyaanCtrl = TextEditingController();
  final _opsiACtrl = TextEditingController();
  final _opsiBCtrl = TextEditingController();
  final _opsiCCtrl = TextEditingController();
  final _opsiDCtrl = TextEditingController();
  int _kunciJawaban = 0;

  void _simpanMateriBaru() {
    if (_judulRingkasCtrl.text.trim().isEmpty ||
        _penjelasanCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Judul materi dan penjelasan wajib diisi!'),
        ),
      );
      return;
    }

    final linkYt = _youtubeCtrl.text.trim().isEmpty
        ? 'https://www.youtube.com/results?search_query=${Uri.encodeComponent(_judulRingkasCtrl.text)}'
        : _youtubeCtrl.text.trim();

    AppSession.tambahSubMateri(
      _mapelMateri,
      SubMateri(
        judulRingkas: _judulRingkasCtrl.text.trim(),
        penjelasanLengkap: _penjelasanCtrl.text.trim(),
        contoh: _contohCtrl.text.trim().isEmpty
            ? 'Contoh: Pelajari langkah-langkah pada penjelasan di atas.'
            : _contohCtrl.text.trim(),
        youtubeUrl: linkYt,
      ),
    );

    _judulRingkasCtrl.clear();
    _penjelasanCtrl.clear();
    _contohCtrl.clear();
    _youtubeCtrl.clear();

    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text('Materi baru berhasil ditambahkan ke $_mapelMateri!'),
      ),
    );
  }

  void _konfirmasiHapusMateri(String mapel, int indexSub, String judul) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Hapus Materi?'),
        content: Text('Yakin ingin menghapus materi "$judul" dari $mapel?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              AppSession.hapusSubMateri(mapel, indexSub);
              Navigator.pop(dialogCtx);
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text('Materi berhasil dihapus.'),
                ),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _simpanSoalBaru() {
    if (_pertanyaanCtrl.text.trim().isEmpty ||
        _opsiACtrl.text.trim().isEmpty ||
        _opsiBCtrl.text.trim().isEmpty ||
        _opsiCCtrl.text.trim().isEmpty ||
        _opsiDCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pertanyaan dan keempat pilihan jawaban wajib diisi!'),
        ),
      );
      return;
    }

    AppSession.tambahSoalBaru(
      Soal(
        mataPelajaran: _mapelSoal,
        pertanyaan: _pertanyaanCtrl.text.trim(),
        pilihan: [
          _opsiACtrl.text.trim(),
          _opsiBCtrl.text.trim(),
          _opsiCCtrl.text.trim(),
          _opsiDCtrl.text.trim(),
        ],
        jawaban: _kunciJawaban,
      ),
    );

    _pertanyaanCtrl.clear();
    _opsiACtrl.clear();
    _opsiBCtrl.clear();
    _opsiCCtrl.clear();
    _opsiDCtrl.clear();
    setState(() => _kunciJawaban = 0);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text('Soal baru berhasil ditambahkan ke kuis $_mapelSoal!'),
      ),
    );
  }

  void _konfirmasiHapusSoal(Soal soal) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Hapus Soal Kuis?'),
        content: Text('Yakin ingin menghapus soal:\n"${soal.pertanyaan}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              AppSession.hapusSoal(soal);
              Navigator.pop(dialogCtx);
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text('Soal berhasil dihapus dari bank kuis.'),
                ),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _judulRingkasCtrl.dispose();
    _penjelasanCtrl.dispose();
    _contohCtrl.dispose();
    _youtubeCtrl.dispose();
    _pertanyaanCtrl.dispose();
    _opsiACtrl.dispose();
    _opsiBCtrl.dispose();
    _opsiCCtrl.dispose();
    _opsiDCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner Admin
            ClayCard(
              gradient: const LinearGradient(
                colors: [Color(0xFF2D264B), Color(0xFF7C5CFA)],
              ),
              padding: const EdgeInsets.all(22),
              child: const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Panel Kontrol Admin',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Pantau nilai kuis murid serta kelola (tambah & hapus) materi pelajaran maupun soal kuis.',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Icon(
                    Icons.admin_panel_settings_rounded,
                    color: Colors.amberAccent,
                    size: 52,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Navigasi 3 Fitur Admin
            Row(
              children: [
                _adminTabBtn(0, 'Hasil Kuis', Icons.leaderboard_rounded),
                const SizedBox(width: 8),
                _adminTabBtn(1, 'Materi', Icons.menu_book_rounded),
                const SizedBox(width: 8),
                _adminTabBtn(2, 'Soal Kuis', Icons.quiz_rounded),
              ],
            ),
            const SizedBox(height: 20),

            if (_subTab == 0) _viewHasilKuisMurid(),
            if (_subTab == 1) _kelolaMateriSection(),
            if (_subTab == 2) _kelolaSoalSection(),
          ],
        ),
      ),
    );
  }

  Widget _adminTabBtn(int index, String label, IconData icon) {
    final aktif = _subTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _subTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: aktif ? const Color(0xFF7C5CFA) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C5CFA).withAlpha(20),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: aktif ? Colors.white : const Color(0xFF2D264B),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: aktif ? Colors.white : const Color(0xFF2D264B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 1. TAMPILAN HASIL KUIS MURID
  Widget _viewHasilKuisMurid() {
    return ValueListenableBuilder<List<HasilKuisMurid>>(
      valueListenable: AppSession.daftarHasilKuis,
      builder: (context, daftarHasil, _) {
        if (daftarHasil.isEmpty) {
          return const ClayCard(
            child: Center(
              child: Text('Belum ada murid yang mengerjakan kuis.'),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Riwayat Nilai Kuis Murid (${daftarHasil.length} Pengerjaan)',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2D264B),
              ),
            ),
            const SizedBox(height: 12),
            ...daftarHasil.map((h) {
              final lulus = h.skor >= 60;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ClayCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: lulus
                            ? Colors.green.shade50
                            : Colors.orange.shade50,
                        child: Text(
                          h.namaMurid[0].toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: lulus ? Colors.green : Colors.orange,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              h.namaMurid,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15.5,
                                color: Color(0xFF2D264B),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '${h.mataPelajaran} • Benar ${h.benar}/${h.totalSoal} soal',
                              style: TextStyle(
                                fontSize: 12.5,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            Text(
                              h.waktu,
                              style: TextStyle(
                                fontSize: 11.5,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: lulus
                              ? const Color(0xFFEDE9FE)
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '${h.skor}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: lulus
                                    ? const Color(0xFF7C5CFA)
                                    : Colors.red,
                              ),
                            ),
                            const Text(
                              'Nilai',
                              style: TextStyle(fontSize: 10.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  // 2. KELOLA MATERI (TAMBAH + DAFTAR & HAPUS)
  Widget _kelolaMateriSection() {
    final materiTerpilih = AppSession.materiAktif.firstWhere(
      (m) => m.judul == _mapelMateri,
      orElse: () => AppSession.materiAktif.first,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClayCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Tambah Materi Pelajaran Baru',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2D264B),
                ),
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                initialValue: _mapelMateri,
                decoration: _inputStyle('Pilih Mata Pelajaran'),
                items: AppSession.materiAktif
                    .map(
                      (m) => DropdownMenuItem(
                        value: m.judul,
                        child: Text(m.judul),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _mapelMateri = v);
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _judulRingkasCtrl,
                decoration: _inputStyle('Judul Materi Ringkas'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _penjelasanCtrl,
                maxLines: 3,
                decoration: _inputStyle('Penjelasan Lengkap Materi'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _contohCtrl,
                decoration: _inputStyle('Contoh Penerapan (Opsional)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _youtubeCtrl,
                decoration: _inputStyle('Link Video YouTube (Opsional)'),
              ),
              const SizedBox(height: 18),
              ElevatedButton.icon(
                onPressed: _simpanMateriBaru,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C5CFA),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.save_rounded),
                label: const Text(
                  'Simpan Materi ke Aplikasi',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Daftar Materi Aktif + Tombol Hapus
        Text(
          'Daftar Materi $_mapelMateri (${materiTerpilih.poin.length} Materi)',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: Color(0xFF2D264B),
          ),
        ),
        const SizedBox(height: 10),
        if (materiTerpilih.poin.isEmpty)
          const ClayCard(
            child: Center(child: Text('Belum ada materi untuk pelajaran ini.')),
          )
        else
          ...List.generate(materiTerpilih.poin.length, (idx) {
            final sub = materiTerpilih.poin[idx];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ClayCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: materiTerpilih.warna.withAlpha(35),
                      child: Text(
                        '${idx + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: materiTerpilih.warna,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        sub.judulRingkas,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xFF2D264B),
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Hapus Materi',
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.red,
                      ),
                      onPressed: () => _konfirmasiHapusMateri(
                        _mapelMateri,
                        idx,
                        sub.judulRingkas,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }

  // 3. KELOLA SOAL KUIS (TAMBAH + DAFTAR & HAPUS)
  Widget _kelolaSoalSection() {
    final daftarSoalMapel = AppSession.soalAktif
        .where((s) => s.mataPelajaran == _mapelSoal)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClayCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Tambah Soal Kuis Baru',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2D264B),
                ),
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                initialValue: _mapelSoal,
                decoration: _inputStyle('Kategori Mata Pelajaran'),
                items: AppSession.materiAktif
                    .map(
                      (m) => DropdownMenuItem(
                        value: m.judul,
                        child: Text(m.judul),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _mapelSoal = v);
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _pertanyaanCtrl,
                maxLines: 2,
                decoration: _inputStyle('Tulis Pertanyaan Kuis'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _opsiACtrl,
                decoration: _inputStyle('Pilihan A'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _opsiBCtrl,
                decoration: _inputStyle('Pilihan B'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _opsiCCtrl,
                decoration: _inputStyle('Pilihan C'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _opsiDCtrl,
                decoration: _inputStyle('Pilihan D'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
                initialValue: _kunciJawaban,
                decoration: _inputStyle('Kunci Jawaban Benar'),
                items: const [
                  DropdownMenuItem(value: 0, child: Text('Jawaban A')),
                  DropdownMenuItem(value: 1, child: Text('Jawaban B')),
                  DropdownMenuItem(value: 2, child: Text('Jawaban C')),
                  DropdownMenuItem(value: 3, child: Text('Jawaban D')),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _kunciJawaban = v);
                },
              ),
              const SizedBox(height: 18),
              ElevatedButton.icon(
                onPressed: _simpanSoalBaru,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C5CFA),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.add_task_rounded),
                label: const Text(
                  'Simpan Soal ke Bank Kuis',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Daftar Bank Soal + Tombol Hapus
        Text(
          'Bank Soal $_mapelSoal (${daftarSoalMapel.length} Soal)',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: Color(0xFF2D264B),
          ),
        ),
        const SizedBox(height: 10),
        if (daftarSoalMapel.isEmpty)
          const ClayCard(
            child: Center(child: Text('Belum ada soal untuk pelajaran ini.')),
          )
        else
          ...List.generate(daftarSoalMapel.length, (idx) {
            final soal = daftarSoalMapel[idx];
            final hurufKunci = String.fromCharCode(65 + soal.jawaban);
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ClayCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: const Color(0xFFEDE9FE),
                      child: Text(
                        '${idx + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7C5CFA),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            soal.pertanyaan,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Color(0xFF2D264B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Kunci: $hurufKunci. ${soal.pilihan[soal.jawaban]}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Hapus Soal',
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.red,
                      ),
                      onPressed: () => _konfirmasiHapusSoal(soal),
                    ),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }

  InputDecoration _inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color(0xFFF5F3FF),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
}
