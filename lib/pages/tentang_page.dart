import 'package:flutter/material.dart';

import '../data/kelompok_data.dart';
import '../widgets/anggota_avatar.dart';
import '../widgets/clay_card.dart';
import '../widgets/responsive_container.dart';
import 'anggota_detail_page.dart';

class TentangPage extends StatelessWidget {
  const TentangPage({super.key});

  @override
  Widget build(BuildContext context) {
    final infoList = [
      {
        'title': 'Nama Aplikasi',
        'value': 'KidsSmart',
        'icon': Icons.apps_rounded,
        'color': const Color(0xFF7C5CFA),
      },
      {
        'title': 'Kategori',
        'value': 'E-Learning Anak',
        'icon': Icons.child_care_rounded,
        'color': Colors.orange,
      },
      {
        'title': 'Versi',
        'value': '1.0.0',
        'icon': Icons.verified_rounded,
        'color': Colors.green,
      },
      {
        'title': 'Pengembang',
        'value': 'Kelompok Mahasiswa',
        'icon': Icons.code_rounded,
        'color': Colors.pinkAccent,
      },
    ];

    return SingleChildScrollView(
      child: ResponsiveContainer(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 680;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. IDENTITAS APLIKASI
                ClayCard(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7C5CFA), Color(0xFF9E86FF)],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 38,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.school_rounded,
                          size: 42,
                          color: Color(0xFF7C5CFA),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'KidsSmart',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Aplikasi E-Learning interaktif penuh warna untuk membantu anak belajar Matematika, Bahasa, dan Sains dengan menyenangkan.',
                              style: TextStyle(
                                fontSize: 13.5,
                                color: Colors.white,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                GridView.builder(
                  itemCount: infoList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isWide ? 4 : 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: isWide ? 1.8 : 2.1,
                  ),
                  itemBuilder: (context, index) {
                    final item = infoList[index];
                    final color = item['color'] as Color;
                    return ClayCard(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: color.withAlpha(35),
                            child: Icon(item['icon'] as IconData, color: color),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item['title'] as String,
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  item['value'] as String,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.5,
                                    color: Color(0xFF2D264B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 28),

                // 2. KELOMPOK PENGEMBANG (MENAMPILKAN FOTO)
                const Text(
                  'Kelompok Pengembang',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2D264B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Klik salah satu anggota untuk melihat profil lengkap, hobi, dan motto hidup.',
                  style: TextStyle(fontSize: 13.5, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 14),

                GridView.builder(
                  itemCount: daftarAnggota.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isWide ? 2 : 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: isWide ? 2.2 : 2.6,
                  ),
                  itemBuilder: (context, index) {
                    final anggota = daftarAnggota[index];
                    return ClayCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AnggotaDetailPage(anggota: anggota),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF7C5CFA),
                                width: 2.5,
                              ),
                            ),
                            child: AnggotaAvatar(
                              path: anggota.foto,
                              nama: anggota.nama,
                              ukuran: 68,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  anggota.nama,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15.5,
                                    color: Color(0xFF2D264B),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  anggota.nim,
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEDE9FE),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    anggota.jabatan,
                                    style: const TextStyle(
                                      color: Color(0xFF7C5CFA),
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const CircleAvatar(
                            radius: 16,
                            backgroundColor: Color(0xFFF5F3FF),
                            child: Icon(
                              Icons.chevron_right_rounded,
                              color: Color(0xFF7C5CFA),
                            ),
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
}
