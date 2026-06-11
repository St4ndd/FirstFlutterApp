import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme/casino_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CasinoColors.background,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CasinoColors.background,
        border: null,
        middle: Text('Profil'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: CasinoColors.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: CasinoColors.balanceGradient,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(CupertinoIcons.person_fill, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Spieler',
                        style: TextStyle(
                          color: CasinoColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Level 1',
                        style: TextStyle(color: CasinoColors.textSecondary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const _ProfileTile(icon: CupertinoIcons.rosette, label: 'Achievements'),
            const _ProfileTile(icon: CupertinoIcons.chart_bar, label: 'Statistik'),
            const _ProfileTile(icon: CupertinoIcons.settings, label: 'Einstellungen'),
          ],
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ProfileTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: CasinoColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: CasinoColors.textPrimary, size: 22),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(
              color: CasinoColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          const Icon(CupertinoIcons.chevron_right, color: CasinoColors.textSecondary, size: 18),
        ],
      ),
    );
  }
}
