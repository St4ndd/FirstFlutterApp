import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../theme/casino_theme.dart';

class NotificationTestScreen extends StatefulWidget {
  const NotificationTestScreen({super.key});

  @override
  State<NotificationTestScreen> createState() => _NotificationTestScreenState();
}

class _NotificationTestScreenState extends State<NotificationTestScreen> {
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  String _status = 'Bereit.';
  bool _initialized = false;
  bool _permissionGranted = false;
  int _notificationId = 0;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    const settings = InitializationSettings(
      iOS: DarwinInitializationSettings(),
      macOS: DarwinInitializationSettings(),
    );
    await _notifications.initialize(settings);
    setState(() => _initialized = true);
  }

  Future<void> _requestPermission() async {
    final iosPlugin = _notifications
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    final granted = await iosPlugin?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        ) ??
        false;
    setState(() {
      _permissionGranted = granted;
      _status = granted ? 'Berechtigung erteilt.' : 'Berechtigung verweigert.';
    });
  }

  Future<void> _showNow() async {
    _notificationId++;
    await _notifications.show(
      _notificationId,
      'Apple API Test',
      'Sofortige Mitteilung #$_notificationId',
      const NotificationDetails(
        iOS: DarwinNotificationDetails(presentAlert: true, presentSound: true, presentBadge: true),
      ),
    );
    setState(() => _status = 'Sofortige Mitteilung gesendet (#$_notificationId).');
  }

  Future<void> _showDelayed() async {
    _notificationId++;
    final id = _notificationId;
    setState(() => _status = 'Mitteilung #$id wird in 5 Sekunden angezeigt…');
    Future.delayed(const Duration(seconds: 5), () async {
      await _notifications.show(
        id,
        'Apple API Test',
        'Verzögerte Mitteilung #$id (5s)',
        const NotificationDetails(
          iOS: DarwinNotificationDetails(presentAlert: true, presentSound: true, presentBadge: true),
        ),
      );
      if (mounted) setState(() => _status = 'Verzögerte Mitteilung #$id wurde angezeigt.');
    });
  }

  Future<void> _cancelAll() async {
    await _notifications.cancelAll();
    setState(() => _status = 'Alle Mitteilungen abgebrochen.');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CasinoColors.background,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CasinoColors.background,
        border: null,
        middle: Text('Mitteilungen'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CasinoColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                _status,
                style: const TextStyle(color: CasinoColors.textPrimary, fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              color: CasinoColors.surfaceLight,
              borderRadius: BorderRadius.circular(14),
              onPressed: _initialized ? _requestPermission : null,
              child: Text(
                _permissionGranted ? 'Berechtigung erneut anfragen' : 'Berechtigung anfragen',
                style: const TextStyle(color: CasinoColors.textPrimary, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 10),
            CupertinoButton(
              color: CasinoColors.accentPurple,
              borderRadius: BorderRadius.circular(14),
              onPressed: _initialized ? _showNow : null,
              child: const Text(
                'Sofortige Mitteilung senden',
                style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 10),
            CupertinoButton(
              color: CasinoColors.surfaceLight,
              borderRadius: BorderRadius.circular(14),
              onPressed: _initialized ? _showDelayed : null,
              child: const Text(
                'Mitteilung in 5 Sekunden',
                style: TextStyle(color: CasinoColors.textPrimary, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 10),
            CupertinoButton(
              color: CasinoColors.surfaceLight,
              borderRadius: BorderRadius.circular(14),
              onPressed: _initialized ? _cancelAll : null,
              child: const Text(
                'Alle Mitteilungen abbrechen',
                style: TextStyle(color: CasinoColors.textPrimary, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
