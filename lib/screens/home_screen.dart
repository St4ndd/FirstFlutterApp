import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/game_info.dart';
import '../theme/casino_theme.dart';
import '../widgets/balance_card.dart';
import '../widgets/featured_carousel.dart';
import '../widgets/game_card.dart';
import '../widgets/ios_toast.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final featured = casinoGames.take(3).toList();

    return CupertinoPageScaffold(
      backgroundColor: CasinoColors.background,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CasinoColors.background,
        border: null,
        middle: const Text('Casino'),
        trailing: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: CasinoColors.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(CupertinoIcons.bell, color: CasinoColors.textPrimary, size: 18),
        ),
      ),
      child: SafeArea(
        child: ListView(
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
              onTapGame: (game) => showIosToast(context, '${game.title} kommt bald!'),
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
                  onTap: () => showIosToast(context, '${game.title} kommt bald!'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
