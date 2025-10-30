// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart' as actions; // Imports other custom actions

import 'dart:async';
import 'dart:io';

Future checkBackgroundResume() async {
  // Must be called after WidgetsFlutterBinding.ensureInitialized()
  _AppLifecycleBridge.instance.setup(onResume: () async {
    actions.simplePrintAction();
    // ===== YOUR ACTION BLOCK GOES HERE =====
  });
}

class _AppLifecycleBridge with WidgetsBindingObserver {
  _AppLifecycleBridge._internal();
  static final _AppLifecycleBridge instance = _AppLifecycleBridge._internal();

  bool _isSetup = false;
  Future<void> Function()? _onResume;

  // Simple debounce so quick successive "resumed" signals don't double-fire.
  Timer? _debounce;

  void setup({Future<void> Function()? onResume}) {
    if (_isSetup) {
      // Update callback if they call setup again with a new handler.
      _onResume = onResume ?? _onResume;
      return;
    }

    // Only attach on Android as requested.
    if (!Platform.isAndroid) {
      _isSetup = true; // Mark as setup to avoid future work on non-Android too.
      return;
    }

    _onResume = onResume;
    WidgetsBinding.instance.addObserver(this);
    _isSetup = true;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _onResume != null) {
      // Debounce to avoid duplicate triggers in quick succession.
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 250), () {
        final cb = _onResume;
        if (cb != null) {
          // Fire and forget; if you prefer, handle errors here.
          cb();
        }
      });
    }
  }

  void dispose() {
    _debounce?.cancel();
    _debounce = null;
    WidgetsBinding.instance.removeObserver(this);
    _isSetup = false;
  }
}
