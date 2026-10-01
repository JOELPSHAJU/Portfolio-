class HeroOpacityCalculator {
  HeroOpacityCalculator._();

  static double calculate(double progress, double start, double end) {
    if (progress < start || progress > end) return 0.0;
    final span = end - start;
    final mid = start + span / 2;

    if (start == 0.0) {
      if (progress <= 0.18) return 1.0;
      return (1.0 - ((progress - 0.18) / 0.10)).clamp(0.0, 1.0);
    }
    if (end == 1.0) {
      return ((progress - start) / (span * 0.4)).clamp(0.0, 1.0);
    }
    if (progress <= mid) {
      return ((progress - start) / (span * 0.3)).clamp(0.0, 1.0);
    } else {
      return (1.0 - ((progress - mid) / (span * 0.5))).clamp(0.0, 1.0);
    }
  }
}
