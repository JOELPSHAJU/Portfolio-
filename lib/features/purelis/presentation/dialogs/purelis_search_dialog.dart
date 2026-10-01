import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/purelis_colors.dart';

class PurelisSearchDialog extends StatelessWidget {
  final VoidCallback? onSearch;

  const PurelisSearchDialog({
    super.key,
    this.onSearch,
  });

  static Future<void> show(
    BuildContext context, {
    VoidCallback? onSearch,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => PurelisSearchDialog(onSearch: onSearch),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Row(
        children: [
          const Icon(Icons.search_rounded, color: PurelisColors.topBarGreen),
          const SizedBox(width: 8),
          Text(
            'Search Purelis Skincare',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Search cleansers, serums, sun care...',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          prefixIcon: const Icon(Icons.search_rounded),
        ),
        onSubmitted: (query) {
          Navigator.pop(context);
          onSearch?.call();
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            onSearch?.call();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: PurelisColors.topBarGreen,
          ),
          child: const Text('SEARCH', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
