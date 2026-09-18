import 'package:flutter/material.dart';

/// Reusable Image widget with built-in shimmer placeholder and smooth fade transition.
class AppImage extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final Color? color;
  final BlendMode? colorBlendMode;
  final FilterQuality filterQuality;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final bool showShimmerIcon;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  const AppImage({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.low,
    this.borderRadius,
    this.placeholder,
    this.showShimmerIcon = true,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidget = Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      color: color,
      colorBlendMode: colorBlendMode,
      filterQuality: filterQuality,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: frame != null
              ? child
              : (placeholder ??
                    Center(child: Center(child: CircularProgressIndicator()))),
        );
      },
      errorBuilder:
          errorBuilder ??
          (context, error, stackTrace) {
            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: borderRadius,
              ),
              child: const Center(
                child: Icon(Icons.broken_image_rounded, color: Colors.grey),
              ),
            );
          },
    );

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: imageWidget);
    }

    return imageWidget;
  }
}
