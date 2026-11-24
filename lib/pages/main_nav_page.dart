import 'package:flutter/material.dart';

import '../data/app_session.dart';
import 'admin_panel_page.dart';
import 'belajar_page.dart';
import 'beranda_page.dart';
import 'kuis_page.dart';
import 'login_page.dart';
import 'tentang_page.dart';

class MainNavPage extends StatefulWidget {
  const MainNavPage({super.key});

  @override
  State<MainNavPage> createState() => _MainNavPageState();
}

class _MainNavPageState extends State<MainNavPage> {
  int _selectedIndex = 0;
  String _selectedMapelBelajar = 'Semua';

  void _bukaTabBelajar(String mapel) {
    setState(() {
      _selectedMapelBelajar = mapel;
      _selectedIndex = 1;
    });
  }

  void _bukaTabKuis() {
    setState(() {
      _selectedIndex = 2;
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isAdmin = AppSession.isAdmin;

    final List<Widget> pages = [
      BerandaPage(onSelectMapel: _bukaTabBelajar, onStartKuis: _bukaTabKuis),
      BelajarPage(initialFilter: _selectedMapelBelajar),
      const KuisPage(),
      const TentangPage(),
      if (isAdmin) const AdminPanelPage(),
    ];

    final List<String> titles = [
      'KidsSmart',
      'Ruang Belajar',
      'Kuis & Tantangan',
      'Tentang Aplikasi',
      if (isAdmin) 'Panel Admin',
    ];

    final List<BottomNavigationBarItem> navItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_rounded),
        label: 'Beranda',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.school_rounded),
        label: 'Belajar',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.emoji_events_rounded),
        label: 'Kuis',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.info_rounded),
        label: 'Tentang',
      ),
      if (isAdmin)
        const BottomNavigationBarItem(
          icon: Icon(Icons.admin_panel_settings_rounded),
          label: 'Admin',
        ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 14, top: 8, bottom: 8),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFD54F), Color(0xFFFF9800)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withAlpha(60),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.face_retouching_natural_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        title: Text(titles[_selectedIndex]),
        actions: [
          IconButton(
            tooltip: 'Keluar / Ganti Akun',
            onPressed: _logout,
            icon: const Icon(Icons.logout_rounded, color: Color(0xFF7C5CFA)),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7C5CFA).withAlpha(25),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (i) => setState(() => _selectedIndex = i),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF7C5CFA),
            unselectedItemColor: Colors.grey.shade400,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: navItems,
          ),
        ),
      ),
    );
  }
}
