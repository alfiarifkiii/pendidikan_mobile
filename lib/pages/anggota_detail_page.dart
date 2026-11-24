import 'package:flutter/material.dart';

import '../models/anggota_model.dart';
import '../widgets/anggota_avatar.dart';
import '../widgets/responsive_container.dart';

class AnggotaDetailPage extends StatelessWidget {
  final AnggotaKelompok anggota;

  const AnggotaDetailPage({super.key, required this.anggota});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Anggota')),
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          maxWidth: 750,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Kartu Header Profil Utama
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: AnggotaAvatar(
                        path: anggota.foto,
                        nama: anggota.nama,
                        ukuran: 110,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      anggota.nama,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      anggota.nim,
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        anggota.jabatan,
                        style: const TextStyle(
                          color: Color(0xFF1565C0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Kartu Deskripsi
              _infoCard(
                icon: Icons.person_outline,
                warnaIcon: const Color(0xFF1565C0),
                judul: 'Deskripsi',
                isi: anggota.deskripsi,
              ),

              // Kartu Hobi
              _infoCard(
                icon: Icons.favorite_border,
                warnaIcon: Colors.orange,
                judul: 'Hobi',
                isi: anggota.hobi,
              ),

              // Kartu Motto Hidup
              _infoCard(
                icon: Icons.format_quote,
                warnaIcon: Colors.green,
                judul: 'Motto Hidup',
                isi: '"${anggota.mottoHidup}"',
                isItalic: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required Color warnaIcon,
    required String judul,
    required String isi,
    bool isItalic = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: warnaIcon.withAlpha(35),
              child: Icon(icon, color: warnaIcon),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isi,
                    style: TextStyle(
                      fontSize: 14.5,
                      height: 1.5,
                      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
