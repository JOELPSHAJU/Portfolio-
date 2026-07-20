import 'package:flutter/material.dart';
import '../../../domain/entities/skill.dart';
import 'package:joel_portfolio/core/theme/app_colors.dart';
import 'package:joel_portfolio/core/theme/brand_colors.dart';
import 'package:joel_portfolio/core/widgets/fade_in_slide.dart';
import 'package:joel_portfolio/core/widgets/hover_animated_text.dart';
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
  // --- Core Language ---
  'dart': _SkillSpec(
    description:
        'Primary language for all my Flutter work — sound null safety, async/await with Streams, and Isolates for offloading heavy work off the UI thread.',
    associatedProject: 'All Portfolio Projects',
    keyParadigms: [
      'Sound Null Safety',
      'Async/Await & Streams',
      'Isolate Concurrency',
    ],
  ),

  // --- Flutter & Platform ---
  'flutter sdk': _SkillSpec(
    description:
        'Building pixel-accurate, cross-platform apps with Flutter\'s declarative UI model, including working with the Impeller renderer for smoother animation performance.',
    associatedProject: 'Kahramaa, Khadoom, Qatar Museums',
    keyParadigms: [
      'Declarative UI',
      'Widget Lifecycle & State',
      'Impeller Rendering',
    ],
  ),
  'android sdk': _SkillSpec(
    description:
        'Bridging into native Android when Flutter needs platform-specific behavior — background services and platform channels for native communication.',
    associatedProject: 'Khadoom ESS Background Workers',
    keyParadigms: [
      'Platform Channels',
      'Background Services',
      'Activity Lifecycle',
    ],
  ),
  'cross-platform development': _SkillSpec(
    description:
        'Shipping the same Flutter codebase across iOS, Android, and Web with responsive layouts and platform-aware adjustments where needed.',
    associatedProject: 'All Client Projects',
    keyParadigms: [
      'Responsive Layouts',
      'Platform Abstraction',
      'Conditional Compilation',
    ],
  ),

  // --- Architecture ---
  'clean architecture': _SkillSpec(
    description:
        'Structuring feature modules into Data, Domain, and Presentation layers to keep business logic testable and independent of UI or API changes.',
    associatedProject: 'Khadoom, QSW, Qatar Museums',
    keyParadigms: [
      'Separation of Concerns',
      'Dependency Inversion',
      'Layered Boundaries',
    ],
  ),
  'mvvm': _SkillSpec(
    description:
        'Keeping UI and business logic decoupled through view models, so widgets stay dumb and easy to test.',
    associatedProject: 'Qatar Museums App',
    keyParadigms: [
      'View Model Binding',
      'UI/Logic Decoupling',
      'Unidirectional Updates',
    ],
  ),
  'repository pattern': _SkillSpec(
    description:
        'Wrapping API and local data sources behind a single repository interface, so state management layers never talk to Dio or SQLite directly.',
    associatedProject: 'Riverpod & BLoC Data Layers',
    keyParadigms: [
      'Data Source Abstraction',
      'Repository Contracts',
      'Local/Remote Caching',
    ],
  ),
  'modular architecture': _SkillSpec(
    description:
        'Splitting large features into self-contained packages to keep build times reasonable and reduce merge conflicts across the team.',
    associatedProject: 'Kahramaa & Khadoom Codebases',
    keyParadigms: [
      'Feature Modules',
      'Package Boundaries',
      'Independent Compilation',
    ],
  ),

  // --- State Management ---
  'riverpod': _SkillSpec(
    description:
        'Go-to state management for new projects — compile-safe providers, auto-dispose for memory efficiency, and family modifiers for parameterized state.',
    associatedProject: 'Khadoom, Qatar Museums',
    keyParadigms: ['Notifier Providers', 'Auto-Dispose', 'Family Modifiers'],
  ),
  'bloc/cubit': _SkillSpec(
    description:
        'Used on larger teams where a strict event-to-state contract makes state transitions predictable and easier to review.',
    associatedProject: 'QSW Mobile System',
    keyParadigms: [
      'Event-Driven Transitions',
      'Stream-Based State',
      'Predictable State Flow',
    ],
  ),
  'provider': _SkillSpec(
    description:
        'Lightweight ChangeNotifier-based state management for smaller screens and simpler apps that don\'t need Riverpod\'s full toolset.',
    associatedProject: 'Kahramaa Dashboard Portal',
    keyParadigms: [
      'ChangeNotifier',
      'Context-Based Injection',
      'Consumer Rebuilds',
    ],
  ),

  // --- Networking & Security ---
  'rest apis (dio/http)': _SkillSpec(
    description:
        'Setting up Dio clients with interceptors for auth headers, logging, and automatic retries on transient failures.',
    associatedProject: 'Kahramaa, QSW, Khadoom APIs',
    keyParadigms: ['Interceptors', 'JSON Serialization', 'Retry Handling'],
  ),
  'jwt authentication': _SkillSpec(
    description:
        'Implementing token-based auth flows, including secure storage and handling expiry/refresh without interrupting the user session.',
    associatedProject: 'Kahramaa, Khadoom Secure Portals',
    keyParadigms: ['Token Validation', 'Secure Storage', 'Auth Guards'],
  ),
  'token refresh interceptors': _SkillSpec(
    description:
        'Dio interceptors that silently refresh expired tokens and queue/retry pending requests so users never see an auth error mid-session.',
    associatedProject: 'Kahramaa, QSW',
    keyParadigms: ['Silent Refresh', 'Request Queuing', 'Retry on 401'],
  ),
  'biometric security': _SkillSpec(
    description:
        'Adding Face ID / fingerprint login on top of existing auth, with a PIN fallback for unsupported devices.',
    associatedProject: 'Khadoom Employee Portal',
    keyParadigms: ['Local Authentication', 'Secure Enclave', 'PIN Fallback'],
  ),
  'websockets & push notifications': _SkillSpec(
    description:
        'Real-time chat/notification features using WebSockets, plus FCM for background push delivery.',
    associatedProject: 'Khadoom Realtime Messaging',
    keyParadigms: ['WebSocket Streams', 'FCM Push', 'Background Handling'],
  ),

  // --- Tooling & Workflow ---
  'git & github': _SkillSpec(
    description:
        'Day-to-day version control — feature branching, resolving merge conflicts, and clean PRs for team review.',
    associatedProject: 'All Projects',
    keyParadigms: ['Feature Branching', 'Conflict Resolution', 'PR Reviews'],
  ),
  'vs code & android studio': _SkillSpec(
    description:
        'Comfortable in both editors depending on the project, with a debugging and hot-reload workflow tuned for fast iteration.',
    associatedProject: 'Daily Workflow',
    keyParadigms: ['Hot Reload', 'Breakpoint Debugging', 'Custom Lint Rules'],
  ),
  'melos (monorepos)': _SkillSpec(
    description:
        'Managing multi-package Flutter monorepos — bootstrapping, versioning, and running scripts across packages.',
    associatedProject: 'Khadoom Monorepo',
    keyParadigms: [
      'Package Bootstrapping',
      'Version Sync',
      'Cross-Package Scripts',
    ],
  ),
  'postman': _SkillSpec(
    description:
        'Testing and documenting API endpoints before wiring them into the app, using environments to switch between staging/prod.',
    associatedProject: 'API Integration',
    keyParadigms: [
      'Environment Variables',
      'Request Collections',
      'Mock Responses',
    ],
  ),
  'figma': _SkillSpec(
    description:
        'Translating design files into responsive Flutter widgets, matching spacing, type scale, and color tokens closely.',
    associatedProject: 'UI Redesigns',
    keyParadigms: [
      'Design Token Mapping',
      'Spacing/Type Fidelity',
      'Responsive Conversion',
    ],
  ),

  // --- AI-Assisted Development ---
  'claude & gpt-4': _SkillSpec(
    description:
        'Using LLMs to speed up boilerplate, review logic, and think through architecture decisions before committing to one.',
    associatedProject: 'AI-Assisted Development',
    keyParadigms: [
      'Prompt-Driven Scaffolding',
      'Code Review Assist',
      'Architecture Sounding Board',
    ],
  ),
  'github copilot': _SkillSpec(
    description:
        'Inline completions for repetitive code — model classes, test scaffolding, and boilerplate widgets.',
    associatedProject: 'Daily Programming',
    keyParadigms: [
      'Inline Completions',
      'Boilerplate Generation',
      'Test Scaffolding',
    ],
  ),

  // --- Foundational / Academic ---
  'sql': _SkillSpec(
    description:
        'Comfortable writing queries and basic schema design for relational databases from coursework and backend-adjacent tasks.',
    associatedProject: 'Kahramaa Schema Work',
    keyParadigms: ['Query Writing', 'Basic Schema Design', 'Joins & Indexing'],
  ),
  'c': _SkillSpec(
    description:
        'Foundational systems programming from university coursework — pointers, manual memory management, and low-level logic.',
    associatedProject: 'Coursework',
    keyParadigms: [
      'Pointer Arithmetic',
      'Manual Memory Management',
      'Low-Level Logic',
    ],
  ),
  'c++': _SkillSpec(
    description:
        'Object-oriented programming fundamentals from coursework, useful background for reasoning about performance in Flutter/Dart.',
    associatedProject: 'Coursework',
    keyParadigms: [
      'OOP Fundamentals',
      'Memory Management',
      'Performance Reasoning',
    ],
  ),
};

