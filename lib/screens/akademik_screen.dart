import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/bottom_nav.dart';

class AkademikScreen extends StatelessWidget {
  const AkademikScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akademik'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_book_rounded,
              size: 72,
              color: AppColors.primary.withValues(alpha: 0.25),
            ),
            const SizedBox(height: 16),
            const Text(
              'Halaman Akademik',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              'Segera hadir',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 1,
        onTap: (i) {
          if (i == 0) Navigator.popUntil(context, (route) => route.isFirst);
        },
      ),
    );
  }
}
