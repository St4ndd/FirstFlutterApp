import 'package:flutter/material.dart';

class GameInfo {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;

  const GameInfo({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
  });
}

const List<GameInfo> casinoGames = [
  GameInfo(
    title: 'Blackjack',
    subtitle: 'Kartenspiel',
    icon: Icons.style_outlined,
    accentColor: Color(0xFFFFC857),
  ),
  GameInfo(
    title: 'Roulette',
    subtitle: 'Klassiker',
    icon: Icons.donut_large_outlined,
    accentColor: Color(0xFFFF5A5F),
  ),
  GameInfo(
    title: 'Mines',
    subtitle: 'Risikospiel',
    icon: Icons.grid_view_rounded,
    accentColor: Color(0xFF4ADE80),
  ),
  GameInfo(
    title: 'Chicken Road',
    subtitle: 'Crash Game',
    icon: Icons.egg_outlined,
    accentColor: Color(0xFFFF9F5A),
  ),
  GameInfo(
    title: 'Plinko',
    subtitle: 'Glücksspiel',
    icon: Icons.scatter_plot_outlined,
    accentColor: Color(0xFF5AB4FF),
  ),
  GameInfo(
    title: 'Slots',
    subtitle: 'Spielautomat',
    icon: Icons.casino_outlined,
    accentColor: Color(0xFF8C6BFF),
  ),
];
