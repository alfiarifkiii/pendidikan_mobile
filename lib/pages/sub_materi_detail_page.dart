import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/materi_data.dart';
import '../data/riwayat_belajar.dart';
import '../models/materi_model.dart';
import '../widgets/responsive_container.dart';

class SubMateriDetailPage extends StatefulWidget {
  final String namaMapel;
  final Color warna;
  final int nomor;
  final SubMateri subMateri;

  const SubMateriDetailPage({
    super.key,
    required this.namaMapel,
    required this.warna,
    required this.nomor,
    required this.subMateri,
  });

  @override
  State<SubMateriDetailPage> createState() => _SubMateriDetailPageState();
}

class _SubMateriDetailPageState extends State<SubMateriDetailPage> {
  @override
  void initState() {
    super.initState();
    // Otomatis simpan materi yang sedang dibuka ke "Lanjut Belajar"
    final materiInduk = daftarMateri.firstWhere(
      (m) => m.judul == widget.namaMapel,
      orElse: () => daftarMateri[0],
    );
    RiwayatBelajar.simpan(
      materi: materiInduk,
      nomorBab: widget.nomor,
      subMateri: widget.subMateri,
    );
  }

  Future<void> _bukaYoutube(BuildContext context) async {
    final Uri url = Uri.parse(widget.subMateri.youtubeUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal membuka link YouTube')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.namaMapel} • Materi ${widget.nomor}'),
        backgroundColor: widget.warna,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 720;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: widget.warna.withAlpha(28),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: widget.warna.withAlpha(80)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: widget.warna,
                          child: Text(
                            '${widget.nomor}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            widget.subMateri.judulRingkas,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (isWide)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: _bagianPenjelasan()),
                        const SizedBox(width: 20),
                        Expanded(flex: 2, child: _bagianYoutube(context)),
                      ],
                    )
                  else ...[
                    _bagianPenjelasan(),
                    const SizedBox(height: 22),
                    _bagianYoutube(context),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _bagianPenjelasan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Penjelasan Materi',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Text(
              widget.subMateri.penjelasanLengkap,
              style: const TextStyle(fontSize: 15, height: 1.6),
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Contoh Penerapan',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          color: Colors.amber.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.lightbulb, color: Colors.amber),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.subMateri.contoh,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _bagianYoutube(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Video Pembelajaran',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => _bukaYoutube(context),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red.shade600, Colors.red.shade400],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Tonton Penjelasan di YouTube',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Klik untuk membuka referensi video pembelajaran ${widget.namaMapel}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
