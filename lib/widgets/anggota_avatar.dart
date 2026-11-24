import 'package:flutter/material.dart';

class AnggotaAvatar extends StatelessWidget {
  final String path;
  final String nama;
  final double ukuran;

  const AnggotaAvatar({
    super.key,
    required this.path,
    required this.nama,
    required this.ukuran,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        path,
        width: ukuran,
        height: ukuran,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: ukuran,
          height: ukuran,
          color: const Color(0xFFEDE9FE),
          alignment: Alignment.center,
          child: Text(
            nama.isNotEmpty ? nama[0] : '?',
            style: TextStyle(
              fontSize: ukuran / 2.2,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF7C5CFA),
            ),
          ),
        ),
      ),
    );
  }
}
