import 'package:flutter/material.dart';
import '../../../../purelis/presentation/pages/purelis_website_page.dart';

export '../../../../purelis/presentation/pages/purelis_website_page.dart';

/// Compatibility wrapper for [PurelisWebsitePage].
///
/// Preserves backward compatibility with existing navigation calls
/// while delegating fully to the Clean Architecture + Riverpod implementation.
class PurelisWebsiteScreen extends StatelessWidget {
  const PurelisWebsiteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PurelisWebsitePage();
  }
}
