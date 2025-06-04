import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';

class AppInitializer {
  static initialize() async {
    _ensureInitialized();
    await _setupWindowDimensions();
    await _setupDeviceOrientation();
  }

  static _ensureInitialized() {
    WidgetsFlutterBinding.ensureInitialized();
  }

  static _setupWindowDimensions() async {
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) return;
    await windowManager.ensureInitialized();
    windowManager.setMinimumSize(const Size(425, 600));
  }

  static _setupDeviceOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
    );
  }
}
