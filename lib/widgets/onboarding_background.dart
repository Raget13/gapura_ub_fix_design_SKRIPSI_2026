import 'package:flutter/material.dart';

/// Background shape organik untuk layar onboarding (Splash, Opening, Login).
/// Mereplikasi lengkungan biru-abu yang menumpuk di atas krem,
/// sesuai desain Figma asli.
class OnboardingBackground extends StatelessWidget {
  final Widget child;
  const OnboardingBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Layer dasar krem
        Positioned.fill(
          child: Container(color: const Color(0xFFFAF0DC)),
        ),
        // Shape organik biru-abu di belakang
        Positioned.fill(
          child: CustomPaint(
            painter: _BlobPainter(),
          ),
        ),
        // Konten di atas — WAJIB dibungkus Positioned.fill agar
        // mendapat constraint ukuran penuh dari parent Stack.
        Positioned.fill(
          child: child,
        ),
      ],
    );
  }
}

class _BlobPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE5EAF0)
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // Oval besar di kanan-atas (sebagian terpotong di luar frame)
    final ovalTop = Rect.fromCenter(
      center: Offset(w * 0.95, h * 0.18),
      width: w * 1.3,
      height: h * 0.55,
    );
    canvas.drawOval(ovalTop, paint);

    // Oval besar di kiri-bawah (sebagian terpotong di luar frame)
    final ovalBottom = Rect.fromCenter(
      center: Offset(w * 0.05, h * 0.85),
      width: w * 1.3,
      height: h * 0.55,
    );
    canvas.drawOval(ovalBottom, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
