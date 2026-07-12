import 'package:flutter/material.dart';
import '../../../domain/entities/skill.dart';
import 'package:clean_riverpod_template/core/theme/app_colors.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';
import 'package:clean_riverpod_template/core/widgets/fade_in_slide.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Technical Specs ────────────────────────────────────────────────────────

class _SkillSpec {
  final String description;
  final String associatedProject;
  final List<String> keyParadigms;

  const _SkillSpec({
    required this.description,
    required this.associatedProject,
    required this.keyParadigms,
  });
}

const _specsMap = {
  'flutter': _SkillSpec(
    description: 'Declarative UI SDK for building responsive cross-platform native applications.',
    associatedProject: 'Kahramaa, Khadoom, Qatar Museums',
    keyParadigms: ['Declarative Layouts', 'Widget Lifecycle', 'Engine Render-loop'],
  ),
  'dart': _SkillSpec(
    description: 'Object-oriented programming language optimized for client applications with sound null safety.',
    associatedProject: 'All Portfolio Projects',
    keyParadigms: ['Asynchronous Streams', 'JSON Deserialization', 'Concurrency Isolates'],
  ),
  'bloc & cubit': _SkillSpec(
    description: 'Predictable state management implementing unidirectional data flow and strict event-to-state mapping.',
    associatedProject: 'QSW Mobile',
    keyParadigms: ['Stream Controllers', 'Event-Driven Logic', 'State Mutability Control'],
  ),
  'riverpod': _SkillSpec(
    description: 'Compile-safe, reactive state caching and dependency injection framework for Flutter.',
    associatedProject: 'Khadoom, Qatar Museums',
    keyParadigms: ['StateNotifier/Notifier', 'Auto-Dispose Scope', 'Family Modifiers'],
  ),
  'clean architecture': _SkillSpec(
    description: 'Feature-first directory isolation separating Data, Domain, and Presentation concerns.',
    associatedProject: 'Khadoom, QSW, Qatar Museums',
    keyParadigms: ['Separation of Concerns', 'Dependency Inversion', 'Interface Specifications'],
  ),
  'rest apis & dio': _SkillSpec(
    description: 'HTTP client orchestration including custom interceptors, automated token refresh, and caching.',
    associatedProject: 'Kahramaa, QSW, Khadoom',
    keyParadigms: ['Bearer Auth Binding', 'Request Interception', 'Retry Schedules'],
  ),
  'figma': _SkillSpec(
    description: 'Translating design tokens, high-fidelity components, and layout files into Flutter widget structures.',
    associatedProject: 'Khadoom, Qatar Museums UI Redesigns',
    keyParadigms: ['Design Token Mapping', 'Adaptive Grids', 'Micro-Animations'],
  ),
  'git & github actions': _SkillSpec(
    description: 'Automated integration pipelines validating lint guidelines, formatting standards, and target builds.',
    associatedProject: 'Continuous Deployment workflow',
    keyParadigms: ['Lint Verification', 'Action Scripts', 'OTA Distribution'],
  ),
  'unit & integration testing': _SkillSpec(
    description: 'Developing mock-based verification models for domain business logic and widget rendering trees.',
    associatedProject: 'Clean Architecture Boilerplate',
    keyParadigms: ['Mockito Mocking', 'Widget Goldens', 'Assertion Specs'],
  ),
  'supa base': _SkillSpec(
    description: 'Backend services configuration utilizing real-time database channels and row-level security policy.',
    associatedProject: 'ESS Chat Agent systems',
    keyParadigms: ['Row Security rules', 'DB Triggers', 'WebSocket Listeners'],
  ),
  'mvvm': _SkillSpec(
    description: 'Separating UI layers from business controller rules via formal bindings.',
    associatedProject: 'Museum Mobile App integration',
    keyParadigms: ['Data Binding', 'Logic Isolation', 'View State Binding'],
  ),
  'firebase': _SkillSpec(
    description: 'Cloud integrations for cloud storage, push notifications, and remote dynamic configuration.',
    associatedProject: 'Kahramaa Mobile App',
    keyParadigms: ['FCM Push Tokens', 'Crashlytics reports', 'Remote Config keys'],
  ),
  'melos': _SkillSpec(
    description: 'Multi-package management tool designed to coordinate mono-repository workflows.',
    associatedProject: 'Khadoom Monorepo Scope',
    keyParadigms: ['Package Versioning', 'Unified Scripts', 'Dependency Resolving'],
  ),
  'sqlite & hive': _SkillSpec(
    description: 'Offline-first database engines optimized for secure key-value and local cache retrieval.',
    associatedProject: 'Kahramaa, QSW Local Cache',
    keyParadigms: ['Secure Local storage', 'Hive Adapters', 'Encrypted Cache keys'],
  ),
  'ai-assisted workflows': _SkillSpec(
    description: 'Leveraging code generation modules and LLMs to optimize feature build speeds.',
    associatedProject: 'Development Accelerator',
    keyParadigms: ['AI Model Interop', 'Prompt Engineering', 'Generated Boilerplates'],
  ),
};

