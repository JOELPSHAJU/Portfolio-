import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/widgets/app_image.dart';
import '../../../domain/entities/construction_project.dart';
import '../../theme/js_construction_theme.dart';

class ProjectModals {
  static void openProjectModal(BuildContext context, ConstructionProject proj) {
    showDialog(
      context: context,
      builder: (ctx) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Dialog(
            backgroundColor: JsConstructionTheme.kSiteCharcoal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(
                color: JsConstructionTheme.kSafetyAmber,
                width: 1.5,
              ),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 740, maxHeight: 720),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: JsConstructionTheme.kSafetyAmber.withValues(
                              alpha: 0.15,
                            ),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: JsConstructionTheme.kSafetyAmber,
                            ),
                          ),
                          child: Text(
                            proj.badge,
                            style: GoogleFonts.spaceGrotesk(
                              color: JsConstructionTheme.kSafetyAmber,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          proj.drawingCode.isNotEmpty
                              ? proj.drawingCode
                              : 'DWG-SPEC-ACTIVE',
                          style: GoogleFonts.spaceGrotesk(
                            color: JsConstructionTheme.kBlueprintCyan,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.close_rounded,
                            color: JsConstructionTheme.kSteelMuted,
                          ),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      proj.title,
                      style: GoogleFonts.plusJakartaSans(
                        color: JsConstructionTheme.kSteel,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${proj.location} • ${proj.height}',
                      style: GoogleFonts.spaceGrotesk(
                        color: JsConstructionTheme.kSafetyAmber,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        height: 260,
                        width: double.infinity,
                        child: AppImage(
                          assetPath: proj.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      proj.desc,
                      style: GoogleFonts.plusJakartaSans(
                        color: JsConstructionTheme.kSteel,
                        fontSize: 14,
                        height: 1.6,
                        letterSpacing: -0.1,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: JsConstructionTheme.kObsidian,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: JsConstructionTheme.kSiteBorder,
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildModalSpecRow(
                            'STRUCTURAL SPECIFICATION',
                            proj.spec,
                          ),
                          const SizedBox(height: 8),
                          _buildModalSpecRow(
                            'TOTAL CONTRACT VALUE',
                            proj.budget,
                          ),
                          const SizedBox(height: 8),
                          _buildModalSpecRow(
                            'CURRENT SITE STATUS',
                            proj.status,
                          ),
                          const SizedBox(height: 8),
                          _buildModalSpecRow(
                            'ARCHITECTURAL ATELIER',
                            proj.architect,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: Text(
                            'CLOSE DOSSIER',
                            style: GoogleFonts.spaceGrotesk(
                              color: JsConstructionTheme.kSteelMuted,
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            openTenderDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: JsConstructionTheme.kSafetyAmber,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Text(
                            'INQUIRE SIMILAR BUILD',
                            style: GoogleFonts.spaceGrotesk(
                              fontWeight: FontWeight.w800,
                              fontSize: 11,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _buildModalSpecRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            color: JsConstructionTheme.kSafetyAmber,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.plusJakartaSans(
              color: JsConstructionTheme.kSteel,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.1,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  static void openTenderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: AlertDialog(
            backgroundColor: JsConstructionTheme.kSiteCharcoal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(
                color: JsConstructionTheme.kSafetyAmber,
                width: 1.5,
              ),
            ),
            title: Row(
              children: [
                const Icon(
                  Icons.assignment_rounded,
                  color: JsConstructionTheme.kSafetyAmber,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    'SUBMIT PROJECT TENDER (RFP)',
                    style: GoogleFonts.spaceGrotesk(
                      color: JsConstructionTheme.kSteel,
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
              ],
            ),
            content: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tier-1 Global EPC Construction Services:',
                    style: GoogleFonts.spaceGrotesk(
                      color: JsConstructionTheme.kSafetyAmber,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildTenderBullet(
                    'Complete Architectural & Structural Engineering',
                  ),
                  _buildTenderBullet(
                    'Turnkey Procurement & Heavy Equipment Fleet',
                  ),
                  _buildTenderBullet(
                    'Zero-Incident OSHA & ISO 45001 Compliance',
                  ),
                  _buildTenderBullet(
                    'BIM Level 3 4D Digital Twin Schedule Guarantee',
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: JsConstructionTheme.kObsidian,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color:
                            JsConstructionTheme.kSafetyAmber.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ESTIMATION DESK ACTIVE',
                              style: GoogleFonts.spaceGrotesk(
                                color: JsConstructionTheme.kSafetyAmber,
                                fontWeight: FontWeight.w800,
                                fontSize: 11,
                                letterSpacing: 0.3,
                              ),
                            ),
                            Text(
                              'Average RFP Turnaround: 72 Hours',
                              style: GoogleFonts.plusJakartaSans(
                                color: JsConstructionTheme.kSteelMuted,
                                fontSize: 12,
                                letterSpacing: -0.1,
                              ),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.speed_rounded,
                          color: JsConstructionTheme.kSafetyAmber,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(
                  'CANCEL',
                  style: GoogleFonts.spaceGrotesk(
                    color: JsConstructionTheme.kSteelMuted,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: JsConstructionTheme.kSafetyAmber,
                      content: Text(
                        'Your project tender documentation request is lodged. Our Chief Estimator will contact you within 24 hours.',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.1,
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: JsConstructionTheme.kSafetyAmber,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  'CONFIRM TENDER LODGEMENT',
                  style: GoogleFonts.spaceGrotesk(
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildTenderBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            color: JsConstructionTheme.kSafetyAmber,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                color: JsConstructionTheme.kSteel,
                fontSize: 13,
                letterSpacing: -0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
