import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/skill.dart';
import 'package:joel_portfolio/core/widgets/fade_in_slide.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// Modern Cyber-Aesthetic "TECH STACK & SKILLS" Section
/// Pixel-perfect 1:1 reproduction of the architectural design reference.
/// ─────────────────────────────────────────────────────────────────────────────
class SkillsSection extends StatefulWidget {
  final List<Skill> skills;

  const SkillsSection({super.key, required this.skills});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  // Theme Color Palette directly sampled from reference design
  static const Color kBackground = Color(0xFF060911);
  static const Color kCardSurface = Color(0xFF090E17);
  static const Color kCardSurfaceLight = Color(0xFF0C1320);
  static const Color kBorder = Color(0xFF131D2E);
  static const Color kBorderHover = Color(0xFF00D2FF);
  static const Color kCyan = Color(0xFF00D2FF);
  static const Color kCyanGlow = Color(0xFF38BDF8);
  static const Color kBlueAccent = Color(0xFF0091FF);
  static const Color kTextWhite = Color(0xFFFFFFFF);
  static const Color kTextMuted = Color(0xFF94A3B8);
  static const Color kTextSub = Color(0xFF64748B);

  int _selectedCategoryIndex = 0;

  static const List<_CategoryDefinition> _categories = [
    _CategoryDefinition(
      id: 'languages',
      label: 'LANGUAGES',
      headerTitle: 'PROGRAMMING LANGUAGES',
      icon: Icons.code_rounded,
      countLabel: '7+ LANGUAGES',
    ),
    _CategoryDefinition(
      id: 'mobile',
      label: 'MOBILE PLATFORMS',
      headerTitle: 'MOBILE & CROSS-PLATFORM SDKS',
      icon: Icons.smartphone_rounded,
      countLabel: '5+ PLATFORMS',
    ),
    _CategoryDefinition(
      id: 'architecture',
      label: 'ARCHITECTURE',
      headerTitle: 'SOFTWARE & SYSTEM ARCHITECTURE',
      icon: Icons.layers_outlined,
      countLabel: '6+ PATTERNS',
    ),
    _CategoryDefinition(
      id: 'state',
      label: 'STATE MANAGEMENT',
      headerTitle: 'REACTIVE STATE ORCHESTRATION',
      icon: Icons.view_in_ar_rounded,
      countLabel: '4+ FRAMEWORKS',
    ),
    _CategoryDefinition(
      id: 'api',
      label: 'API & DATA SERVICES',
      headerTitle: 'NETWORKING, CLOUD & AUTHENTICATION',
      icon: Icons.cloud_outlined,
      countLabel: '7+ SERVICES',
    ),
    _CategoryDefinition(
      id: 'tools',
      label: 'DEVOPS & WORKFLOWS',
      headerTitle: 'DEV PIPELINES & WORKFLOW SUITE',
      icon: Icons.build_outlined,
      countLabel: '5+ TOOLS',
    ),
    _CategoryDefinition(
      id: 'ai',
      label: 'INTELLIGENT TOOLS',
      headerTitle: 'AI-ASSISTED DEVELOPMENT & AGENTS',
      icon: Icons.psychology_outlined,
      countLabel: '4+ PLATFORMS',
    ),
  ];

