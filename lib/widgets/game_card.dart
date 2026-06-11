import 'package:flutter/material.dart';
import '../models/game_info.dart';
import '../theme/casino_theme.dart';

class GameCard extends StatelessWidget {
  final GameInfo game;
  final VoidCallback onTap;

  const GameCard({super.key, required this.game, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: game.accentColor.withValues(alpha: 0.2),
                child: Icon(game.icon, color: game.accentColor, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                game.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