const _defaultSpec = _SkillSpec(
  description: 'Verified technical dependency module utilized in commercial production deployments.',
  associatedProject: 'General Enterprise Work',
  keyParadigms: ['Production Stability', 'Standard Design Pattern'],
);

class _CategoryMeta {
  final String id;
  final String name;
  final String queryKey;
  final IconData icon;

  const _CategoryMeta(this.id, this.name, this.queryKey, this.icon);
}

// ─── Component Main ─────────────────────────────────────────────────────────

class SkillsSection extends StatefulWidget {
  final List<Skill> skills;
  const SkillsSection({super.key, required this.skills});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  int _selectedCategoryIdx = 0;

  final _categories = const [
    _CategoryMeta('01', 'Languages', 'languages', Icons.code_rounded),
    _CategoryMeta('02', 'Mobile Platforms', 'mobile', Icons.phone_android_rounded),
    _CategoryMeta('03', 'Architecture', 'architecture', Icons.layers_rounded),
    _CategoryMeta('04', 'State Management', 'state', Icons.loop_rounded),
    _CategoryMeta('05', 'API & Data Services', 'api', Icons.cloud_queue_rounded),
    _CategoryMeta('06', 'DevOps & Workflows', 'tools', Icons.build_rounded),
    _CategoryMeta('07', 'Intelligent Tools', 'ai-assisted', Icons.psychology_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1024;
    final isTablet = size.width >= 768 && size.width < 1024;
    final sidePadding = isDesktop
        ? size.width * 0.08
        : (isTablet ? 40.0 : 24.0);
    final pal = context.palette;

    // Group skills by category query key
    final Map<String, List<Skill>> grouped = {};
    for (final s in widget.skills) {
      grouped.putIfAbsent(s.category.toLowerCase(), () => []).add(s);
    }

    final activeCat = _selectedCategoryIdx >= 0 
        ? _categories[_selectedCategoryIdx] 
        : _categories.first;
    final activeSkills = grouped.entries
        .where((e) => e.key.contains(activeCat.queryKey))
        .expand((e) => e.value)
        .toList()
      ..sort((a, b) => b.level.compareTo(a.level));

    return Container(
      color: pal.surface,
      width: double.infinity,
      child: Stack(
        children: [
          // Background Kinetic Typography
          Positioned(
            top: 40,
            left: 10,
            child: Text(
              'TECH.SYS',
              style: GoogleFonts.anton(
                fontSize: isDesktop ? 220 : 120,
                color: pal.textPrimary.withValues(alpha: 0.02),
                letterSpacing: -4,
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sidePadding, vertical: 100.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInSlide(
                  delay: const Duration(milliseconds: 100),
                  direction: 25.0,
                  child: _buildEditorialHeader(pal),
                ),
                const SizedBox(height: 60),

                // 2-Pane Viewport
                FadeInSlide(
                  delay: const Duration(milliseconds: 150),
                  direction: 25.0,
                  child: isDesktop
                      ? _buildTerminalDesktop(activeSkills, activeCat, pal)
                      : _buildMobileAccordion(grouped, pal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorialHeader(AppPalette pal) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 2,
          color: BrandColors.warmBrown,
          margin: const EdgeInsets.only(top: 10),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '03 / TECHNICAL_DIRECTORY_SYS',
                style: GoogleFonts.spaceMono(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: BrandColors.warmBrown,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'ECOSYSTEM\nSPECIFICATIONS.',
                style: GoogleFonts.anton(
                  fontSize: 48,
                  height: 1.1,
                  color: pal.textPrimary,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─── Desktop 2-Pane Terminal Layout ─────────────────────────────────────────

  Widget _buildTerminalDesktop(
    List<Skill> activeSkills,
    _CategoryMeta activeCat,
    AppPalette pal,
  ) {
    final borderCol = pal.textPrimary.withValues(alpha: 0.1);

    return Container(
      height: 640, // Fixed height to prevent layout overflows
      decoration: BoxDecoration(
        color: pal.card.withValues(alpha: 0.1),
        border: Border(
          top: BorderSide(color: BrandColors.warmBrown, width: 4),
          bottom: BorderSide(color: borderCol, width: 1),
          left: BorderSide(color: borderCol, width: 1),
          right: BorderSide(color: borderCol, width: 1),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ─── PANE 1: Directory Classes (Left) ───
          Container(
            width: 260,
            decoration: BoxDecoration(
              color: pal.card.withValues(alpha: 0.2),
              border: Border(right: BorderSide(color: borderCol, width: 1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    '// DIRECTORY_CLASSES',
                    style: GoogleFonts.spaceMono(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: pal.textPrimary.withValues(alpha: 0.4),
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(_categories.length, (idx) {
                        final cat = _categories[idx];
                        final isSelected = _selectedCategoryIdx == idx;
                        return _TerminalItem(
                          title: cat.name.toUpperCase(),
                          icon: cat.icon,
                          isSelected: isSelected,
                          pal: pal,
                          onTap: () {
                            setState(() {
                              _selectedCategoryIdx = idx;
                            });
                          },
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ─── PANE 2: Skill Grid (Right) ───
          Expanded(
            child: Container(
              color: pal.surface,
              child: activeSkills.isEmpty
                  ? Center(
                      child: Text(
                        'NO_DATA_FOUND',
                        style: GoogleFonts.spaceMono(
                          color: pal.textPrimary.withValues(alpha: 0.3),
                          letterSpacing: 2,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(48),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '// ${activeCat.name.toUpperCase()}_SPECIFICATIONS',
                            style: GoogleFonts.spaceMono(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: pal.textPrimary.withValues(alpha: 0.4),
                              letterSpacing: 2.0,
                            ),
                          ),
                          const SizedBox(height: 32),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final crossAxisCount = constraints.maxWidth > 700 ? 2 : 1;
                              final spacing = 16.0;
                              final width = (constraints.maxWidth - (crossAxisCount - 1) * spacing) / crossAxisCount;

                              return Wrap(
                                spacing: spacing,
                                runSpacing: spacing,
                                children: activeSkills.map((skill) {
                                  return SizedBox(
                                    width: width,
                                    child: _SkillManifestoCard(skill: skill),
                                  );
                                }).toList(),
                              );
                            }
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Mobile Accordion Terminal ─────────────────────────────────────────────

  Widget _buildMobileAccordion(Map<String, List<Skill>> grouped, AppPalette pal) {
    return Column(
      children: List.generate(_categories.length, (idx) {
        final cat = _categories[idx];
        final isSelected = _selectedCategoryIdx == idx;
        final list = grouped.entries
            .where((e) => e.key.contains(cat.queryKey))
            .expand((e) => e.value)
            .toList()
          ..sort((a, b) => b.level.compareTo(a.level));

        return Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          decoration: BoxDecoration(
            color: pal.card.withValues(alpha: 0.1),
            border: Border(
              left: BorderSide(
                color: isSelected ? BrandColors.warmBrown : pal.textPrimary.withValues(alpha: 0.1), 
                width: 4
              ),
              top: BorderSide(color: pal.textPrimary.withValues(alpha: 0.1), width: 1),
              right: BorderSide(color: pal.textPrimary.withValues(alpha: 0.1), width: 1),
              bottom: BorderSide(color: pal.textPrimary.withValues(alpha: 0.1), width: 1),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                leading: Icon(
                  cat.icon,
                  color: pal.textPrimary.withValues(alpha: 0.8),
                  size: 20,
                ),
                title: Text(
                  cat.name.toUpperCase(),
                  style: GoogleFonts.anton(
                    fontSize: 20,
                    color: pal.textPrimary,
                    letterSpacing: 1.0,
                  ),
                ),
                trailing: Icon(
                  isSelected ? Icons.remove : Icons.add,
                  color: pal.textPrimary,
                ),
                onTap: () {
                  setState(() => _selectedCategoryIdx = isSelected ? -1 : idx);
                },
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOutCubic,
                alignment: Alignment.topCenter,
                clipBehavior: Clip.hardEdge,
                child: isSelected 
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                        child: Column(
                          children: list.map((s) {
                            final spec = _specsMap[s.name.toLowerCase()] ?? _defaultSpec;
                            return Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        s.name.toUpperCase(),
                                        style: GoogleFonts.outfit(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                          color: pal.textPrimary,
                                        ),
                                      ),
                                      Text(
                                        '${(s.level * 100).toInt()}%',
                                        style: GoogleFonts.spaceMono(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: BrandColors.warmBrown,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    spec.description,
                                    style: GoogleFonts.outfit(
                                      fontSize: 14,
                                      color: pal.textPrimary.withValues(alpha: 0.7),
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// ─── Interactive Items ───────────────────────────────────────────────────────

class _TerminalItem extends StatefulWidget {
  final String title;
  final IconData? icon;
  final bool isSelected;
  final AppPalette pal;
  final VoidCallback onTap;

  const _TerminalItem({
    required this.title,
    this.icon,
    required this.isSelected,
    required this.pal,
    required this.onTap,
  });

  @override
  State<_TerminalItem> createState() => _TerminalItemState();
}

class _TerminalItemState extends State<_TerminalItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final pal = widget.pal;
    final isSelected = widget.isSelected;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? pal.textPrimary.withValues(alpha: 0.05)
                : (_hovered ? pal.textPrimary.withValues(alpha: 0.02) : Colors.transparent),
            border: Border(
              left: BorderSide(
                color: isSelected ? BrandColors.warmBrown : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon, 
                  size: 16, 
                  color: isSelected ? BrandColors.warmBrown : pal.textPrimary.withValues(alpha: 0.5)
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  widget.title,
                  style: GoogleFonts.spaceMono(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? pal.textPrimary : pal.textPrimary.withValues(alpha: 0.6),
                    letterSpacing: 1.0,
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

// ─── Skill Manifesto Card ─────────────────────────────────────────────────────

class _SkillManifestoCard extends StatefulWidget {
  final Skill skill;
  const _SkillManifestoCard({required this.skill});

  @override
  State<_SkillManifestoCard> createState() => _SkillManifestoCardState();
}

class _SkillManifestoCardState extends State<_SkillManifestoCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final pal = context.palette;
    final spec = _specsMap[widget.skill.name.toLowerCase()] ?? _defaultSpec;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _hovered ? pal.card.withValues(alpha: 0.6) : pal.card.withValues(alpha: 0.3),
          border: Border(
            left: BorderSide(
              color: _hovered ? pal.textPrimary : BrandColors.warmBrown, 
              width: 4,
            ),
            top: BorderSide(color: pal.textPrimary.withValues(alpha: 0.1), width: 1),
            right: BorderSide(color: pal.textPrimary.withValues(alpha: 0.1), width: 1),
            bottom: BorderSide(color: pal.textPrimary.withValues(alpha: 0.1), width: 1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '// PROFICIENCY: ${(widget.skill.level * 100).toInt()}%',
                  style: GoogleFonts.spaceMono(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: pal.textPrimary.withValues(alpha: 0.5),
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              widget.skill.name.toUpperCase(),
              style: GoogleFonts.anton(
                fontSize: 24,
                height: 1.1,
                color: pal.textPrimary,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              spec.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(
                fontSize: 13,
                height: 1.5,
                color: pal.textPrimary.withValues(alpha: 0.75),
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '// ARCHITECTURAL PARADIGMS',
              style: GoogleFonts.spaceMono(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: pal.textPrimary.withValues(alpha: 0.4),
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: spec.keyParadigms.map((p) => _buildTechTag(p, pal)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechTag(String name, AppPalette pal) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: pal.textPrimary.withValues(alpha: 0.03),
        border: Border.all(color: pal.textPrimary.withValues(alpha: 0.1)),
      ),
      child: Text(
        name.toUpperCase(),
        style: GoogleFonts.spaceMono(
          color: pal.textPrimary.withValues(alpha: 0.7),
          fontSize: 9.5,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
