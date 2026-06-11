import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/game_info.dart';
import '../theme/casino_theme.dart';
import '../widgets/game_card.dart';
import '../widgets/ios_toast.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CasinoColors.background,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CasinoColors.background,
        border: null,
        middle: Text('Spiele'),
      ),
      child: SafeArea(
        child: GridView.builder(
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
              onTap: () => showIosToast(context, '${game.title} kommt bald!'),
            );
          },
        ),
      ),
    );
  }
}