  static final Map<String, List<_SkillItem>> _categorySkillsMap = {
    'languages': [
      const _SkillItem(
        name: 'DART',
        level: 0.95,
        description:
            'Primary language for all my Flutter work — sound null safety, async/await with Streams, and isolates for offloading heavy work.',
        tags: ['OOP', 'ASYNC/AWAIT', 'ISOLATES'],
        techType: _TechType.dart,
      ),
      const _SkillItem(
        name: 'SQL',
        level: 0.80,
        description:
            'Comfortable writing queries and basic schema design for relational databases from coursework and backend-adjacent tasks.',
        tags: ['QUERY WRITING', 'SCHEMA DESIGN', 'JOINS'],
        techType: _TechType.sql,
      ),
      const _SkillItem(
        name: 'C++',
        level: 0.75,
        description:
            'Object-oriented programming fundamentals from coursework, useful background for performance in Flutter/Dart.',
        tags: ['OOP', 'MEMORY MGMT', 'PERFORMANCE'],
        techType: _TechType.cpp,
      ),
      const _SkillItem(
        name: 'C',
        level: 0.70,
        description:
            'Foundational systems programming from university coursework — pointers, manual memory management, and low-level logic.',
        tags: ['POINTERS', 'MEMORY MGMT', 'LOW-LEVEL LOGIC'],
        techType: _TechType.c,
      ),
    ],
    'mobile': [
      const _SkillItem(
        name: 'FLUTTER SDK',
        level: 0.96,
        description:
            'Building high-performance, pixel-perfect digital ecosystems with Flutter declarative UI and Impeller rendering engine.',
        tags: ['DECLARATIVE UI', 'IMPELLER', 'ANIMATIONS'],
        techType: _TechType.flutter,
      ),
      const _SkillItem(
        name: 'ANDROID SDK',
        level: 0.85,
        description:
            'Bridging Flutter to native Android behavior using platform channels, background workers, and system services.',
        tags: ['PLATFORM CHANNELS', 'SERVICES', 'GRADLE'],
        techType: _TechType.android,
      ),
      const _SkillItem(
        name: 'CROSS-PLATFORM',
        level: 0.95,
        description:
            'Delivering identical single-codebase experiences across iOS, Android, and Web with responsive design systems.',
        tags: ['RESPONSIVE', 'WEB', 'MOBILE'],
        techType: _TechType.crossPlatform,
      ),
      const _SkillItem(
        name: 'IOS DEVELOPMENT',
        level: 0.80,
        description:
            'Configuring Xcode build targets, CocoaPods integration, test provisioning profiles, and App Store guidelines.',
        tags: ['XCODE', 'PROVISIONING', 'COCOAPODS'],
        techType: _TechType.ios,
      ),
    ],
    'architecture': [
      const _SkillItem(
        name: 'CLEAN ARCHITECTURE',
        level: 0.95,
        description:
            'Domain, Data, and Presentation separation for maintainable, testable, and loosely coupled enterprise repositories.',
        tags: ['DOMAIN', 'DATA', 'PRESENTATION'],
        techType: _TechType.cleanArch,
      ),
      const _SkillItem(
        name: 'MVVM PATTERN',
        level: 0.90,
        description:
            'Decoupling UI widgets from business rules via dedicated view models to maximize unit test coverage.',
        tags: ['VIEWMODELS', 'DECOUPLING', 'UNIDIRECTIONAL'],
        techType: _TechType.mvvm,
      ),
      const _SkillItem(
        name: 'REPOSITORY PATTERN',
        level: 0.92,
        description:
            'Shielding state management and UI from low-level data layer specifics with unified abstract contracts.',
        tags: ['CACHING', 'CONTRACTS', 'ABSTRACTION'],
        techType: _TechType.repoPattern,
      ),
      const _SkillItem(
        name: 'MODULAR CODEBASES',
        level: 0.94,
        description:
            'Splitting complex monorepos into isolated Flutter packages with strict boundary encapsulation using Melos.',
        tags: ['FEATURE MODULES', 'MELOS', 'PACKAGES'],
        techType: _TechType.modular,
      ),
    ],
    'state': [
      const _SkillItem(
        name: 'RIVERPOD',
        level: 0.96,
        description:
            'Type-safe reactive state management with compile-time safety, auto-dispose mechanics, and family providers.',
        tags: ['NOTIFIERS', 'AUTO-DISPOSE', 'FAMILIES'],
        techType: _TechType.riverpod,
      ),
      const _SkillItem(
        name: 'BLOC / CUBIT',
        level: 0.92,
        description:
            'Event-driven state transitions with reactive stream architecture, ideal for auditable enterprise workflows.',
        tags: ['EVENT-DRIVEN', 'STREAMS', 'PREDICTABLE'],
        techType: _TechType.bloc,
      ),
      const _SkillItem(
        name: 'PROVIDER',
        level: 0.90,
        description:
            'Lightweight ChangeNotifier-based state propagation and dependency injection for targeted view updates.',
        tags: ['CHANGENOTIFIER', 'INHERITEDWIDGET', 'DI'],
        techType: _TechType.provider,
      ),
      const _SkillItem(
        name: 'GETX',
        level: 0.80,
        description:
            'Rapid prototyping and controller-based routing workflows for lightweight feature implementations.',
        tags: ['REACTIVE', 'CONTROLLERS', 'FAST PROTOTYPING'],
        techType: _TechType.getx,
      ),
    ],
    'api': [
      const _SkillItem(
        name: 'REST APIS (DIO)',
        level: 0.95,
        description:
            'Resilient HTTP networking with automated token interceptors, exponential retries, and JSON serialization.',
        tags: ['INTERCEPTORS', 'RETRIES', 'JSON'],
        techType: _TechType.rest,
      ),
      const _SkillItem(
        name: 'JWT & ENTRA ID',
        level: 0.92,
        description:
            'Enterprise single-sign-on (SSO), biometric authorization gates, OAuth2 token rotation, and encrypted storage.',
        tags: ['OAUTH2', 'SECURE STORAGE', 'REFRESH'],
        techType: _TechType.jwt,
      ),
      const _SkillItem(
        name: 'POSTGRESQL / SUPABASE',
        level: 0.88,
        description:
            'Relational schema modeling, row-level security (RLS) policies, and live PostgreSQL realtime websocket streams.',
        tags: ['POSTGRES', 'RLS', 'REALTIME'],
        techType: _TechType.sql,
      ),
      const _SkillItem(
        name: 'FIREBASE SUITE',
        level: 0.90,
        description:
            'Cloud Firestore document data synchronization, Firebase Auth, Push Notifications, and Remote Config.',
        tags: ['FIRESTORE', 'AUTH', 'STORAGE'],
        techType: _TechType.firebase,
      ),
      const _SkillItem(
        name: 'WEBSOCKETS',
        level: 0.85,
        description:
            'Low-latency bidirectional streaming channels for live notifications, real-time metrics, and telemetry.',
        tags: ['REALTIME', 'SOCKETS', 'EVENTS'],
        techType: _TechType.sockets,
      ),
    ],
    'tools': [
      const _SkillItem(
        name: 'GIT & GITHUB',
        level: 0.94,
        description:
            'Gitflow branching paradigms, interactive rebase, pull request review rituals, and automated GitHub Actions.',
        tags: ['BRANCHING', 'REBASE', 'ACTIONS'],
        techType: _TechType.git,
      ),
      const _SkillItem(
        name: 'DOCKER',
        level: 0.82,
        description:
            'Containerizing microservices and database instances for deterministic local testing and clean deployments.',
        tags: ['CONTAINERS', 'DOCKERFILE', 'COMPOSE'],
        techType: _TechType.docker,
      ),
      const _SkillItem(
        name: 'POSTMAN',
        level: 0.90,
        description:
            'Developing API testing collections, mock servers, environment configurations, and pre-request scripts.',
        tags: ['TEST SUITES', 'ENVIRONMENTS', 'MOCKING'],
        techType: _TechType.postman,
      ),
      const _SkillItem(
        name: 'VS CODE & STUDIO',
        level: 0.95,
        description:
            'Customized developer setup with Flutter DevTools profiling, memory inspection, and high-velocity shortcuts.',
        tags: ['EXTENSIONS', 'PROFILING', 'SHORTCUTS'],
        techType: _TechType.ide,
      ),
    ],
    'ai': [
      const _SkillItem(
        name: 'ANTIGRAVITY SDK',
        level: 0.96,
        description:
            'Designing, deploying, and debugging autonomous AI coding agents and multi-agent system orchestrations.',
        tags: ['AI AGENTS', 'AUTOMATION', 'WORKFLOWS'],
        techType: _TechType.antigravity,
      ),
      const _SkillItem(
        name: 'CLAUDE & GPT-4',
        level: 0.96,
        description:
            'Pair-programming workflows, architectural design validation, complex algorithm synthesis, and unit testing.',
        tags: ['SYSTEM PROMPTING', 'PAIRING', 'REFACTORING'],
        techType: _TechType.claude,
      ),
      const _SkillItem(
        name: 'GITHUB COPILOT',
        level: 0.92,
        description:
            'Inline AI completion for boilerplate acceleration, test suite generation, and contextual regex modeling.',
        tags: ['CODE COMPLETION', 'UNIT TESTS', 'VELOCITY'],
        techType: _TechType.copilot,
      ),
      const _SkillItem(
        name: 'CURSOR',
        level: 0.98,
        description:
            'Agentic editing workflows with codebase embeddings, semantic context indexing, and inline diff reviews.',
        tags: ['AGENTIC EDITS', 'INDEXING', 'INLINE CHAT'],
        techType: _TechType.cursor,
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1150;
    final isTablet = size.width >= 720 && size.width < 1150;

    final horizontalPadding = isDesktop
        ? size.width * 0.075
        : (isTablet ? 36.0 : 20.0);

    final currentCategory = _categories[_selectedCategoryIndex];
    final currentSkills =
        _categorySkillsMap[currentCategory.id] ??
        _categorySkillsMap['languages']!;

    return Container(
      color: kBackground,
      width: double.infinity,
      child: Stack(
        children: [
          // Ambient Neon Cyan Radial Lighting Backdrops
          Positioned(
            top: 60,
            right: size.width * 0.08,
            child: IgnorePointer(
              child: Container(
                width: 520,
                height: 520,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [kCyan.withValues(alpha: 0.07), Colors.transparent],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            left: size.width * 0.04,
            child: IgnorePointer(
              child: Container(
                width: 480,
                height: 480,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      kBlueAccent.withValues(alpha: 0.06),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isDesktop ? 100.0 : 60.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── 1. Top Section: Headline + Workspace Photography Showcase ──
                FadeInSlide(
                  direction: 20.0,
                  child: isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 12,
                              child: _buildTopHeaderLeft(isDesktop),
                            ),
                            const SizedBox(width: 48),
                            Expanded(
                              flex: 12,
                              child: _buildTopHeaderRight(isDesktop),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTopHeaderLeft(isDesktop),
                            const SizedBox(height: 32),
                            _buildTopHeaderRight(isDesktop),
                          ],
                        ),
                ),

                SizedBox(height: isDesktop ? 60 : 44),

                // ── 2. Main Interactive Layout: Sidebar + Grid ──
                FadeInSlide(
                  delay: const Duration(milliseconds: 120),
                  direction: 20.0,
                  child: isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left Category Navigation Sidebar
                            SizedBox(
                              width: 250,
                              child: _buildSidebar(isDesktop: true),
                            ),
                            const SizedBox(width: 32),

                            // Right Skills Grid + Header + Waveform Banner
                            Expanded(
                              child: _buildMainContentArea(
                                category: currentCategory,
                                skills: currentSkills,
                                isDesktop: true,
                                isTablet: false,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Horizontal Category Pill Slider for Mobile/Tablet
                            _buildSidebar(isDesktop: false),
                            const SizedBox(height: 32),

                            // Right Skills Grid
                            _buildMainContentArea(
                              category: currentCategory,
                              skills: currentSkills,
                              isDesktop: false,
                              isTablet: isTablet,
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // 1. TOP HEADER - LEFT CONTENT
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildTopHeaderLeft(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pill / Section Identifier (e.g. 03 / SKILLS)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: kCardSurface,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: kCyan.withValues(alpha: 0.35),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: kCyan,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: kCyan.withValues(alpha: 0.8),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '03 / SKILLS',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      color: kCyan,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),

        // Headline Line 1 & Line 2
        Text(
          'TECH STACK &',
          style: GoogleFonts.plusJakartaSans(
            fontSize: isDesktop ? 38 : 28,
            fontWeight: FontWeight.w900,
            color: kTextWhite,
            letterSpacing: -0.5,
            height: 1.12,
          ),
        ),
        const SizedBox(height: 4),

        if (isDesktop)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF00D2FF), Color(0xFF38BDF8)],
                  stops: [0.0, 1.0],
                ).createShader(bounds),
                child: Text(
                  'SKILLS.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -0.5,
                    height: 1.12,
                  ),
                ),
              ),
              const SizedBox(width: 24),

              // Vertical divider + Subtitle Paragraph
              Container(width: 1.5, height: 44, color: const Color(0xFF1E293B)),
              const SizedBox(width: 18),

              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Text(
                    'Tools, technologies, and frameworks I use to build scalable, performant, and user-focused digital solutions.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.5,
                      color: kTextMuted,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          )
        else ...[
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF00D2FF), Color(0xFF38BDF8)],
              stops: [0.0, 1.0],
            ).createShader(bounds),
            child: Text(
              'SKILLS.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -0.5,
                height: 1.12,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Tools, technologies, and frameworks I use to build scalable, performant, and user-focused digital solutions.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.5,
              color: kTextMuted,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // 1. TOP HEADER - RIGHT WORKSPACE SHOWCASE (with "Code > Build > Deliver" pill)
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildTopHeaderRight(bool isDesktop) {
    return Container(
      height: isDesktop ? 260 : 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kBorder.withValues(alpha: 0.8), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Dark Cyber Workstation Photography
            Image.asset('assets/skills_workspace.jpg', fit: BoxFit.cover),

            // Left Ambient Vignette
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    kBackground.withValues(alpha: 0.85),
                    kBackground.withValues(alpha: 0.25),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),

            // Bottom Ambient Vignette
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    kBackground.withValues(alpha: 0.75),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.55],
                ),
              ),
            ),

            // Floating Frosted Capsule: Code > Build > Deliver
            Positioned(
              top: isDesktop ? 24 : 16,
              right: isDesktop ? 24 : 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xCC070C15),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: kCyan.withValues(alpha: 0.4),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: kCyan.withValues(alpha: 0.15),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Code',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(
                            Icons.chevron_right_rounded,
                            size: 16,
                            color: kCyan,
                          ),
                        ),
                        Text(
                          'Build',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(
                            Icons.chevron_right_rounded,
                            size: 16,
                            color: kCyan,
                          ),
                        ),
                        Text(
                          'Deliver',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: kCyan,
                          ),
                        ),
                      ],
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

