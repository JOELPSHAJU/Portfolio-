import 'package:flutter/services.dart';

bool _isFullscreen = false;

void toggleFullscreen() {
  if (_isFullscreen) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _isFullscreen = false;
  } else {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _isFullscreen = true;
  }
}
