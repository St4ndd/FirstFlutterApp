import 'package:flutter/cupertino.dart';
import '../theme/casino_theme.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'wallet_screen.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: CasinoColors.surface,
        activeColor: CasinoColors.accentPurple,
        inactiveColor: CasinoColors.textSecondary,
        border: const Border(
          top: BorderSide(color: Color(0xFF2A2C40), width: 0.5),
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            activeIcon: Icon(CupertinoIcons.house_fill),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.creditcard),
            activeIcon: Icon(CupertinoIcons.creditcard_fill),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            activeIcon: Icon(CupertinoIcons.person_fill),
            label: 'Profil',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return const HomeScreen();
          case 1:
            return const WalletScreen();
          default:
            return const ProfileScreen();
        }
      },
    );
  }
}
