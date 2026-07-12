import 'dart:html' as html;

void toggleFullscreen() {
  if (html.document.fullscreenElement == null) {
    html.document.documentElement?.requestFullscreen();
  } else {
    html.document.exitFullscreen();
  }
}