const _defaultSpec = _SkillSpec(
  description:
      'Verified technical dependency module utilized in commercial production deployments.',
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
    _CategoryMeta(
      '02',
      'Mobile Platforms',
      'mobile',
      Icons.phone_android_rounded,
    ),
    _CategoryMeta('03', 'Architecture', 'architecture', Icons.layers_rounded),
    _CategoryMeta('04', 'State Management', 'state', Icons.loop_rounded),
    _CategoryMeta(
      '05',
      'API & Data Services',
      'api',
      Icons.cloud_queue_rounded,
    ),
    _CategoryMeta('06', 'DevOps & Workflows', 'tools', Icons.build_rounded),
    _CategoryMeta(
      '07',
      'Intelligent Tools',
      'ai-assisted',
      Icons.psychology_rounded,
    ),
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
    final activeSkills =
        grouped.entries
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
            padding: EdgeInsets.symmetric(
              horizontal: sidePadding,
              vertical: 100.0,
            ),
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
              HoverAnimatedText(
                text: 'ECOSYSTEM\nSPECIFICATIONS.',
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

    return IntrinsicHeight(
      child: Container(
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
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 350),
                    reverseDuration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOutCubic,
                    alignment: Alignment.topCenter,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                        return Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            ...previousChildren,
                            if (currentChild != null) currentChild,
                          ],
                        );
                      },
                      child: activeSkills.isEmpty
                          ? Center(
                              key: const ValueKey('no_data'),
                              child: Padding(
                                padding: const EdgeInsets.all(48),
                                child: Text(
                                  'NO_DATA_FOUND',
                                  style: GoogleFonts.spaceMono(
                                    color: pal.textPrimary.withValues(alpha: 0.3),
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              key: ValueKey(activeCat.id),
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
                                  () {
                                    final size = MediaQuery.of(context).size;
                                    final sidePadding = size.width * 0.08;
                                    final availableWidth = size.width - (sidePadding * 2) - 260 - 96;
                                    final crossAxisCount = availableWidth > 600 ? 2 : 1;
                                    final spacing = 16.0;

                                    if (crossAxisCount == 1) {
                                      return Column(
                                        children: activeSkills.map((skill) {
                                          return Padding(
                                            padding: EdgeInsets.only(bottom: spacing),
                                            child: _SkillManifestoCard(skill: skill),
                                          );
                                        }).toList(),
                                      );
                                    }

                                    // Group skills into pairs for 2-column layout
                                    final List<List<Skill>> rows = [];
                                    for (int i = 0; i < activeSkills.length; i += 2) {
                                      if (i + 1 < activeSkills.length) {
                                        rows.add([
                                          activeSkills[i],
                                          activeSkills[i + 1],
                                        ]);
                                      } else {
                                        rows.add([activeSkills[i]]);
                                      }
                                    }

                                    return Column(
                                      children: rows.map((rowSkills) {
                                        return Padding(
                                          padding: EdgeInsets.only(bottom: spacing),
                                          child: IntrinsicHeight(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Expanded(
                                                  child: _SkillManifestoCard(
                                                    skill: rowSkills[0],
                                                  ),
                                                ),
                                                SizedBox(width: spacing),
                                                Expanded(
                                                  child: rowSkills.length > 1
                                                      ? _SkillManifestoCard(
                                                          skill: rowSkills[1],
                                                        )
                                                      : const SizedBox.shrink(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  }(),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  // ─── Mobile Accordion Terminal ─────────────────────────────────────────────

  Widget _buildMobileAccordion(
    Map<String, List<Skill>> grouped,
    AppPalette pal,
  ) {
    return Column(
      children: List.generate(_categories.length, (idx) {
        final cat = _categories[idx];
        final isSelected = _selectedCategoryIdx == idx;
        final list =
            grouped.entries
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
                color: isSelected
                    ? BrandColors.warmBrown
                    : pal.textPrimary.withValues(alpha: 0.1),
                width: 4,
              ),
              top: BorderSide(
                color: pal.textPrimary.withValues(alpha: 0.1),
                width: 1,
              ),
              right: BorderSide(
                color: pal.textPrimary.withValues(alpha: 0.1),
                width: 1,
              ),
              bottom: BorderSide(
                color: pal.textPrimary.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                leading: Icon(
                  cat.icon,
                  color: pal.textPrimary.withValues(alpha: 0.8),
                  size: 20,
                ),
                title: HoverAnimatedText(
                  text: cat.name.toUpperCase(),
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
                            final spec =
                                _specsMap[s.name.toLowerCase()] ?? _defaultSpec;
                            return Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      HoverAnimatedText(
                                        text: s.name.toUpperCase(),
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
                                      color: pal.textPrimary.withValues(
                                        alpha: 0.7,
                                      ),
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
                : (_hovered
                      ? pal.textPrimary.withValues(alpha: 0.02)
                      : Colors.transparent),
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
                  color: isSelected
                      ? BrandColors.warmBrown
                      : pal.textPrimary.withValues(alpha: 0.5),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  widget.title,
                  style: GoogleFonts.spaceMono(
                    fontSize: 12,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected
                        ? pal.textPrimary
                        : pal.textPrimary.withValues(alpha: 0.6),
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
          color: _hovered
              ? pal.card.withValues(alpha: 0.6)
              : pal.card.withValues(alpha: 0.3),
          border: Border(
            left: BorderSide(
              color: _hovered ? pal.textPrimary : BrandColors.warmBrown,
              width: 4,
            ),
            top: BorderSide(
              color: pal.textPrimary.withValues(alpha: 0.1),
              width: 1,
            ),
            right: BorderSide(
              color: pal.textPrimary.withValues(alpha: 0.1),
              width: 1,
            ),
            bottom: BorderSide(
              color: pal.textPrimary.withValues(alpha: 0.1),
              width: 1,
            ),
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
            HoverAnimatedText(
              text: widget.skill.name.toUpperCase(),
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
              children: spec.keyParadigms
                  .map((p) => _buildTechTag(p, pal))
                  .toList(),
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
