import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors;
import '../../theme/casino_theme.dart';
import 'camera_test_screen.dart';
import 'haptics_test_screen.dart';
import 'motion_sensor_screen.dart';
import 'notification_test_screen.dart';
import 'proximity_sensor_screen.dart';
import 'ui_showcase_screen.dart';

class ApiTestHubScreen extends StatelessWidget {
  const ApiTestHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CasinoColors.background,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CasinoColors.background,
        border: null,
        middle: Text('API Test'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Apple API Spielwiese',
              style: TextStyle(
                color: CasinoColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Hier kannst du alle wichtigen Apple/iOS Geräte-Funktionen einzeln testen.',
              style: TextStyle(color: CasinoColors.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 20),
            _ApiTestTile(
              icon: CupertinoIcons.square_grid_2x2,
              title: 'Apple UI Komponenten',
              subtitle: 'Action Sheets, Dialoge, Picker, Switches & mehr',
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute(builder: (_) => const UiShowcaseScreen()),
              ),
            ),
            _ApiTestTile(
              icon: CupertinoIcons.waveform_path,
              title: 'Haptik & Vibration',
              subtitle: 'Impact-, Selection- und Notification-Feedback testen',
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute(builder: (_) => const HapticsTestScreen()),
              ),
            ),
            _ApiTestTile(
              icon: CupertinoIcons.bell_fill,
              title: 'Mitteilungen',
              subtitle: 'Lokale Push-Benachrichtigungen senden',
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute(builder: (_) => const NotificationTestScreen()),
              ),
            ),
            _ApiTestTile(
              icon: CupertinoIcons.gauge,
              title: 'Bewegungssensoren',
              subtitle: 'Beschleunigung, Gyroskop & Magnetfeld live',
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute(builder: (_) => const MotionSensorScreen()),
              ),
            ),
            _ApiTestTile(
              icon: CupertinoIcons.tv,
              title: 'Näherungssensor (Raumsensor)',
              subtitle: 'Erkennt, ob das Display abgedeckt ist',
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute(builder: (_) => const ProximitySensorScreen()),
              ),
            ),
            _ApiTestTile(
              icon: CupertinoIcons.camera_fill,
              title: 'Kamera',
              subtitle: 'Live-Vorschau & Foto aufnehmen',
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute(builder: (_) => const CameraTestScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ApiTestTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ApiTestTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: CasinoColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: CasinoColors.balanceGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: CasinoColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(color: CasinoColors.textSecondary, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(CupertinoIcons.chevron_right, color: CasinoColors.textSecondary, size: 18),
          ],
        ),
      ),
    );
  }
}
