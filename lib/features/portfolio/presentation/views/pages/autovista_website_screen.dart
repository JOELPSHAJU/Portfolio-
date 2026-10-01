import 'package:flutter/material.dart';
import 'package:joel_portfolio/features/autovista/presentation/pages/autovista_page.dart';

export 'package:joel_portfolio/features/autovista/presentation/pages/autovista_page.dart';

typedef AutoVistaWebsiteScreen = GoDriveWebsiteScreen;

class GoDriveWebsiteScreen extends StatelessWidget {
  const GoDriveWebsiteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutovistaPage();
  }
}
