import 'package:flutter/material.dart';
import '../widgets/onboarding_background.dart';
import '../widgets/gapura_logo.dart';
import 'opening_login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _activeDot = 0;
  final int _totalDots = 6;

  void _goToOpeningLogin() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OpeningLoginScreen()));
  }

  void _nextDot() {
    if (_activeDot < _totalDots - 1) {
      setState(() => _activeDot++);
    } else {
      _goToOpeningLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                const Spacer(flex: 3),

                const GapuraLogo(logoSize: 64, fontSize: 34, stacked: true),

                const SizedBox(height: 32),

                const Text(
                  'Satu Aplikasi',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xFF0B2545)),
                ),
                const Text(
                  'Banyak Kemudahan',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xFF0B2545)),
                ),

                const Spacer(flex: 4),

                // Bottom row: Lewati - dots - arrow
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _goToOpeningLogin,
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFD1D5DB),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text('Lewati', style: TextStyle(color: Color(0xFF6B7280), fontWeight: FontWeight.w500)),
                    ),
                    Row(
                      children: List.generate(_totalDots, (i) {
                        final isActive = i == _activeDot;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: isActive ? 22 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isActive ? const Color(0xFFF5A623) : const Color(0xFFD1D5DB),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                    InkWell(
                      onTap: _nextDot,
                      borderRadius: BorderRadius.circular(22),
                      child: Container(
                        width: 44, height: 44,
                        decoration: const BoxDecoration(color: Color(0xFFF5A623), shape: BoxShape.circle),
                        child: const Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
