import 'package:flutter/material.dart';
import '../models/game_info.dart';
import '../theme/casino_theme.dart';
import '../widgets/balance_card.dart';
import '../widgets/featured_carousel.dart';
import '../widgets/game_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showComingSoon(BuildContext context, GameInfo game) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: CasinoColors.surfaceLight,
        content: Text('${game.title} kommt bald!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final featured = casinoGames.take(3).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Casino'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: CasinoColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.notifications_none_rounded,
                  color: CasinoColors.textPrimary, size: 22),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          const BalanceCard(balance: 1000),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Text(
              'Beliebt',
              style: TextStyle(
                color: CasinoColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          FeaturedCarousel(
            games: featured,
            onTapGame: (game) => _showComingSoon(context, game),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
            child: Text(
              'Alle Spiele',
              style: TextStyle(
                color: CasinoColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                onTap: () => _showComingSoon(context, game),
              );
            },
          ),
        ],
      ),
    );
  }
}
