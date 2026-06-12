import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import '../../theme/casino_theme.dart';

class CameraTestScreen extends StatefulWidget {
  const CameraTestScreen({super.key});

  @override
  State<CameraTestScreen> createState() => _CameraTestScreenState();
}

class _CameraTestScreenState extends State<CameraTestScreen> {
  CameraController? _controller;
  String? _error;
  String? _lastImagePath;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  Future<void> _setup() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() => _error = 'Keine Kamera gefunden.');
        return;
      }
      final back = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      final controller = CameraController(back, ResolutionPreset.medium, enableAudio: false);
      await controller.initialize();
      if (!mounted) return;
      setState(() => _controller = controller);
    } catch (e) {
      setState(() => _error = 'Kamera-Fehler: $e');
    }
  }

  Future<void> _takePicture() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    try {
      final file = await controller.takePicture();
      setState(() => _lastImagePath = file.path);
    } catch (e) {
      setState(() => _error = 'Foto-Fehler: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CasinoColors.background,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CasinoColors.background,
        border: null,
        middle: Text('Kamera'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(child: _buildPreview()),
              const SizedBox(height: 16),
              if (_lastImagePath != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Letztes Foto gespeichert unter:\n$_lastImagePath',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: CasinoColors.textSecondary, fontSize: 12),
                  ),
                ),
              CupertinoButton(
                color: CasinoColors.accentPurple,
                borderRadius: BorderRadius.circular(14),
                onPressed: _controller?.value.isInitialized == true ? _takePicture : null,
                child: const Text(
                  'Foto aufnehmen',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreview() {
    if (_error != null) {
      return Center(
        child: Text(
          _error!,
          textAlign: TextAlign.center,
          style: const TextStyle(color: CasinoColors.accentRed, fontSize: 14),
        ),
      );
    }
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      return const Center(child: CupertinoActivityIndicator());
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: CameraPreview(controller),
    );
  }
}
