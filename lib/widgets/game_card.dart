import 'package:flutter/material.dart';
import '../models/game_info.dart';
import '../theme/casino_theme.dart';

class GameCard extends StatelessWidget {
  final GameInfo game;
  final VoidCallback onTap;

  const GameCard({super.key, required this.game, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CasinoColors.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: game.accentColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(game.icon, color: game.accentColor, size: 22),
              ),
              const SizedBox(height: 16),
              Text(
                game.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 2),
              Text(
                game.subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
