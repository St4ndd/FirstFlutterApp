import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme/casino_theme.dart';
import '../widgets/balance_card.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CasinoColors.background,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CasinoColors.background,
        border: null,
        middle: Text('Wallet'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            const BalanceCard(balance: 1000),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Text(
                'Verlauf',
                style: TextStyle(
                  color: CasinoColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: CasinoColors.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Noch keine Transaktionen',
                    style: TextStyle(color: CasinoColors.textSecondary),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
