import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/core/theme/app_colors.dart';
import 'package:joel_portfolio/core/theme/brand_colors.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/pages/autovista_website_screen.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/pages/js_constructions_website_screen.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/pages/luxury_hotel_website_screen.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/pages/purelis_website_screen.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/widgets/app_image.dart';

class WorkareaSection extends StatefulWidget {
  const WorkareaSection({super.key});

  @override
  State<WorkareaSection> createState() => _WorkareaSectionState();
}

class _WorkareaSectionState extends State<WorkareaSection> {
  final List<Map<String, dynamic>> _workItems = [
    {
      'id': 'js_constructions',
      'title': 'JS CONSTRUCTIONS',
      'subtitle':
          'Global EPC Engineering, Supertall Commercial Towers & Parametric Megaprojects',
      'category': 'Construction & Civil Engineering UI',
      'image': 'assets/construction_hero_cover.jpg',
      'tags': [
        'Flutter Web',
        'Scroll Video Engine',
        'Supertall Towers',
        'Civil Megaprojects',
        'Interactive RFP Tender'
      ],
      'builder': (BuildContext context) => const JsConstructionsWebsiteScreen(),
    },
    {
      'id': 'lumina_palace',
      'title': 'THE LUMINA PALACE',
      'subtitle':
          'Ultra-Luxury 5-Star Hotel Resort, Private Suites & Scroll-Driven Video Experience',
      'category': 'Luxury Hospitality UI',
      'image': 'assets/hotel_cover.jpg',
      'tags': ['Flutter Web', 'Scroll Video Engine', 'Suite Booking', 'Concierge & Spa', 'Haute Cuisine'],
      'builder': (BuildContext context) => const LuxuryHotelWebsiteScreen(),
    },
    {
      'id': 'purelis',
      'title': 'PURELIS SKINCARE',
      'subtitle':
          'Organic Luxury Botanical & Clinical Skincare E-Commerce Platform',
      'category': 'Skincare E-Commerce',
      'image': 'assets/purelis_cover.png',
      'tags': ['Flutter Web', 'E-Commerce', 'Luxury Showcase', 'Editorial Design'],
      'builder': (BuildContext context) => const PurelisWebsiteScreen(),
    },
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

          // ── 3-Column GridView ──────────────────────────────────────────────
          LayoutBuilder(
            builder: (context, constraints) {
              final int crossAxisCount;
              if (constraints.maxWidth >= 840) {
                crossAxisCount = 3;
              } else if (constraints.maxWidth >= 540) {
                crossAxisCount = 2;
              } else {
                crossAxisCount = 1;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _workItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  mainAxisExtent: 500,
                ),
                itemBuilder: (context, index) {
                  final item = _workItems[index];
                  return _WorkItemCard(item: item, pal: pal);
                },
              );
            },
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
            Container(width: 24, height: 2, color: BrandColors.warmBrown),
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

  const _WorkItemCard({required this.item, required this.pal});

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
                flex: 5,
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
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.75),
                            border: Border.all(
                              color: BrandColors.warmBrown.withValues(
                                alpha: 0.6,
                              ),
                            ),
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
                flex: 6,
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
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item['subtitle'],
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              color: pal.textPrimary.withValues(alpha: 0.7),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
                              horizontal: 8,
                              vertical: 3,
                            ),
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
