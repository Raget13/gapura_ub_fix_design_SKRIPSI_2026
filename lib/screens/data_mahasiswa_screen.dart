import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class DataMahasiswaScreen {
  static void showOverlay(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => const _DataMahasiswaDialog(),
    );
  }
}

class _DataMahasiswaDialog extends StatelessWidget {
  const _DataMahasiswaDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // back button row
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.arrow_back, size: 20, color: Colors.black87),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // header card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mahasiswa Universitas Brawijaya',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accent,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '225150201111052',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'mahasiswa.ube@student.ub.ac.id',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFFBFDBFE),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // info grid — semua card ukuran sama lewat IntrinsicHeight
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _infoCard('Nama', 'Mochamad Bintang Tegar')),
                  const SizedBox(width: 12),
                  Expanded(child: _infoCard('Angkatan', '2022', valueColor: AppColors.primary)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _infoCard('Status Akademik', 'Aktif', valueColor: AppColors.success)),
                  const SizedBox(width: 12),
                  Expanded(child: _infoCard('Fakultas', 'Ilmu Komputer')),
                ],
              ),
            ),
            const SizedBox(height: 12),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _infoCard('Jurusan', 'Teknik Informatika')),
                  const SizedBox(width: 12),
                  Expanded(child: _infoCard('Jenjang & Prodi', 'S1 - Teknik Informatika')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _infoCard(String label, String value, {Color? valueColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFDEECFB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFBAD6F5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: valueColor ?? AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
