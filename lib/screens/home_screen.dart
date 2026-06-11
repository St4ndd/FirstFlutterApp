import 'package:flutter/material.dart';
import '../models/game_info.dart';
import '../widgets/balance_card.dart';
import '../widgets/game_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Casino'),
      ),
      body: Column(
        children: [
          const BalanceCard(balance: 1000),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: casinoGames.length,
              itemBuilder: (context, index) {
                final game = casinoGames[index];
                return GameCard(
                  game: game,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${game.title} kommt bald!')),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
