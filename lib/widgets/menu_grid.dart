import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../screens/kartu_hasil_studi_screen.dart';
import '../screens/kartu_rencana_studi_screen.dart';
import '../screens/out_of_scope_screen.dart';

class _MenuItemData {
  final IconData icon;
  final String label;
  const _MenuItemData(this.icon, this.label);
}

class MenuGrid extends StatelessWidget {
  const MenuGrid({super.key});

  static const List<_MenuItemData> _items = [
    _MenuItemData(Icons.calendar_month, 'Kalender Akademik'),
    _MenuItemData(Icons.account_balance, 'Layanan Perpustakaan'),
    _MenuItemData(Icons.description, 'Kartu Hasil Studi'),
    _MenuItemData(Icons.badge, 'Kartu Rencana Studi'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final item = _items[index];
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              if (index == 0) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const OutOfScopeScreen(menuName: 'Kalender Akademik')));
              } else if (index == 1) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const OutOfScopeScreen(menuName: 'Layanan Perpustakaan')));
              } else if (index == 2) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const KartuHasilStudiScreen()));
              } else if (index == 3) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const KartuRencanaStudiScreen()));
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.bgGrey,
                borderRadius: BorderRadius.circular(12),
                border: isDark ? Border.all(color: AppColors.darkBorder, width: 0.5) : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1D3461) : const Color(0xFFDDEEFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(item.icon, size: 18,
                        color: isDark ? AppColors.darkAccentBlue : AppColors.primary),
                  ),
                  const SizedBox(height: 5),
                  Text(item.label,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 9, fontWeight: FontWeight.w500,
                          color: isDark ? AppColors.darkTextSecondary : const Color(0xFF4B5563))),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
