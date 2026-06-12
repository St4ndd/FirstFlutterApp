import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import '../../theme/casino_theme.dart';

class ProximitySensorScreen extends StatefulWidget {
  const ProximitySensorScreen({super.key});

  @override
  State<ProximitySensorScreen> createState() => _ProximitySensorScreenState();
}

class _ProximitySensorScreenState extends State<ProximitySensorScreen> {
  StreamSubscription<int>? _subscription;
  bool? _isNear;
  int _eventCount = 0;

  @override
  void initState() {
    super.initState();
    _subscription = ProximitySensor.events.listen((event) {
      setState(() {
        _isNear = event > 0;
        _eventCount++;
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNear = _isNear;
    return CupertinoPageScaffold(
      backgroundColor: CasinoColors.background,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CasinoColors.background,
        border: null,
        middle: Text('Näherungssensor'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Halte deine Hand vor das Display, um den Näherungssensor (Raumsensor) zu testen. '
                'Apple deckt damit z.B. den Bildschirm während eines Telefonats ab.',
                style: TextStyle(color: CasinoColors.textSecondary, fontSize: 13),
              ),
              const SizedBox(height: 30),
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  gradient: isNear == true
                      ? const LinearGradient(
                          colors: [CasinoColors.accentRed, Color(0xFFFF8A65)],
                        )
                      : CasinoColors.balanceGradient,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isNear == true ? CupertinoIcons.hand_raised_fill : CupertinoIcons.tv,
                  color: const Color(0xFFFFFFFF),
                  size: 70,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                isNear == null
                    ? 'Warte auf Sensordaten…'
                    : (isNear ? 'Objekt erkannt (NAH)' : 'Kein Objekt (FERN)'),
                style: const TextStyle(
                  color: CasinoColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Empfangene Events: $_eventCount',
                style: const TextStyle(color: CasinoColors.textSecondary, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
