import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../data/app_session.dart';
import '../data/riwayat_belajar.dart';
import '../widgets/clay_card.dart';
import '../widgets/responsive_container.dart';
import 'sub_materi_detail_page.dart';

class BerandaPage extends StatefulWidget {
  final Function(String) onSelectMapel;
  final VoidCallback onStartKuis;

  const BerandaPage({
    super.key,
    required this.onSelectMapel,
    required this.onStartKuis,
  });

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  int _targetSelesai = 3;
  final int _totalTarget = 5;

  @override
  Widget build(BuildContext context) {
    final daftarMapel = AppSession.materiAktif;

    return SingleChildScrollView(
      child: ResponsiveContainer(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 720;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. HEADER GREETING + KARTU DAILY GOAL
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 3, child: _greetingBanner()),
                      const SizedBox(width: 20),
                      Expanded(flex: 2, child: _dailyGoalCard()),
                    ],
                  )
                else ...[
                  _greetingBanner(),
                  const SizedBox(height: 18),
                  _dailyGoalCard(),
                ],

                const SizedBox(height: 24),

                // 2. KATEGORI MATA PELAJARAN (4 TERLIHAT, BISA DI-SCROLL KE SAMPING)
                const Text(
                  'Pilih Pelajaran Seru',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2D264B),
                  ),
                ),
                const SizedBox(height: 12),
                ClayCard(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: LayoutBuilder(
                    builder: (context, cardConstraints) {
                      final double itemWidth = cardConstraints.maxWidth / 4;

                      return ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                            PointerDeviceKind.trackpad,
                          },
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: daftarMapel.map((m) {
                              return SizedBox(
                                width: itemWidth,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(18),
                                  onTap: () => widget.onSelectMapel(m.judul),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 62,
                                          height: 62,
                                          decoration: BoxDecoration(
                                            color: m.warna.withAlpha(35),
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            border: Border.all(
                                              color: m.warna.withAlpha(90),
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Icon(
                                            m.icon,
                                            color: m.warna,
                                            size: 32,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          m.judul == 'Bahasa Indonesia'
                                              ? 'B. Indo'
                                              : m.judul == 'Bahasa Inggris'
                                              ? 'B. Inggris'
                                              : m.judul,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 13,
                                            color: Color(0xFF2D264B),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 26),

                // 3. LANJUT BELAJAR (OTOMATIS BERUBAH SESUAI MATERI TERAKHIR DIBUKA)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Lanjut Belajar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2D264B),
                      ),
                    ),
                    TextButton(
                      onPressed: () => widget.onSelectMapel('Semua'),
                      child: const Text(
                        'Lihat Semua',
                        style: TextStyle(
                          color: Color(0xFF7C5CFA),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder<RiwayatItem>(
                  valueListenable: RiwayatBelajar.terakhirDibuka,
                  builder: (context, riwayat, _) {
                    final mapel = riwayat.materi;
                    final persen = (riwayat.progress * 100).round();

                    return ClayCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SubMateriDetailPage(
                              namaMapel: mapel.judul,
                              warna: mapel.warna,
                              nomor: riwayat.nomorBab,
                              subMateri: riwayat.subMateri,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 68,
                            height: 68,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  mapel.warna,
                                  mapel.warna.withAlpha(180),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Icon(
                              mapel.icon,
                              color: Colors.white,
                              size: 38,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  riwayat.subMateri.judulRingkas,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    color: Color(0xFF2D264B),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${mapel.judul} • Materi ${riwayat.nomorBab}',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: LinearProgressIndicator(
                                          value: riwayat.progress,
                                          minHeight: 8,
                                          backgroundColor: const Color(
                                            0xFFEDE9FE,
                                          ),
                                          color: const Color(0xFF7C5CFA),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      '$persen%',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Color(0xFF7C5CFA),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          const CircleAvatar(
                            radius: 22,
                            backgroundColor: Color(0xFF7C5CFA),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 26),

                // 4. REKOMENDASI MATERI UNTUKMU
                const Text(
                  'Rekomendasi Untukmu',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2D264B),
                  ),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  itemCount: daftarMapel.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isWide ? 4 : 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.95,
                  ),
                  itemBuilder: (context, index) {
                    final m = daftarMapel[index];
                    return ClayCard(
                      padding: const EdgeInsets.all(14),
                      onTap: () => widget.onSelectMapel(m.judul),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [m.warna, m.warna.withAlpha(170)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Icon(
                                m.icon,
                                size: 46,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            m.judul,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: Color(0xFF2D264B),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${m.poin.length} Pelajaran Seru',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
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

  Widget _greetingBanner() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Halo, ${AppSession.namaUser}! 👋',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF7C5CFA),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Siap belajar hal\nseru hari ini?',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                  color: Color(0xFF2D264B),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: widget.onStartKuis,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C5CFA),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.bolt_rounded),
                label: const Text(
                  'Tantangan Kuis',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 105,
          height: 105,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFD54F), Color(0xFFFF9800)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withAlpha(70),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.face_retouching_natural_rounded,
            size: 62,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _dailyGoalCard() {
    final progress = _targetSelesai / _totalTarget;
    return ClayCard(
      gradient: const LinearGradient(
        colors: [Color(0xFF7C5CFA), Color(0xFF9E86FF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Target Harian',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Pertahankan semangat belajarmu!',
                  style: TextStyle(color: Colors.white70, fontSize: 12.5),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 9,
                          backgroundColor: Colors.white24,
                          color: Colors.amberAccent,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '$_targetSelesai/$_totalTarget Materi',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              setState(() {
                _targetSelesai = _targetSelesai < _totalTarget
                    ? _targetSelesai + 1
                    : 1;
              });
            },
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(30),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.star_rounded,
                color: Colors.white,
                size: 44,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
