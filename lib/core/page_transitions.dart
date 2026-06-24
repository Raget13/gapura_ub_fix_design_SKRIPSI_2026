import 'package:flutter/material.dart';

Route<T> slideRoute<T>(Widget screen, {bool fromLeft = false}) {
  return PageRouteBuilder<T>(
    pageBuilder: (_, anim, _2) => screen,
    transitionDuration: const Duration(milliseconds: 250),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (_, anim, _2, child) {
      final begin = Offset(fromLeft ? -1.0 : 1.0, 0.0);
      final tween = Tween(begin: begin, end: Offset.zero)
          .chain(CurveTween(curve: Curves.easeInOut));
      return SlideTransition(position: anim.drive(tween), child: child);
    },
  );
}
