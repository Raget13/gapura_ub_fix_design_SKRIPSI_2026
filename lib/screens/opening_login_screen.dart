import 'package:flutter/material.dart';
import '../widgets/onboarding_background.dart';
import '../widgets/gapura_logo.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class OpeningLoginScreen extends StatelessWidget {
  const OpeningLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                const Spacer(flex: 2),

                const GapuraLogo(logoSize: 64, fontSize: 36, stacked: false),

                const SizedBox(height: 28),

                const Text(
                  'Satu Aplikasi',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: Color(0xFF003B7A)),
                ),
                const Text(
                  'Banyak Kemudahan',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: Color(0xFF003B7A)),
                ),

                const Spacer(flex: 2),

                // Logo "62 tahun" — ganti dengan Image.asset jika sudah ada filenya
                Image.asset(
                  'lib/assets/images/logo_62_tahun.png',
                  width: 270,
                  errorBuilder: (context, error, stackTrace) => const SizedBox(height: 100),
                ),

                const Spacer(flex: 3),

                // Tombol Masuk sebagai Pengunjung
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003B7A),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'MASUK SEBAGAI PENGUNJUNG',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, letterSpacing: 0.5),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Tombol Masuk dengan Akun UB
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5A623),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'MASUK DENGAN AKUN UB',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, letterSpacing: 0.5),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
