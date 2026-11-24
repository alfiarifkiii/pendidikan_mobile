import 'package:flutter/material.dart';

import '../data/app_session.dart';
import '../widgets/clay_card.dart';
import '../widgets/responsive_container.dart';

import 'package:pendidikan1/pages/main_nav_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _pilihAdmin = false;
  final _namaController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorText;

  void _prosesLogin() {
    setState(() => _errorText = null);

    if (_pilihAdmin) {
      final user = _usernameController.text.trim();
      final pass = _passwordController.text.trim();

      if (user == 'admin' && pass == 'admin123') {
        AppSession.loginSebagaiAdmin('Admin KidsSmart');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainNavPage()),
        );
      } else {
        setState(() {
          _errorText =
              'Username atau password Admin salah! (Gunakan: admin / admin123)';
        });
      }
    } else {
      final nama = _namaController.text.trim();
      if (nama.isEmpty) {
        setState(() {
          _errorText = 'Silakan masukkan nama panggilanmu dulu ya!';
        });
        return;
      }
      AppSession.loginSebagaiMurid(nama);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavPage()),
      );
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ResponsiveContainer(
            maxWidth: 480,
            child: Column(
              children: [
                // Logo Maskot KidsSmart
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFD54F), Color(0xFFFF9800)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(28),
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
                    color: Colors.white,
                    size: 52,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Selamat Datang di KidsSmart',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF2D264B),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Pilih peran masuk untuk mulai belajar atau mengelola materi',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13.5, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 24),

                ClayCard(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Pemilih Peran Murid vs Admin
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F3FF),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _roleTab(
                                label: 'Murid',
                                icon: Icons.child_care_rounded,
                                aktif: !_pilihAdmin,
                                onTap: () => setState(() {
                                  _pilihAdmin = false;
                                  _errorText = null;
                                }),
                              ),
                            ),
                            Expanded(
                              child: _roleTab(
                                label: 'Admin',
                                icon: Icons.admin_panel_settings_rounded,
                                aktif: _pilihAdmin,
                                onTap: () => setState(() {
                                  _pilihAdmin = true;
                                  _errorText = null;
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),

                      if (!_pilihAdmin) ...[
                        const Text(
                          'Nama Murid',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D264B),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _namaController,
                          decoration: InputDecoration(
                            hintText: 'Contoh: Budi Santoso',
                            prefixIcon: const Icon(Icons.person_rounded),
                            filled: true,
                            fillColor: const Color(0xFFF5F3FF),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ] else ...[
                        const Text(
                          'Username Admin',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D264B),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            hintText: 'admin',
                            prefixIcon: const Icon(Icons.badge_rounded),
                            filled: true,
                            fillColor: const Color(0xFFF5F3FF),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D264B),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: '••••••••',
                            prefixIcon: const Icon(Icons.lock_rounded),
                            filled: true,
                            fillColor: const Color(0xFFF5F3FF),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              _usernameController.text = 'admin';
                              _passwordController.text = 'admin123';
                            },
                            child: const Text(
                              'Isi Otomatis Akun Demo',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF7C5CFA),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],

                      if (_errorText != null) ...[
                        const SizedBox(height: 10),
                        Text(
                          _errorText!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],

                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _prosesLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7C5CFA),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: const Icon(Icons.login_rounded),
                        label: Text(
                          _pilihAdmin
                              ? 'Masuk sebagai Admin'
                              : 'Mulai Belajar Sekarang',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _roleTab({
    required String label,
    required IconData icon,
    required bool aktif,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: aktif ? const Color(0xFF7C5CFA) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: aktif ? Colors.white : Colors.grey.shade600,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: aktif ? Colors.white : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
