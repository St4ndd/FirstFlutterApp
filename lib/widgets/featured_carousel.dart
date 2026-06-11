import 'package:flutter/material.dart';
import '../models/game_info.dart';
import '../theme/casino_theme.dart';

class FeaturedCarousel extends StatelessWidget {
  final List<GameInfo> games;
  final ValueChanged<GameInfo> onTapGame;

  const FeaturedCarousel({
    super.key,
    required this.games,
    required this.onTapGame,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: games.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final game = games[index];
          return GestureDetector(
            onTap: () => onTapGame(game),
            child: Container(
              width: 160,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: CasinoColors.surfaceLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: game.accentColor.withValues(alpha: 0.25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(game.icon, color: game.accentColor, size: 28),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        game.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Jetzt spielen',
                        style: TextStyle(
                          color: game.accentColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
