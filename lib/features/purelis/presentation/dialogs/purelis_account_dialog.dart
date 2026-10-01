import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/purelis_colors.dart';

class PurelisAccountDialog extends StatelessWidget {
  final VoidCallback? onSignIn;

  const PurelisAccountDialog({
    super.key,
    this.onSignIn,
  });

  static Future<void> show(
    BuildContext context, {
    VoidCallback? onSignIn,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => PurelisAccountDialog(
        onSignIn: onSignIn ??
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: PurelisColors.topBarGreen,
                  content: Text(
                    'Welcome back to Purelis Club!',
                    style: GoogleFonts.outfit(color: Colors.white),
                  ),
                ),
              );
            },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(
        'Purelis Skincare Club',
        style: GoogleFonts.cormorantGaramond(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: PurelisColors.textPrimary,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sign in to access your wishlist, redeem glow points, and track shipments.',
            style: GoogleFonts.outfit(
              fontSize: 13,
              color: PurelisColors.textMuted,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Email Address',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              isDense: true,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              isDense: true,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            onSignIn?.call();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: PurelisColors.topBarGreen,
          ),
          child: const Text('SIGN IN', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
