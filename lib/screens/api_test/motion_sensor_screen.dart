import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../../theme/casino_theme.dart';

class MotionSensorScreen extends StatefulWidget {
  const MotionSensorScreen({super.key});

  @override
  State<MotionSensorScreen> createState() => _MotionSensorScreenState();
}

class _MotionSensorScreenState extends State<MotionSensorScreen> {
  StreamSubscription<AccelerometerEvent>? _accelSub;
  StreamSubscription<UserAccelerometerEvent>? _userAccelSub;
  StreamSubscription<GyroscopeEvent>? _gyroSub;
  StreamSubscription<MagnetometerEvent>? _magnetSub;

  AccelerometerEvent? _accel;
  UserAccelerometerEvent? _userAccel;
  GyroscopeEvent? _gyro;
  MagnetometerEvent? _magnet;

  @override
  void initState() {
    super.initState();
    const interval = SensorInterval.normalInterval;
    _accelSub = accelerometerEventStream(samplingPeriod: interval)
        .listen((event) => setState(() => _accel = event));
    _userAccelSub = userAccelerometerEventStream(samplingPeriod: interval)
        .listen((event) => setState(() => _userAccel = event));
    _gyroSub = gyroscopeEventStream(samplingPeriod: interval)
        .listen((event) => setState(() => _gyro = event));
    _magnetSub = magnetometerEventStream(samplingPeriod: interval)
        .listen((event) => setState(() => _magnet = event));
  }

  @override
  void dispose() {
    _accelSub?.cancel();
    _userAccelSub?.cancel();
    _gyroSub?.cancel();
    _magnetSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CasinoColors.background,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CasinoColors.background,
        border: null,
        middle: Text('Bewegungssensoren'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _SensorCard(
              title: 'Beschleunigungssensor',
              subtitle: 'Inklusive Erdbeschleunigung (m/s²)',
              x: _accel?.x,
              y: _accel?.y,
              z: _accel?.z,
            ),
            const SizedBox(height: 16),
            _SensorCard(
              title: 'Beschleunigung durch Nutzer',
              subtitle: 'Ohne Erdbeschleunigung (m/s²)',
              x: _userAccel?.x,
              y: _userAccel?.y,
              z: _userAccel?.z,
            ),
            const SizedBox(height: 16),
            _SensorCard(
              title: 'Gyroskop',
              subtitle: 'Drehrate (rad/s)',
              x: _gyro?.x,
              y: _gyro?.y,
              z: _gyro?.z,
            ),
            const SizedBox(height: 16),
            _SensorCard(
              title: 'Magnetometer',
              subtitle: 'Magnetfeld (µT)',
              x: _magnet?.x,
              y: _magnet?.y,
              z: _magnet?.z,
            ),
          ],
        ),
      ),
    );
  }
}

class _SensorCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double? x;
  final double? y;
  final double? z;

  const _SensorCard({
    required this.title,
    required this.subtitle,
    required this.x,
    required this.y,
    required this.z,
  });

  String _fmt(double? value) => value == null ? '–' : value.toStringAsFixed(3);

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
          Text(
            title,
            style: const TextStyle(
              color: CasinoColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(color: CasinoColors.textSecondary, fontSize: 12)),
          const SizedBox(height: 12),
          Row(
            children: [
              _AxisValue(label: 'X', value: _fmt(x)),
              _AxisValue(label: 'Y', value: _fmt(y)),
              _AxisValue(label: 'Z', value: _fmt(z)),
            ],
          ),
        ],
      ),
    );
  }
}

class _AxisValue extends StatelessWidget {
  final String label;
  final String value;

  const _AxisValue({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: CasinoColors.surfaceLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(label, style: const TextStyle(color: CasinoColors.textSecondary, fontSize: 12)),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: CasinoColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
