import 'package:flutter/material.dart';

Route<T> navRoute<T>(Widget screen, {bool fromLeft = false}) {
  return PageRouteBuilder<T>(
    pageBuilder: (_, anim, _2) => screen,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, anim, secondaryAnim, child) {
      return FadeTransition(
        opacity: anim,
        child: child,
      );
    },
  );
}
