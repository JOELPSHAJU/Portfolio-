import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/brand_colors.dart';

/// A premium, customizable glassmorphic container widget.
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final BoxBorder? customBorder;
  final Gradient? customGradient;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 15.0,
    this.borderRadius = 24.0,
    this.padding = const EdgeInsets.all(20.0),
    this.margin,
    this.width,
    this.height,
    this.alignment,
    this.customBorder,
    this.customGradient,
  });

  @override
  Widget build(BuildContext context) {
    final pal = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          margin: margin,
          padding: padding,
          alignment: alignment,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: customGradient ?? pal.glassGradient,
            border:
                customBorder ??
                Border.all(
                  color: isDark
                      ? BrandColors.primaryNeon.withOpacity(0.10)
                      : BrandColors.primaryNeon.withOpacity(0.12),
                  width: 1.5,
                ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.25)
                    : BrandColors.primaryNeon.withOpacity(0.06),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
