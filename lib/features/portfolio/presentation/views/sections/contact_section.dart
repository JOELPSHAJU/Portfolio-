import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/portfolio_controller.dart';
import 'package:clean_riverpod_template/core/theme/app_colors.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';
import 'package:clean_riverpod_template/core/widgets/fade_in_slide.dart';
import 'package:clean_riverpod_template/core/widgets/hover_animated_text.dart';

class ContactSection extends ConsumerStatefulWidget {
  const ContactSection({super.key});
  @override
  ConsumerState<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends ConsumerState<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isHoveringSubmit = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final success = await ref
          .read(portfolioControllerProvider.notifier)
          .sendInquiry(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            message: _messageController.text.trim(),
          );

      if (success) {
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1024;
    final isTablet = size.width >= 768 && size.width < 1024;
    final sidePadding = isDesktop
        ? size.width * 0.08
        : (isTablet ? 40.0 : 24.0);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pal = context.palette;
    final portfolioState = ref.watch(portfolioControllerProvider).value;
    final status = portfolioState?.contactStatus ?? ContactFormStatus.idle;

    return Container(
      color: pal.surface,
      width: double.infinity,
      child: Stack(
        children: [
          // Background Matrix / Kinetic Typography
          Positioned(
            bottom: 40,
            right: 10,
            child: Text(
              'COMM_LINK',
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
              vertical: 140.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInSlide(direction: 15.0, child: _buildEditorialHeader(pal)),
                const SizedBox(height: 80),
                isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: FadeInSlide(
                              delay: const Duration(milliseconds: 100),
                              direction: 15.0,
                              child: _buildFormCard(context, status, isDark),
                            ),
                          ),
                          const SizedBox(width: 80),
                          Expanded(
                            flex: 4,
                            child: FadeInSlide(
                              delay: const Duration(milliseconds: 200),
                              direction: 15.0,
                              child: _buildContactDetailsCard(context, isDark),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInSlide(
                            delay: const Duration(milliseconds: 100),
                            direction: 15.0,
                            child: _buildFormCard(context, status, isDark),
                          ),
                          const SizedBox(height: 80),
                          FadeInSlide(
                            delay: const Duration(milliseconds: 200),
                            direction: 15.0,
                            child: _buildContactDetailsCard(context, isDark),
                          ),
                        ],
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
                '04 / CONTACT_SYS',
                style: GoogleFonts.spaceMono(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: BrandColors.warmBrown,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 16),
              HoverAnimatedText(
                text: 'CONTACT ME.\nLET\'S BUILD THE FUTURE.',
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

  Widget _buildFormCard(
    BuildContext context,
    ContactFormStatus status,
    bool isDark,
  ) {
    final pal = context.palette;
    final isSubmitting = status == ContactFormStatus.submitting;
    final isSuccess = status == ContactFormStatus.success;

    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: pal.card.withValues(alpha: 0.3),
        border: Border(
          left: const BorderSide(color: BrandColors.warmBrown, width: 4),
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              '// DIRECT_MESSAGE',
              style: GoogleFonts.spaceMono(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: pal.textPrimary.withValues(alpha: 0.4),
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 32),
            _buildTextField(
              context: context,
              controller: _nameController,
              label: 'FULL NAME',
              hint: 'John Doe',
              isDark: isDark,
              validator: (val) =>
                  (val == null || val.trim().isEmpty) ? 'REQUIRED_FIELD' : null,
            ),
            const SizedBox(height: 24),
            _buildTextField(
              context: context,
              controller: _emailController,
              label: 'EMAIL ADDRESS',
              hint: 'john@example.com',
              isDark: isDark,
              keyboardType: TextInputType.emailAddress,
              validator: (val) {
                if (val == null || val.trim().isEmpty) return 'REQUIRED_FIELD';
                if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(val.trim()))
                  return 'INVALID_FORMAT';
                return null;
              },
            ),
            const SizedBox(height: 24),
            _buildTextField(
              context: context,
              controller: _messageController,
              label: 'MESSAGE',
              hint: 'Describe the project requirements...',
              isDark: isDark,
              maxLines: 5,
              validator: (val) =>
                  (val == null || val.trim().isEmpty) ? 'REQUIRED_FIELD' : null,
            ),
            const SizedBox(height: 40),

            if (isSuccess)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: BrandColors.warmBrown.withValues(alpha: 0.10),
                  border: Border.all(
                    color: BrandColors.warmBrown.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle_outline_rounded,
                      color: BrandColors.warmBrown,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'TRANSMISSION_SUCCESSFUL',
                      style: GoogleFonts.spaceMono(
                        color: BrandColors.warmBrown,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              )
            else
              MouseRegion(
                onEnter: (_) => setState(() => _isHoveringSubmit = true),
                onExit: (_) => setState(() => _isHoveringSubmit = false),
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: isSubmitting ? null : _submitForm,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      gradient: _isHoveringSubmit
                          ? LinearGradient(
                              colors: isDark
                                  ? [
                                      const Color(0xFF00E5FF),
                                      const Color(0xFF007AFF),
                                    ]
                                  : [
                                      const Color(0xFF0F172A),
                                      const Color(0xFF334155),
                                    ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      color: _isHoveringSubmit ? null : Colors.transparent,
                      border: _isHoveringSubmit
                          ? null
                          : Border.all(
                              color: isDark
                                  ? const Color(0xFF00E5FF)
                                  : const Color(0xFF0F172A),
                              width: 2,
                            ),
                    ),
                    child: Center(
                      child: Text(
                        isSubmitting ? 'SENDING MESSAGE...' : 'SUBMIT MESSAGE',
                        style: GoogleFonts.spaceMono(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _isHoveringSubmit
                              ? Colors.white
                              : (isDark
                                    ? const Color(0xFF00E5FF)
                                    : const Color(0xFF0F172A)),
                          letterSpacing: 2,
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

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isDark,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    final pal = context.palette;
    final fillColor = Colors.transparent;
    final bdrNormal = pal.textPrimary.withValues(alpha: 0.2);
    final bdrFocused = BrandColors.warmBrown;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.spaceMono(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: pal.textPrimary.withValues(alpha: 0.6),
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: GoogleFonts.outfit(
            color: pal.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          cursorColor: BrandColors.warmBrown,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.outfit(
              color: pal.textPrimary.withValues(alpha: 0.3),
              fontSize: 16,
            ),
            filled: true,
            fillColor: fillColor,
            contentPadding: const EdgeInsets.all(20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: bdrNormal, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: bdrNormal, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: bdrFocused, width: 2),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.redAccent, width: 1),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.redAccent, width: 2),
            ),
            errorStyle: GoogleFonts.spaceMono(
              color: Colors.redAccent,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactDetailsCard(BuildContext context, bool isDark) {
    final pal = context.palette;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// NODE_ENDPOINTS',
          style: GoogleFonts.spaceMono(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: pal.textPrimary.withValues(alpha: 0.4),
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 32),
        const _ContactImageHover(),
        const SizedBox(height: 40),
        _buildInfoNode(
          context: context,
          title: 'EMAIL_SECURE_LINE',
          value: 'joelpshaju@gmail.com',
          onTap: () => _launchURL('mailto:joelpshaju@gmail.com'),
        ),
        _buildInfoNode(
          context: context,
          title: 'DIRECT_AUDIO_LINK',
          value: '+91 8590182736',
          onTap: () => _launchURL('tel:+918590182736'),
        ),
        _buildInfoNode(
          context: context,
          title: 'PROFESSIONAL_LEDGER',
          value: 'LINKEDIN_PROFILE',
          onTap: () =>
              _launchURL('https://www.linkedin.com/in/joel-p-shaju-b8aa1a292'),
        ),
        _buildInfoNode(
          context: context,
          title: 'SOURCE_CODE_VAULT',
          value: 'GITHUB_REPOSITORY',
          onTap: () => _launchURL('https://github.com/joelpshaju'),
        ),
      ],
    );
  }

  Widget _buildInfoNode({
    required BuildContext context,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    final pal = context.palette;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 24),
          padding: const EdgeInsets.only(left: 24),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: BrandColors.warmBrown.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.spaceMono(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: pal.textPrimary.withValues(alpha: 0.5),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  HoverAnimatedText(
                    text: value,
                    style: GoogleFonts.anton(
                      fontSize: 24,
                      color: pal.textPrimary,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    Icons.arrow_outward_rounded,
                    color: BrandColors.warmBrown,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Contact Image Hover Effect ──────────────────────────────────────────────
class _ContactImageHover extends StatefulWidget {
  const _ContactImageHover();

  @override
  State<_ContactImageHover> createState() => _ContactImageHoverState();
}

class _ContactImageHoverState extends State<_ContactImageHover> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: context.palette.textPrimary.withValues(alpha: 0.2),
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedScale(
                duration: const Duration(milliseconds: 400),
                scale: _hovered ? 1.05 : 1.0,
                curve: Curves.easeOutCubic,
                child: Image.asset(
                  'assets/joel_bw.jpg',
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, -0.2),
                ),
              ),
            ),
            // Interactive dark/brand color gradient sweep
            Positioned.fill(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      BrandColors.warmBrown.withValues(
                        alpha: _hovered ? 0.2 : 0.0,
                      ),
                      context.palette.surface.withValues(
                        alpha: _hovered ? 0.8 : 0.4,
                      ),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