  // ════════════════════════════════════════════════════════════════════════════
  // 2. CATEGORY SIDEBAR
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildSidebar({required bool isDesktop}) {
    if (!isDesktop) {
      // Horizontal Scrollable Tab Bar on Mobile & Tablet
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(_categories.length, (index) {
            final cat = _categories[index];
            final isSelected = _selectedCategoryIndex == index;
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: _CategoryPillButton(
                category: cat,
                isSelected: isSelected,
                isCompact: true,
                onTap: () => setState(() => _selectedCategoryIndex = index),
              ),
            );
          }),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category List
        ...List.generate(_categories.length, (index) {
          final cat = _categories[index];
          final isSelected = _selectedCategoryIndex == index;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _CategoryPillButton(
              category: cat,
              isSelected: isSelected,
              isCompact: false,
              onTap: () => setState(() => _selectedCategoryIndex = index),
            ),
          );
        }),

        const SizedBox(height: 36),

        // Quote Callout Card (Bottom of Sidebar)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: kCyan, width: 2.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '“',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 26,
                  height: 0.8,
                  fontWeight: FontWeight.w800,
                  color: kCyan,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Good tools amplify\ngood ideas.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.0,
                  color: kTextMuted,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // 3. MAIN CONTENT AREA (Subheader + Grid + Waveform Banner)
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildMainContentArea({
    required _CategoryDefinition category,
    required List<_SkillItem> skills,
    required bool isDesktop,
    required bool isTablet,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Subheader: /// PROGRAMMING LANGUAGES  • 7+ LANGUAGES
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    '/// ',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                      color: kCyan,
                      letterSpacing: 2.0,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      category.headerTitle,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                        color: kCyan,
                        letterSpacing: 2.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: kTextSub,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  category.countLabel,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: kTextSub,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 20),

        // 3-Column Skills Grid (Desktop) or 2-Column (Tablet) or 1-Column (Mobile)
        LayoutBuilder(
          builder: (context, constraints) {
            final double availableWidth = constraints.maxWidth;
            final int crossAxisCount = availableWidth >= 920
                ? 3
                : (availableWidth >= 580 ? 2 : 1);

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: skills.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 220,
              ),
              itemBuilder: (context, index) {
                return _SkillCard(skill: skills[index]);
              },
            );
          },
        ),

        const SizedBox(height: 24),

        // Bottom Full-Width Banner: </> Always learning, always building. ~~~~~ >
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: kCardSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: kBorder, width: 1.2),
          ),
          child: Row(
            children: [
              // Dark Cyan Capsule with </>
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF0C1424),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: kCyan.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    '</>',
                    style: GoogleFonts.firaCode(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: kCyan,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),

              Expanded(
                child: Text(
                  'Always learning, always building.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: kTextMuted,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(width: 10),

              // Ambient Waveform Soundwave Graphic
              SizedBox(
                width: 50,
                height: 20,
                child: CustomPaint(
                  painter: _WaveformPainter(
                    color: kCyan.withValues(alpha: 0.7),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Trailing Cyan Arrow
              Icon(Icons.arrow_forward_rounded, size: 17, color: kCyan),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Category Button Pill
// ─────────────────────────────────────────────────────────────────────────────
class _CategoryPillButton extends StatefulWidget {
  final _CategoryDefinition category;
  final bool isSelected;
  final bool isCompact;
  final VoidCallback onTap;

  const _CategoryPillButton({
    required this.category,
    required this.isSelected,
    required this.isCompact,
    required this.onTap,
  });

  @override
  State<_CategoryPillButton> createState() => _CategoryPillButtonState();
}

class _CategoryPillButtonState extends State<_CategoryPillButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.isSelected;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isCompact ? 16 : 18,
            vertical: widget.isCompact ? 10 : 13,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: isSelected
                ? const LinearGradient(
                    colors: [
                      Color(0xFF0284C7),
                      Color(0xFF0091FF),
                      Color(0xFF00D2FF),
                    ],
                    stops: [0.0, 0.45, 1.0],
                  )
                : (_isHovered
                      ? LinearGradient(
                          colors: [
                            const Color(0xFF0F1829),
                            const Color(0xFF131F35),
                          ],
                        )
                      : null),
            color: isSelected || _isHovered ? null : Colors.transparent,
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF38BDF8)
                  : (_isHovered ? const Color(0xFF1E2E48) : Colors.transparent),
              width: 1.2,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF00D2FF).withValues(alpha: 0.35),
                      blurRadius: 18,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: widget.isCompact
                ? MainAxisSize.min
                : MainAxisSize.max,
            children: [
              Icon(
                widget.category.icon,
                size: 17,
                color: isSelected
                    ? Colors.white
                    : (_isHovered
                          ? _SkillsSectionState.kCyan
                          : _SkillsSectionState.kTextSub),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  widget.category.label,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 12.0,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected
                        ? Colors.white
                        : (_isHovered
                              ? Colors.white
                              : _SkillsSectionState.kTextMuted),
                    letterSpacing: 1.1,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!widget.isCompact && isSelected) ...[
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 15,
                  color: Colors.white,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Skill Card Component
// ─────────────────────────────────────────────────────────────────────────────
class _SkillCard extends StatefulWidget {
  final _SkillItem skill;

  const _SkillCard({required this.skill});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final skill = widget.skill;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _isHovered
              ? const Color(0xFF0C1322)
              : _SkillsSectionState.kCardSurface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _isHovered
                ? _SkillsSectionState.kCyan
                : _SkillsSectionState.kBorder,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? _SkillsSectionState.kCyan.withValues(alpha: 0.16)
                  : Colors.black.withValues(alpha: 0.35),
              blurRadius: _isHovered ? 20 : 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Row: Tech Logo Badge + Skill Name + Circular Percentage Gauge
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon Badge
                _TechIconBadge(techType: skill.techType),
                const SizedBox(width: 14),

                // Skill Name
                Expanded(
                  child: Text(
                    skill.name,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                      color: _SkillsSectionState.kTextWhite,
                      letterSpacing: 1.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // Circular Progress Gauge (e.g. 95%)
                _CircularPercentageIndicator(
                  percentage: skill.level,
                  isHovered: _isHovered,
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Middle: Detailed Description
            Expanded(
              child: Text(
                skill.description,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.0,
                  color: _SkillsSectionState.kTextMuted,
                  height: 1.48,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(height: 12),

            // Bottom: Tech Tag Pills
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: skill.tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B1220),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _isHovered
                          ? _SkillsSectionState.kCyan.withValues(alpha: 0.25)
                          : const Color(0xFF162338),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tag,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 9.0,
                      fontWeight: FontWeight.w700,
                      color: _SkillsSectionState.kTextSub,
                      letterSpacing: 0.8,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Circular Percentage Gauge (e.g. 95%)
// ─────────────────────────────────────────────────────────────────────────────
class _CircularPercentageIndicator extends StatelessWidget {
  final double percentage;
  final bool isHovered;

  const _CircularPercentageIndicator({
    required this.percentage,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    const size = 38.0;
    final pctInt = (percentage * 100).toInt();

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background dark ring
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: 2.8,
              valueColor: const AlwaysStoppedAnimation(Color(0xFF131D2E)),
            ),
          ),
          // Active Cyan Progress Arc
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: percentage,
              strokeWidth: 2.8,
              strokeCap: StrokeCap.round,
              valueColor: AlwaysStoppedAnimation(
                isHovered ? _SkillsSectionState.kCyan : const Color(0xFF00A3FF),
              ),
            ),
          ),
          // Percentage Text
          Text(
            '$pctInt%',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tech Icon Badge with distinctive logos/glyphs
// ─────────────────────────────────────────────────────────────────────────────
class _TechIconBadge extends StatelessWidget {
  final _TechType techType;

  const _TechIconBadge({required this.techType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFF0E1626),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1B283E), width: 1.2),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 8),
        ],
      ),
      child: Center(child: _buildIconContent()),
    );
  }

  Widget _buildIconContent() {
    switch (techType) {
      case _TechType.dart:
        return const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Color(0xFF00D2FF),
          size: 19,
        );
      case _TechType.sql:
        return const Icon(
          Icons.storage_rounded,
          color: Color(0xFF38BDF8),
          size: 21,
        );
      case _TechType.cpp:
        return Text(
          'C++',
          style: GoogleFonts.firaCode(
            color: const Color(0xFF60A5FA),
            fontWeight: FontWeight.w900,
            fontSize: 13,
          ),
        );
      case _TechType.c:
        return Text(
          'C',
          style: GoogleFonts.firaCode(
            color: const Color(0xFF38BDF8),
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        );
      case _TechType.java:
        return const Icon(
          Icons.coffee_rounded,
          color: Color(0xFFF59E0B),
          size: 21,
        );
      case _TechType.python:
        return const Icon(
          Icons.code_rounded,
          color: Color(0xFFFCD34D),
          size: 21,
        );
      case _TechType.flutter:
        return const Icon(
          Icons.flutter_dash_rounded,
          color: Color(0xFF00D2FF),
          size: 22,
        );
      case _TechType.android:
        return const Icon(
          Icons.android_rounded,
          color: Color(0xFF34D399),
          size: 21,
        );
      case _TechType.crossPlatform:
        return const Icon(
          Icons.devices_rounded,
          color: Color(0xFF38BDF8),
          size: 20,
        );
      case _TechType.ios:
        return const Icon(Icons.apple_rounded, color: Colors.white, size: 21);
      case _TechType.cleanArch:
        return const Icon(
          Icons.layers_rounded,
          color: Color(0xFF00D2FF),
          size: 21,
        );
      case _TechType.mvvm:
        return const Icon(
          Icons.view_quilt_rounded,
          color: Color(0xFF60A5FA),
          size: 20,
        );
      case _TechType.repoPattern:
        return const Icon(
          Icons.hub_rounded,
          color: Color(0xFF38BDF8),
          size: 20,
        );
      case _TechType.modular:
        return const Icon(
          Icons.all_inbox_rounded,
          color: Color(0xFF34D399),
          size: 20,
        );
      case _TechType.riverpod:
        return const Icon(
          Icons.water_drop_rounded,
          color: Color(0xFF00D2FF),
          size: 20,
        );
      case _TechType.bloc:
        return const Icon(
          Icons.all_inclusive_rounded,
          color: Color(0xFF38BDF8),
          size: 20,
        );
      case _TechType.provider:
        return const Icon(
          Icons.bolt_rounded,
          color: Color(0xFFF59E0B),
          size: 21,
        );
      case _TechType.getx:
        return const Icon(
          Icons.flash_on_rounded,
          color: Color(0xFFEF4444),
          size: 21,
        );
      case _TechType.rest:
        return const Icon(
          Icons.swap_horiz_rounded,
          color: Color(0xFF34D399),
          size: 21,
        );
      case _TechType.jwt:
        return const Icon(
          Icons.shield_outlined,
          color: Color(0xFF00D2FF),
          size: 20,
        );
      case _TechType.firebase:
        return const Icon(
          Icons.local_fire_department_rounded,
          color: Color(0xFFF59E0B),
          size: 21,
        );
      case _TechType.sockets:
        return const Icon(
          Icons.wifi_tethering_rounded,
          color: Color(0xFF60A5FA),
          size: 20,
        );
      case _TechType.git:
        return const Icon(
          Icons.alt_route_rounded,
          color: Color(0xFFF97316),
          size: 21,
        );
      case _TechType.docker:
        return const Icon(
          Icons.directions_boat_rounded,
          color: Color(0xFF00D2FF),
          size: 20,
        );
      case _TechType.postman:
        return const Icon(
          Icons.send_rounded,
          color: Color(0xFFF97316),
          size: 19,
        );
      case _TechType.ide:
        return const Icon(
          Icons.terminal_rounded,
          color: Color(0xFF38BDF8),
          size: 20,
        );
      case _TechType.antigravity:
        return const Icon(
          Icons.auto_awesome_rounded,
          color: Color(0xFF00D2FF),
          size: 21,
        );
      case _TechType.claude:
        return const Icon(
          Icons.psychology_rounded,
          color: Color(0xFFD97706),
          size: 21,
        );
      case _TechType.copilot:
        return const Icon(
          Icons.smart_toy_outlined,
          color: Color(0xFF60A5FA),
          size: 21,
        );
      case _TechType.cursor:
        return const Icon(
          Icons.navigation_rounded,
          color: Color(0xFF00D2FF),
          size: 20,
        );
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Audio Waveform Painter
// ─────────────────────────────────────────────────────────────────────────────
class _WaveformPainter extends CustomPainter {
  final Color color;

  _WaveformPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final barHeights = [
      0.2,
      0.45,
      0.8,
      0.35,
      0.6,
      0.95,
      0.7,
      0.4,
      0.85,
      0.3,
      0.5,
      0.2,
    ];
    final count = barHeights.length;
    final spacing = size.width / (count - 1);
    final midY = size.height / 2;

    for (int i = 0; i < count; i++) {
      final x = i * spacing;
      final h = (size.height * barHeights[i]) / 2;
      canvas.drawLine(Offset(x, midY - h), Offset(x, midY + h), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WaveformPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Data Models & Enums
// ─────────────────────────────────────────────────────────────────────────────
enum _TechType {
  dart,
  sql,
  cpp,
  c,
  java,
  python,
  flutter,
  android,
  crossPlatform,
  ios,
  cleanArch,
  mvvm,
  repoPattern,
  modular,
  riverpod,
  bloc,
  provider,
  getx,
  rest,
  jwt,
  firebase,
  sockets,
  git,
  docker,
  postman,
  ide,
  antigravity,
  claude,
  copilot,
  cursor,
}

class _CategoryDefinition {
  final String id;
  final String label;
  final String headerTitle;
  final IconData icon;
  final String countLabel;

  const _CategoryDefinition({
    required this.id,
    required this.label,
    required this.headerTitle,
    required this.icon,
    required this.countLabel,
  });
}

class _SkillItem {
  final String name;
  final double level;
  final String description;
  final List<String> tags;
  final _TechType techType;

  const _SkillItem({
    required this.name,
    required this.level,
    required this.description,
    required this.tags,
    required this.techType,
  });
}
