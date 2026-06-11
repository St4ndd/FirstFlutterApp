import 'package:flutter/material.dart';

class GameInfo {
  final String title;
  final IconData icon;
  final Color accentColor;

  const GameInfo({
    required this.title,
    required this.icon,
    required this.accentColor,
  });
}

const List<GameInfo> casinoGames = [
  GameInfo(title: 'Blackjack', icon: Icons.style, accentColor: Color(0xFFD4AF37)),
  GameInfo(title: 'Roulette', icon: Icons.donut_large, accentColor: Color(0xFFB3261E)),
  GameInfo(title: 'Mines', icon: Icons.grid_on, accentColor: Color(0xFF1F7A4D)),
  GameInfo(title: 'Chicken Road', icon: Icons.egg_alt, accentColor: Color(0xFFE08A2B)),
  GameInfo(title: 'Plinko', icon: Icons.scatter_plot, accentColor: Color(0xFF4A7AB8)),
  GameInfo(title: 'Slots', icon: Icons.casino, accentColor: Color(0xFF9B59B6)),
];
