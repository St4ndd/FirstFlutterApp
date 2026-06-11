import 'package:flutter/material.dart';
import '../models/game_info.dart';
import '../theme/casino_theme.dart';
import '../widgets/game_card.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spiele')),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.05,
        ),
        itemCount: casinoGames.length,
        itemBuilder: (context, index) {
          final game = casinoGames[index];
          return GameCard(
            game: game,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: CasinoColors.surfaceLight,
                  content: Text('${game.title} kommt bald!'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
