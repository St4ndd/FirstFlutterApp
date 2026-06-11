import 'package:flutter/cupertino.dart';
import '../theme/casino_theme.dart';

void showIosToast(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (_) => Positioned(
      bottom: 110,
      left: 40,
      right: 40,
      child: IgnorePointer(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            color: CasinoColors.surfaceLight,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: CasinoColors.textPrimary, fontSize: 14),
          ),
        ),
      ),
    ),
  );

  overlay.insert(entry);
  Future.delayed(const Duration(seconds: 2), () => entry.remove());
}
