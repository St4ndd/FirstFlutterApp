import 'package:flutter/cupertino.dart';
import '../../theme/casino_theme.dart';

class UiShowcaseScreen extends StatefulWidget {
  const UiShowcaseScreen({super.key});

  @override
  State<UiShowcaseScreen> createState() => _UiShowcaseScreenState();
}

class _UiShowcaseScreenState extends State<UiShowcaseScreen> {
  bool _switchValue = true;
  double _sliderValue = 0.5;
  int _segment = 0;
  String _lastAction = 'Noch keine Aktion ausgeführt.';

  void _setAction(String action) => setState(() => _lastAction = action);

  Future<void> _showActionSheet() async {
    final result = await showCupertinoModalPopup<String>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Aktion wählen'),
        message: const Text('Apple Action Sheet Test'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context, 'Option 1'),
            child: const Text('Option 1'),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context, 'Option 2'),
            child: const Text('Option 2'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context, 'Löschen'),
            child: const Text('Löschen'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('Abbrechen'),
        ),
      ),
    );
    if (result != null) _setAction('Action Sheet: $result');
  }

  Future<void> _showAlertDialog() async {
    final result = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Apple Dialog'),
        content: const Text('Dies ist ein nativer iOS-Bestätigungsdialog.'),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Abbrechen'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context, true),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    if (result != null) _setAction('Dialog: ${result ? 'OK' : 'Abbrechen'}');
  }

  Future<void> _showDatePicker() async {
    DateTime selected = DateTime.now();
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => Container(
        height: 280,
        color: CasinoColors.surface,
        child: Column(
          children: [
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: selected,
                onDateTimeChanged: (value) => selected = value,
              ),
            ),
            CupertinoButton(
              child: const Text('Fertig'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
    _setAction('Datum gewählt: ${selected.toString().split('.').first}');
  }

  Future<void> _showPicker() async {
    const options = ['Gold', 'Silber', 'Bronze', 'Platin'];
    int selectedIndex = 0;
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => Container(
        height: 280,
        color: CasinoColors.surface,
        child: Column(
          children: [
            Expanded(
              child: CupertinoPicker(
                itemExtent: 36,
                onSelectedItemChanged: (index) => selectedIndex = index,
                children: options.map((o) => Center(child: Text(o))).toList(),
              ),
            ),
            CupertinoButton(
              child: const Text('Fertig'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
    _setAction('Picker gewählt: ${options[selectedIndex]}');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CasinoColors.background,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CasinoColors.background,
        border: null,
        middle: Text('Apple UI Komponenten'),
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
                _lastAction,
                style: const TextStyle(color: CasinoColors.textPrimary, fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
            _Section(
              title: 'CupertinoSwitch',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Benachrichtigungen', style: TextStyle(color: CasinoColors.textPrimary)),
                  CupertinoSwitch(
                    value: _switchValue,
                    onChanged: (value) {
                      setState(() => _switchValue = value);
                      _setAction('Switch: ${value ? 'an' : 'aus'}');
                    },
                  ),
                ],
              ),
            ),
            _Section(
              title: 'CupertinoSlider',
              child: CupertinoSlider(
                value: _sliderValue,
                onChanged: (value) {
                  setState(() => _sliderValue = value);
                  _setAction('Slider: ${(value * 100).round()}%');
                },
              ),
            ),
            _Section(
              title: 'CupertinoSlidingSegmentedControl',
              child: CupertinoSlidingSegmentedControl<int>(
                groupValue: _segment,
                children: const {
                  0: Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('Tag')),
                  1: Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('Woche')),
                  2: Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('Monat')),
                },
                onValueChanged: (value) {
                  if (value == null) return;
                  setState(() => _segment = value);
                  _setAction('Segment gewählt: $value');
                },
              ),
            ),
            _Section(
              title: 'CupertinoActionSheet',
              child: CupertinoButton(
                color: CasinoColors.surfaceLight,
                borderRadius: BorderRadius.circular(14),
                onPressed: _showActionSheet,
                child: const Text('Action Sheet öffnen',
                    style: TextStyle(color: CasinoColors.textPrimary, fontWeight: FontWeight.w600)),
              ),
            ),
            _Section(
              title: 'CupertinoAlertDialog',
              child: CupertinoButton(
                color: CasinoColors.surfaceLight,
                borderRadius: BorderRadius.circular(14),
                onPressed: _showAlertDialog,
                child: const Text('Dialog öffnen',
                    style: TextStyle(color: CasinoColors.textPrimary, fontWeight: FontWeight.w600)),
              ),
            ),
            _Section(
              title: 'CupertinoDatePicker',
              child: CupertinoButton(
                color: CasinoColors.surfaceLight,
                borderRadius: BorderRadius.circular(14),
                onPressed: _showDatePicker,
                child: const Text('Datum & Uhrzeit wählen',
                    style: TextStyle(color: CasinoColors.textPrimary, fontWeight: FontWeight.w600)),
              ),
            ),
            _Section(
              title: 'CupertinoPicker',
              child: CupertinoButton(
                color: CasinoColors.surfaceLight,
                borderRadius: BorderRadius.circular(14),
                onPressed: _showPicker,
                child: const Text('Auswahl-Picker öffnen',
                    style: TextStyle(color: CasinoColors.textPrimary, fontWeight: FontWeight.w600)),
              ),
            ),
            _Section(
              title: 'CupertinoContextMenu',
              child: CupertinoContextMenu(
                actions: [
                  CupertinoContextMenuAction(
                    onPressed: () {
                      Navigator.pop(context);
                      _setAction('Kontextmenü: Favorit');
                    },
                    trailingIcon: CupertinoIcons.star,
                    child: const Text('Favorit'),
                  ),
                  CupertinoContextMenuAction(
                    onPressed: () {
                      Navigator.pop(context);
                      _setAction('Kontextmenü: Teilen');
                    },
                    trailingIcon: CupertinoIcons.share,
                    child: const Text('Teilen'),
                  ),
                ],
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: CasinoColors.balanceGradient,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Lange drücken',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            _Section(
              title: 'CupertinoActivityIndicator',
              child: const Center(child: CupertinoActivityIndicator(radius: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
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
              color: CasinoColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
