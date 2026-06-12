import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';
import '../../theme/casino_theme.dart';

class HapticsTestScreen extends StatefulWidget {
  const HapticsTestScreen({super.key});

  @override
  State<HapticsTestScreen> createState() => _HapticsTestScreenState();
}

class _HapticsTestScreenState extends State<HapticsTestScreen> {
  String _status = 'Noch keine Aktion ausgeführt.';
  bool? _hasVibrator;
  bool? _hasAmplitudeControl;
  bool? _hasCustomVibrationsSupport;

  @override
  void initState() {
    super.initState();
    _loadCapabilities();
  }

  Future<void> _loadCapabilities() async {
    final hasVibrator = await Vibration.hasVibrator();
    final hasAmplitude = await Vibration.hasAmplitudeControl();
    final hasCustom = await Vibration.hasCustomVibrationsSupport();
    if (!mounted) return;
    setState(() {
      _hasVibrator = hasVibrator;
      _hasAmplitudeControl = hasAmplitude;
      _hasCustomVibrationsSupport = hasCustom;
    });
  }

  Future<void> _run(String label, Future<void> Function() action) async {
    await action();
    setState(() => _status = '"$label" ausgelöst.');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CasinoColors.background,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CasinoColors.background,
        border: null,
        middle: Text('Haptik & Vibration'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _StatusCard(text: _status),
            const SizedBox(height: 20),
            _CapabilitiesCard(
              hasVibrator: _hasVibrator,
              hasAmplitudeControl: _hasAmplitudeControl,
              hasCustomVibrationsSupport: _hasCustomVibrationsSupport,
            ),
            const SizedBox(height: 20),
            const _SectionTitle('Haptic Feedback (HapticFeedback)'),
            _ActionButton(
              label: 'Light Impact',
              onTap: () => _run('Light Impact', HapticFeedback.lightImpact),
            ),
            _ActionButton(
              label: 'Medium Impact',
              onTap: () => _run('Medium Impact', HapticFeedback.mediumImpact),
            ),
            _ActionButton(
              label: 'Heavy Impact',
              onTap: () => _run('Heavy Impact', HapticFeedback.heavyImpact),
            ),
            _ActionButton(
              label: 'Selection Click',
              onTap: () => _run('Selection Click', HapticFeedback.selectionClick),
            ),
            _ActionButton(
              label: 'Vibrate (System)',
              onTap: () => _run('System Vibrate', HapticFeedback.vibrate),
            ),
            const SizedBox(height: 20),
            const _SectionTitle('Erweiterte Vibration (vibration package)'),
            _ActionButton(
              label: 'Kurzer Impuls (200ms)',
              onTap: () => _run('Kurzer Impuls', () => Vibration.vibrate(duration: 200)),
            ),
            _ActionButton(
              label: 'Muster: Erfolg',
              onTap: () => _run(
                'Muster Erfolg',
                () => Vibration.vibrate(pattern: [0, 100, 80, 100]),
              ),
            ),
            _ActionButton(
              label: 'Muster: Fehler',
              onTap: () => _run(
                'Muster Fehler',
                () => Vibration.vibrate(pattern: [0, 300, 100, 300, 100, 300]),
              ),
            ),
            _ActionButton(
              label: 'Stoppen',
              onTap: () => _run('Vibration gestoppt', Vibration.cancel),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final String text;

  const _StatusCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CasinoColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(color: CasinoColors.textPrimary, fontSize: 14),
      ),
    );
  }
}

class _CapabilitiesCard extends StatelessWidget {
  final bool? hasVibrator;
  final bool? hasAmplitudeControl;
  final bool? hasCustomVibrationsSupport;

  const _CapabilitiesCard({
    required this.hasVibrator,
    required this.hasAmplitudeControl,
    required this.hasCustomVibrationsSupport,
  });

  String _format(bool? value) {
    if (value == null) return 'wird geprüft…';
    return value ? 'ja' : 'nein';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CasinoColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Geräte-Fähigkeiten',
            style: TextStyle(
              color: CasinoColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text('Vibrationsmotor: ${_format(hasVibrator)}',
              style: const TextStyle(color: CasinoColors.textSecondary, fontSize: 13)),
          Text('Amplitudensteuerung: ${_format(hasAmplitudeControl)}',
              style: const TextStyle(color: CasinoColors.textSecondary, fontSize: 13)),
          Text('Individuelle Muster: ${_format(hasCustomVibrationsSupport)}',
              style: const TextStyle(color: CasinoColors.textSecondary, fontSize: 13)),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: CasinoColors.textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _ActionButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CupertinoButton(
        color: CasinoColors.surfaceLight,
        borderRadius: BorderRadius.circular(14),
        onPressed: onTap,
        child: Text(
          label,
          style: const TextStyle(color: CasinoColors.textPrimary, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
