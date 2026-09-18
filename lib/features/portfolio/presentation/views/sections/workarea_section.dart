import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/core/theme/app_colors.dart';
import 'package:joel_portfolio/core/theme/brand_colors.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/pages/autovista_website_screen.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/widgets/app_image.dart';

class WorkareaSection extends StatefulWidget {
  const WorkareaSection({super.key});

  @override
  State<WorkareaSection> createState() => _WorkareaSectionState();
}

class _WorkareaSectionState extends State<WorkareaSection> {
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _workItems = [
    {
      'id': 'godrive',
      'title': 'GO DRIVE',
      'subtitle': 'Next-Gen Luxury & Executive Car Rental Platform',
      'category': 'Car Rental Solution',
      'image': 'assets/autovista_hero_porsche.jpg',
      'tags': ['Flutter Web', 'Fleet Booking', 'Daily Rates', 'Rental Engine'],
      'builder': (BuildContext context) => const AutoVistaWebsiteScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final pal = context.palette;
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 900;
    final isTablet = size.width >= 600 && size.width < 900;

    final sidePadding = isDesktop
        ? 80.0
        : isTablet
            ? 40.0
            : 24.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: sidePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ────────────────────────────────────────────────────────
          _buildEditorialHeader(pal),
          const SizedBox(height: 40),

          // ── Horizontal Scrollable List ─────────────────────────────────────
          SizedBox(
            height: 480,
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _workItems.length,
              separatorBuilder: (context, index) => const SizedBox(width: 24),
              itemBuilder: (context, index) {
                final item = _workItems[index];
                return _WorkItemCard(item: item, pal: pal);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorialHeader(AppPalette pal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              height: 2,
              color: BrandColors.warmBrown,
            ),
            const SizedBox(width: 12),
            Text(
              '// SYSTEM LABS',
              style: GoogleFonts.spaceMono(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
                color: BrandColors.warmBrown,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'MY WORKAREA',
          style: GoogleFonts.anton(
            fontSize: 42,
            letterSpacing: 2,
            height: 1.0,
            color: pal.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Interactive full-scale UI/UX web designs & custom digital experiences.',
          style: GoogleFonts.outfit(
            fontSize: 16,
            color: pal.textPrimary.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}

class _WorkItemCard extends StatefulWidget {
  final Map<String, dynamic> item;
  final AppPalette pal;

  const _WorkItemCard({
    required this.item,
    required this.pal,
  });

  @override
  State<_WorkItemCard> createState() => _WorkItemCardState();
}

class _WorkItemCardState extends State<_WorkItemCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final pal = widget.pal;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  item['builder'](context),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 400),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          width: 380,
          decoration: BoxDecoration(
            color: _isHovered
                ? pal.card.withValues(alpha: 0.8)
                : pal.card.withValues(alpha: 0.4),
            border: Border.all(
              color: _isHovered
                  ? BrandColors.warmBrown
                  : pal.textPrimary.withValues(alpha: 0.12),
              width: _isHovered ? 1.5 : 1.0,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: BrandColors.warmBrown.withValues(alpha: 0.15),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Thumbnail with subtle hover scale
              Expanded(
                flex: 6,
                child: ClipRRect(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 500),
                          scale: _isHovered ? 1.06 : 1.0,
                          curve: Curves.easeOutCubic,
                          child: AppImage(
                            assetPath: item['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.7),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.75),
                            border: Border.all(
                                color: BrandColors.warmBrown.withValues(alpha: 0.6)),
                          ),
                          child: Text(
                            item['category'].toString().toUpperCase(),
                            style: GoogleFonts.spaceMono(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: BrandColors.warmBrown,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Card Content
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'],
                            style: GoogleFonts.anton(
                              fontSize: 22,
                              letterSpacing: 1,
                              color: pal.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item['subtitle'],
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              color: pal.textPrimary.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),

                      // Tech Tag Pills
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: (item['tags'] as List<String>).map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: pal.textPrimary.withValues(alpha: 0.05),
                              border: Border.all(
                                color: pal.textPrimary.withValues(alpha: 0.1),
                              ),
                            ),
                            child: Text(
                              tag,
                              style: GoogleFonts.spaceMono(
                                fontSize: 9,
                                color: pal.textPrimary.withValues(alpha: 0.7),
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      // CTA Launch button
                      Row(
                        children: [
                          Text(
                            'LAUNCH EXPERIENCE',
                            style: GoogleFonts.spaceMono(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              color: _isHovered
                                  ? BrandColors.warmBrown
                                  : pal.textPrimary.withValues(alpha: 0.6),
                            ),
                          ),
                          const SizedBox(width: 8),
                          AnimatedPadding(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.only(left: _isHovered ? 6 : 0),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              size: 14,
                              color: _isHovered
                                  ? BrandColors.warmBrown
                                  : pal.textPrimary.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
