import 'package:flutter/material.dart';

/// Design System warna GAPURA UB
/// Berdasarkan teori warna Brewster (warna panas vs dingin) dan
/// semantik warna W3C untuk indikator status.
class AppColors {
  // ===== PRIMARY (warna dingin — kredibilitas & formalitas) =====
  static const Color primary = Color(0xFF003B7A);
  static const Color primaryLight = Color(0xFF1565C0);

  // ===== ACCENT (warna panas — call-to-action) =====
  static const Color accent = Color(0xFFF5A623);
  static const Color accentLight = Color(0xFFFFD280);

  // ===== NEUTRAL (light mode) =====
  static const Color bgWhite = Color(0xFFFFFFFF);
  static const Color bgCard = Color(0xFFF8FAFF);
  static const Color bgGrey = Color(0xFFF3F4F6);
  static const Color border = Color(0xFFDBEAFE);
  static const Color borderGrey = Color(0xFFE5E7EB);

  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF9CA3AF);

  // ===== SEMANTIC (status presensi & feedback) =====
  static const Color success = Color(0xFF16A34A);
  static const Color successBg = Color(0xFFDCFCE7);
  static const Color warning = Color(0xFFD97706);
  static const Color warningBg = Color(0xFFFEF9C3);
  static const Color error = Color(0xFFDC2626);
  static const Color errorBg = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF2563EB);
  static const Color infoBg = Color(0xFFDBEAFE);

  // ===== DARK MODE =====
  static const Color darkBg = Color(0xFF0F172A);
  static const Color darkCard = Color(0xFF1E293B);
  static const Color darkElevated = Color(0xFF273449);
  static const Color darkBorder = Color(0xFF334155);
  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextMuted = Color(0xFF475569);
  static const Color darkAccentBlue = Color(0xFF3B82F6);
  static const Color darkPrimary = Color(0xFF1D4ED8);
}
