import 'package:flutter/material.dart';

import '../data/app_session.dart';
import '../models/materi_model.dart';
import '../widgets/clay_card.dart';
import '../widgets/responsive_container.dart';
import 'sub_materi_detail_page.dart';

class BelajarPage extends StatefulWidget {
  final String initialFilter;

  const BelajarPage({super.key, this.initialFilter = 'Semua'});

  @override
  State<BelajarPage> createState() => _BelajarPageState();
}

class _BelajarPageState extends State<BelajarPage> {
  late String _filterAktif = widget.initialFilter;

  @override
  void didUpdateWidget(covariant BelajarPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialFilter != widget.initialFilter) {
      _filterAktif = widget.initialFilter;
    }
  }

  @override
  Widget build(BuildContext context) {
    final daftarMapel = AppSession.materiAktif;

    final List<String> kategori = ['Semua', ...daftarMapel.map((m) => m.judul)];

    final daftarItem = [];
    for (final m in daftarMapel) {
      if (_filterAktif == 'Semua' || _filterAktif == m.judul) {
        for (int i = 0; i < m.poin.length; i++) {
          daftarItem.add({'materi': m, 'nomor': i + 1, 'sub': m.poin[i]});
        }
      }
    }

    return SingleChildScrollView(
      child: ResponsiveContainer(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 700;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // BANNER HIJAU-TOSCA
                ClayCard(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF34D399), Color(0xFF38BDF8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _filterAktif == 'Semua'
                                  ? 'Ayo Buat Belajar\nJadi Menyenangkan!'
                                  : 'Ayo Buat $_filterAktif\nJadi Seru!',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                height: 1.25,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Klik kartu pelajaran untuk baca ringkasan & tonton video YouTube.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 14),
                      Container(
                        width: 78,
                        height: 78,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(55),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(
                          Icons.rocket_launch_rounded,
                          color: Colors.white,
                          size: 44,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // FILTER CHIP KATEGORI
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: kategori.map((kat) {
                      final aktif = _filterAktif == kat;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ChoiceChip(
                          label: Text(kat),
                          selected: aktif,
                          onSelected: (_) => setState(() => _filterAktif = kat),
                          selectedColor: const Color(0xFF7C5CFA),
                          backgroundColor: Colors.white,
                          labelStyle: TextStyle(
                            color: aktif
                                ? Colors.white
                                : const Color(0xFF2D264B),
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: BorderSide(
                              color: aktif
                                  ? const Color(0xFF7C5CFA)
                                  : Colors.grey.shade200,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 20),

                // DAFTAR KARTU SUB-MATERI
                GridView.builder(
                  itemCount: daftarItem.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isWide ? 2 : 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: isWide ? 2.5 : 2.9,
                  ),
                  itemBuilder: (context, index) {
                    final Materi m = daftarItem[index]['materi'];
                    final int nomor = daftarItem[index]['nomor'];
                    final SubMateri sub = daftarItem[index]['sub'];

                    return ClayCard(
                      padding: const EdgeInsets.all(14),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SubMateriDetailPage(
                              namaMapel: m.judul,
                              warna: m.warna,
                              nomor: nomor,
                              subMateri: sub,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: m.warna.withAlpha(35),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Icon(m.icon, color: m.warna, size: 34),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${m.judul} • Materi $nomor',
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.bold,
                                    color: m.warna,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  sub.judulRingkas,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13.5,
                                    color: Color(0xFF2D264B),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: LinearProgressIndicator(
                                          value: 0.75,
                                          minHeight: 6,
                                          backgroundColor: const Color(
                                            0xFFEDE9FE,
                                          ),
                                          color: const Color(0xFF7C5CFA),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Video',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          const CircleAvatar(
                            radius: 18,
                            backgroundColor: Color(0xFF7C5CFA),
                            child: Icon(
                              Icons.chevron_right_rounded,
                              color: Colors.white,
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
