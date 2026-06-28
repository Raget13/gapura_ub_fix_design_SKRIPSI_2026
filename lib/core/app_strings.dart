import 'package:flutter/material.dart';

class AppStrings {
  static bool isEnglish(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'en';

  static String get(BuildContext context, String key) {
    final en = isEnglish(context);
    return (en ? _en[key] : _id[key]) ?? key;
  }

  static const _id = {
    'app_name': 'Gapura UB',
    'academic_info': 'Informasi Akademik',
    'student_data': 'Data Mahasiswa',
    'settings_help': 'Pengaturan & Bantuan',
    'help_center': 'Pusat Bantuan',
    'language': 'Bahasa',
    'logout': 'Keluar',
    'logout_confirm': 'Konfirmasi Keluar',
    'logout_message': 'Apakah Anda yakin ingin keluar dari akun?',
    'cancel': 'Batal',
    'last_gpa': 'IPK TERAKHIR',
    'total_sks': 'SKS TOTAL',
    'student_ub': 'Mahasiswa UB',
    'choose_language': 'Pilih Bahasa',
    'indonesian': 'Indonesia',
    'english': 'English',
    'student_name': 'Nama Mahasiswa',
  };

  static const _en = {
    'app_name': 'Gapura UB',
    'academic_info': 'Academic Information',
    'student_data': 'Student Data',
    'settings_help': 'Settings & Support',
    'help_center': 'Help Center',
    'language': 'Language',
    'logout': 'Sign Out',
    'logout_confirm': 'Confirm Sign Out',
    'logout_message': 'Are you sure you want to sign out?',
    'cancel': 'Cancel',
    'last_gpa': 'LATEST GPA',
    'total_sks': 'TOTAL CREDITS',
    'student_ub': 'UB Student',
    'choose_language': 'Choose Language',
    'indonesian': 'Indonesia',
    'english': 'English',
    'student_name': 'Student Name',
  };
}
