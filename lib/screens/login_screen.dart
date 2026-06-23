import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import '../core/app_colors.dart';
import '../widgets/onboarding_background.dart';
import '../widgets/gapura_logo.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _localAuth = LocalAuthentication();

  bool _tetapMasuk = false;
  bool _isLoading = false;
  bool _showError = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty && password.isEmpty) {
      setState(() {
        _showError = true;
        _errorMessage = 'Username/Email dan Kata Sandi tidak boleh kosong.';
      });
      return;
    }
    if (username.isEmpty) {
      setState(() {
        _showError = true;
        _errorMessage = 'Username atau Email tidak boleh kosong.';
      });
      return;
    }
    if (password.isEmpty) {
      setState(() {
        _showError = true;
        _errorMessage = 'Kata Sandi tidak boleh kosong.';
      });
      return;
    }

    setState(() {
      _showError = false;
      _isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
  }

  Future<void> _handleFingerprint() async {
    try {
      final canAuth = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();

      if (!canAuth || !isDeviceSupported) {
        if (!mounted) return;
        setState(() {
          _showError = true;
          _errorMessage = 'Perangkat tidak mendukung autentikasi biometrik.';
        });
        return;
      }

      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Masuk ke Gapura UB dengan sidik jari',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (authenticated && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _showError = true;
        _errorMessage = 'Autentikasi sidik jari gagal. Coba lagi.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button tetap di atas
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A2E), size: 28),
                ),
              ),

              // Konten form di tengah vertikal
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: GapuraLogo(logoSize: 52, fontSize: 28, stacked: false),
                        ),

                        const SizedBox(height: 16),

                        const Center(
                          child: Text(
                            'Sistem Autentikasi Universitas Brawijaya',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Color(0xFF0B2545)),
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Error box
                        if (_showError) ...[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE4E1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE89B8C)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.error_outline, color: Color(0xFFB91C1C), size: 20),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _errorMessage,
                                    style: const TextStyle(color: Color(0xFFB91C1C), fontSize: 13, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],

                        // Username
                        const Text('Username atau Email',
                            style: TextStyle(fontSize: 16, color: Color(0xFF1A1A2E))),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 56,
                          child: TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.mail_outline, color: Color(0xFF6B7280)),
                              filled: true,
                              fillColor: const Color(0xFFF3F5F7),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        // Password
                        const Text('Kata Sandi',
                            style: TextStyle(fontSize: 16, color: Color(0xFF1A1A2E))),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 56,
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.lock_outline, color: Color(0xFF6B7280)),
                              filled: true,
                              fillColor: const Color(0xFFF3F5F7),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Checkbox + lupa password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 28, height: 28,
                                  child: Checkbox(
                                    value: _tetapMasuk,
                                    activeColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    onChanged: (v) => setState(() => _tetapMasuk = v ?? false),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text('Tetap Masuk', style: TextStyle(fontSize: 16, color: Color(0xFF1A1A2E))),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Text('Lupa kata sandi?',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF0B2545),
                                      decoration: TextDecoration.underline)),
                            ),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // Tombol Masuk + Fingerprint
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 60,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _handleLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF003B7A),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    elevation: 0,
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(width: 24, height: 24,
                                          child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
                                      : const Text('Masuk', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Container(
                              width: 60, height: 60,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F5F7),
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: const Color(0xFFD1D5DB)),
                              ),
                              child: IconButton(
                                onPressed: _handleFingerprint,
                                icon: const Icon(Icons.fingerprint, color: Color(0xFF003B7A), size: 30),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 36),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
