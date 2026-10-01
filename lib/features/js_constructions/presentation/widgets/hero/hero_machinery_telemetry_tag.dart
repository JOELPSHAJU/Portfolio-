import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/fleet_machine.dart';

/// Floating Holographic Hero Machinery Telemetry HUD Tag
class HeroMachineryTelemetryTag extends StatelessWidget {
  final String model;
  final String weight;
  final String power;
  final String tag;
  final int index;
  final int total;
  final bool isCompact;

  const HeroMachineryTelemetryTag({
    super.key,
    required this.model,
    required this.weight,
    required this.power,
    required this.tag,
    required this.index,
    required this.total,
    this.isCompact = false,
  });

  factory HeroMachineryTelemetryTag.fromEntity({
    Key? key,
    required FleetMachine machinery,
    required int index,
    required int total,
    bool isCompact = false,
  }) {
    return HeroMachineryTelemetryTag(
      key: key,
      model: machinery.model,
      weight: machinery.weight,
      power: machinery.power,
      tag: machinery.tag,
      index: index,
      total: total,
      isCompact: isCompact,
    );
  }

  factory HeroMachineryTelemetryTag.fromMap({
    Key? key,
    required Map<String, dynamic> machinery,
    required int index,
    required int total,
    bool isCompact = false,
  }) {
    return HeroMachineryTelemetryTag(
      key: key,
      model: (machinery['model'] as String?) ?? '',
      weight: (machinery['weight'] as String?) ?? '',
      power: (machinery['power'] as String?) ?? '',
      tag: (machinery['tag'] as String?) ?? '',
      index: index,
      total: total,
      isCompact: isCompact,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String unitStr =
        'UNIT ${(index + 1).toString().padLeft(2, '0')} / ${total.toString().padLeft(2, '0')}';

    if (isCompact) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xE60A0D14),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFFF9F1C).withValues(alpha: 0.55),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF9F1C).withValues(alpha: 0.20),
              blurRadius: 14,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF22C55E),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF22C55E),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              model,
              style: GoogleFonts.spaceGrotesk(
                color: Colors.white,
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            if (weight.isNotEmpty) ...[
              const SizedBox(width: 8),
              Container(
                width: 1,
                height: 10,
                color: Colors.white.withValues(alpha: 0.2),
              ),
              const SizedBox(width: 8),
              Text(
                weight,
                style: GoogleFonts.spaceGrotesk(
                  color: const Color(0xFFFF9F1C),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xE6090D15),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFFF9F1C).withValues(alpha: 0.60),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.65),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: const Color(0xFFFF9F1C).withValues(alpha: 0.22),
            blurRadius: 18,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Live status dot
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF22C55E),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF22C55E),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: 9),
          Text(
            unitStr,
            style: GoogleFonts.spaceGrotesk(
              color: const Color(0xFF94A3B8),
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 1,
            height: 12,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          const SizedBox(width: 10),
          Text(
            model,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
          if (weight.isNotEmpty) ...[
            const SizedBox(width: 10),
            Container(
              width: 1,
              height: 12,
              color: Colors.white.withValues(alpha: 0.2),
            ),
            const SizedBox(width: 10),
            Text(
              weight,
              style: GoogleFonts.spaceGrotesk(
                color: const Color(0xFFFF9F1C),
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
          if (power.isNotEmpty) ...[
            const SizedBox(width: 8),
            Text(
              '• $power',
              style: GoogleFonts.spaceGrotesk(
                color: const Color(0xFFCBD5E1),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          if (tag.isNotEmpty) ...[
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0x33FF9F1C),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                tag,
                style: GoogleFonts.spaceGrotesk(
                  color: const Color(0xFFFF9F1C),
                  fontSize: 9.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
