import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/team_member.dart';
import '../../painters/hazard_stripe_painter.dart';
import '../../providers/js_constructions_providers.dart';
import '../../theme/js_construction_theme.dart';
import '../../widgets/leadership/field_superintendent_dossier_card.dart';

/// ZONE 05: FIELD COMMAND & MASTER BUILDER GUILD
class JsLeadershipSection extends ConsumerWidget {
  final bool isDesktop;
  final bool isTablet;

  const JsLeadershipSection({
    super.key,
    required this.isDesktop,
    required this.isTablet,
  });

  static IconData _getIconForName(String iconName) {
    switch (iconName) {
      case 'engineering_rounded':
        return Icons.engineering_rounded;
      case 'psychology_rounded':
        return Icons.psychology_rounded;
      case 'local_shipping_rounded':
        return Icons.local_shipping_rounded;
      case 'domain_rounded':
        return Icons.domain_rounded;
      default:
        return Icons.engineering_rounded;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamAsync = ref.watch(teamProvider);

    final leaders = teamAsync.valueOrNull ?? const [
      TeamMember(
        name: 'Marcus Vance, PE, CEng',
        role: 'CHIEF STRUCTURAL ENGINEER',
        cred: 'Ex-Arup Lead • 32 Supertalls Delivered',
        badgeId: 'CORPS-PE-01',
        icon: 'engineering_rounded',
      ),
      TeamMember(
        name: 'Elena Rostova, Ph.D.',
        role: 'HEAD OF ADVANCED METALLURGY',
        cred: 'High-Tensile Alloy & Fatigue Specialist',
        badgeId: 'CORPS-MET-02',
        icon: 'psychology_rounded',
      ),
      TeamMember(
        name: 'Devon Sterling',
        role: 'VP OF GLOBAL PROCUREMENT & LOGISTICS',
        cred: 'Heavy Maritime Heavy-Lift Operations',
        badgeId: 'CORPS-LOG-03',
        icon: 'local_shipping_rounded',
      ),
      TeamMember(
        name: 'Tariq Al-Mansoor',
        role: 'DIRECTOR OF CIVIL MEGAPROJECTS',
        cred: 'Mega-Tunneling & Deep Harbor Infrastructure',
        badgeId: 'CORPS-CIV-04',
        icon: 'domain_rounded',
      ),
    ];

    return Container(
      color: JsConstructionTheme.kObsidian,
      child: Stack(
        children: [
          // 1. Dramatic Engineering Background with Tablet Engineer & Twilight Cranes
          Positioned.fill(
            child: Image.asset(
              'assets/technical_leadership_bg.png',
              fit: BoxFit.cover,
              alignment: Alignment.centerLeft,
            ),
          ),

          // 2. Atmospheric vignette: allow engineer to shine on left, darken center & right for cards
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.35),
                    Colors.black.withValues(alpha: 0.78),
                    Colors.black.withValues(alpha: 0.90),
                  ],
                  stops: const [0.0, 0.26, 0.55, 1.0],
                ),
              ),
            ),
          ),

          // 3. Subtle edge blend into obsidian background for adjacent sections
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    JsConstructionTheme.kObsidian.withValues(alpha: 0.75),
                    Colors.transparent,
                    Colors.transparent,
                    JsConstructionTheme.kObsidian.withValues(alpha: 0.75),
                  ],
                  stops: const [0.0, 0.08, 0.92, 1.0],
                ),
              ),
            ),
          ),

          // 4. Content Area
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 1024;
              final isMedium =
                  constraints.maxWidth >= 640 && constraints.maxWidth < 1024;

              // On desktop, indent the content so the engineer with tablet on the left remains visible
              final double leftPad = isWide
                  ? (constraints.maxWidth * 0.27).clamp(260.0, 420.0)
                  : (isMedium ? 30.0 : 16.0);
              final double rightPad = isWide ? 40.0 : (isMedium ? 30.0 : 16.0);

              return Padding(
                padding: EdgeInsets.fromLTRB(leftPad, 60, rightPad, 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Header: Warning Badge + Extended Hazard Stripe Bar ──
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 3.5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF9F1C),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.black,
                                size: 14,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '04 / TECHNICAL LEADERSHIP & SUPERINTENDENTS',
                                style: GoogleFonts.spaceGrotesk(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 6,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: const CustomPaint(
                                painter: HazardStripePainter(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // ── Eyebrow Tag ──
                    Text(
                      'ZONE 05 / SITE CORPS & COMMAND',
                      style: GoogleFonts.spaceGrotesk(
                        color: const Color(0xFFFF9F1C),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // ── Main Heading ──
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'THE ON-SITE ',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: isWide ? 34 : (isMedium ? 28 : 22),
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: -0.5,
                              height: 1.15,
                            ),
                          ),
                          TextSpan(
                            text: 'MASTER BUILDER GUILD',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: isWide ? 34 : (isMedium ? 28 : 22),
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFFFF9F1C),
                              letterSpacing: -0.5,
                              height: 1.15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // ── 4 Dossier Cards (4 columns on wide screens, 2x2 on medium, 1 column on small) ──
                    if (isWide)
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            for (int i = 0; i < leaders.length; i++) ...[
                              if (i > 0) const SizedBox(width: 14),
                              Expanded(
                                child: FieldSuperintendentDossierCard(
                                  name: leaders[i].name,
                                  role: leaders[i].role,
                                  cred: leaders[i].cred,
                                  badgeId: leaders[i].badgeId,
                                  icon: _getIconForName(leaders[i].icon),
                                ),
                              ),
                            ],
                          ],
                        ),
                      )
                    else if (isMedium && leaders.length >= 4)
                      Column(
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: FieldSuperintendentDossierCard(
                                    name: leaders[0].name,
                                    role: leaders[0].role,
                                    cred: leaders[0].cred,
                                    badgeId: leaders[0].badgeId,
                                    icon: _getIconForName(leaders[0].icon),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: FieldSuperintendentDossierCard(
                                    name: leaders[1].name,
                                    role: leaders[1].role,
                                    cred: leaders[1].cred,
                                    badgeId: leaders[1].badgeId,
                                    icon: _getIconForName(leaders[1].icon),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: FieldSuperintendentDossierCard(
                                    name: leaders[2].name,
                                    role: leaders[2].role,
                                    cred: leaders[2].cred,
                                    badgeId: leaders[2].badgeId,
                                    icon: _getIconForName(leaders[2].icon),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: FieldSuperintendentDossierCard(
                                    name: leaders[3].name,
                                    role: leaders[3].role,
                                    cred: leaders[3].cred,
                                    badgeId: leaders[3].badgeId,
                                    icon: _getIconForName(leaders[3].icon),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          for (int i = 0; i < leaders.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: FieldSuperintendentDossierCard(
                                name: leaders[i].name,
                                role: leaders[i].role,
                                cred: leaders[i].cred,
                                badgeId: leaders[i].badgeId,
                                icon: _getIconForName(leaders[i].icon),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
