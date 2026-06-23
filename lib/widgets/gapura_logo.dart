import 'package:flutter/material.dart';

/// Widget logo Gapura UB — pakai file PNG asli dari assets.
/// Pastikan file logo_gapura_ub.png sudah ditambahkan ke
/// assets/images/ dan didaftarkan di pubspec.yaml.
class GapuraLogo extends StatelessWidget {
  final double logoSize;
  final double fontSize;
  final bool stacked; // true = "Gapura" baris 1, "UB" baris 2 (untuk Opening/Splash)

  const GapuraLogo({
    super.key,
    this.logoSize = 56,
    this.fontSize = 32,
    this.stacked = false,
  });

  @override
  Widget build(BuildContext context) {
    final logo = Image.asset(
      'assets/images/logo_gapura_ub.png',
      width: logoSize,
      height: logoSize,
      errorBuilder: (context, error, stackTrace) {
        // fallback kalau logo belum ditambahkan
        return Container(
          width: logoSize,
          height: logoSize,
          decoration: BoxDecoration(
            color: const Color(0xFF003B7A),
            borderRadius: BorderRadius.circular(logoSize * 0.2),
          ),
          child: Icon(Icons.business, color: const Color(0xFFF5A623), size: logoSize * 0.55),
        );
      },
    );

    final textWidget = stacked
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Gapura',
                  style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w800, color: const Color(0xFFF5A623), height: 1.05)),
              Text('UB',
                  style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w800, color: const Color(0xFF0B2545), height: 1.05)),
            ],
          )
        : RichText(
            text: TextSpan(
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w800),
              children: [
                TextSpan(text: 'Gapura ', style: TextStyle(color: const Color(0xFFF5A623))),
                TextSpan(text: 'UB', style: TextStyle(color: const Color(0xFF0B2545))),
              ],
            ),
          );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        logo,
        const SizedBox(width: 12),
        textWidget,
      ],
    );
  }
}
