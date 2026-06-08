import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/portfolio_controller.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';
import 'package:clean_riverpod_template/core/widgets/glass_container.dart';
import 'package:clean_riverpod_template/core/widgets/premium_button.dart';
import 'package:clean_riverpod_template/core/widgets/gradient_text.dart';
import 'package:clean_riverpod_template/core/widgets/fade_in_slide.dart';


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
      final success = await ref.read(portfolioControllerProvider.notifier).sendInquiry(
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
    final isDesktop = size.width >= 900;
    final portfolioState = ref.watch(portfolioControllerProvider).value;
    final status = portfolioState?.contactStatus ?? ContactFormStatus.idle;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40.0 : 20.0,
        vertical: 30.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          FadeInSlide(
            delay: const Duration(milliseconds: 100),
            direction: 25.0,
            child: _buildSectionHeader('GET IN TOUCH', 'Let\'s Create Something Great'),
          ),
          const SizedBox(height: 24),

          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: FadeInSlide(
                        delay: const Duration(milliseconds: 250),
                        direction: 30.0,
                        child: _buildFormCard(status),
                      ),
                    ),
                    const SizedBox(width: 48),
                    Expanded(
                      flex: 4,
                      child: FadeInSlide(
                        delay: const Duration(milliseconds: 400),
                        direction: 30.0,
                        child: _buildContactDetailsCard(),
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInSlide(
                      delay: const Duration(milliseconds: 250),
                      direction: 30.0,
                      child: _buildFormCard(status),
                    ),
                    const SizedBox(height: 36),
                    FadeInSlide(
                      delay: const Duration(milliseconds: 400),
                      direction: 30.0,
                      child: _buildContactDetailsCard(),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String overtitle, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          overtitle,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: BrandColors.secondaryNeon,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 8),
        GradientText(
          title,
          gradient: BrandColors.primaryGradient,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 60,
          height: 3,
          decoration: BoxDecoration(
            gradient: BrandColors.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildFormCard(ContactFormStatus status) {
    final isSubmitting = status == ContactFormStatus.submitting;
    final isSuccess = status == ContactFormStatus.success;

    return GlassContainer(
      borderRadius: 24.0,
      padding: const EdgeInsets.all(28.0),
      customBorder: Border.all(
        color: BrandColors.primaryNeon.withOpacity(0.18),
        width: 1.5,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Send a Message',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Have a project in mind or want to collaborate? Write me a line.',
              style: TextStyle(fontSize: 13, color: BrandColors.accentNeon),
            ),
            const SizedBox(height: 24),

            // Name Field
            _buildTextField(
              controller: _nameController,
              label: 'Full Name',
              hint: 'John Doe',
              icon: Icons.person_outline_rounded,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Email Field
            _buildTextField(
              controller: _emailController,
              label: 'Email Address',
              hint: 'john@example.com',
              icon: Icons.alternate_email_rounded,
              keyboardType: TextInputType.emailAddress,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val.trim())) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Message Field
            _buildTextField(
              controller: _messageController,
              label: 'Message',
              hint: 'Tell me about your product details...',
              icon: Icons.chat_bubble_outline_rounded,
              maxLines: 5,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Please enter your message';
                }
                return null;
              },
            ),
            const SizedBox(height: 28),

            // Submission controls
            if (isSuccess)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  color: BrandColors.successNeon.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: BrandColors.successNeon.withOpacity(0.3)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_rounded, color: BrandColors.successNeon, size: 20),
                    SizedBox(width: 12),
                    Text(
                      'Message sent successfully! Thank you.',
                      style: TextStyle(
                        color: BrandColors.successNeon,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: PremiumButton(
                      label: isSubmitting ? 'SENDING INQUIRY...' : 'SUBMIT MESSAGE',
                      icon: Icons.send_rounded,
                      gradient: BrandColors.primaryGradient,
                      glowColor: BrandColors.primaryNeon,
                      isLoading: isSubmitting,
                      onPressed: _submitForm,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF3D2410),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(color: const Color(0xFF1A1A1A), fontSize: 14.5),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: const Color(0xFF8C5E28).withOpacity(0.5), fontSize: 14.5),
            prefixIcon: Icon(icon, color: BrandColors.secondaryNeon.withOpacity(0.6), size: 18),
            filled: true,
            fillColor: const Color(0xFF7A5232).withOpacity(0.70),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: BrandColors.glassBorder.withOpacity(0.1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: BrandColors.glassBorder.withOpacity(0.08)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: BrandColors.primaryNeon, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: BrandColors.accentNeon, width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: BrandColors.accentNeon, width: 1.5),
            ),
            errorStyle: const TextStyle(color: BrandColors.accentNeon, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildContactDetailsCard() {
    return Column(
      children: [
        _buildInfoCard(
          icon: Icons.alternate_email_rounded,
          title: 'Email Direct',
          value: 'joelpshaju@gmail.com',
          subtitle: 'Responses within 24 hours',
          accentColor: BrandColors.secondaryNeon,
          onTap: () => _launchURL('mailto:joelpshaju@gmail.com'),
        ),
        const SizedBox(height: 16),
        _buildInfoCard(
          icon: Icons.phone_iphone_rounded,
          title: 'Phone & WhatsApp',
          value: '+91 8590182736',
          subtitle: 'Available for client discussions',
          accentColor: BrandColors.successNeon,
          onTap: () => _launchURL('tel:+918590182736'),
        ),
        const SizedBox(height: 16),
        _buildInfoCard(
          icon: Icons.link_rounded,
          title: 'Professional Networking',
          value: 'LinkedIn Profile',
          subtitle: 'Read reviews and references',
          accentColor: BrandColors.primaryNeon,
          onTap: () => _launchURL('https://linkedin.com'), // Launch linkedin
        ),
        const SizedBox(height: 16),
        _buildInfoCard(
          icon: Icons.terminal_rounded,
          title: 'Open Source Projects',
          value: 'GitHub Hub',
          subtitle: 'Check repository codebase activity',
          accentColor: BrandColors.accentNeon,
          onTap: () => _launchURL('https://github.com/joelpshaju'),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: GlassContainer(
          borderRadius: 20.0,
          padding: const EdgeInsets.all(20.0),
          customBorder: Border.all(
            color: accentColor.withOpacity(0.18),
            width: 1.5,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: accentColor, size: 24),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 12, color: Color(0xFF8C5E28), fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: const TextStyle(fontSize: 16, color: const Color(0xFF1A1A1A), fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 11, color: const Color(0xFF7A5232).withOpacity(0.70)),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_outward_rounded, color: const Color(0xFF7A5232).withOpacity(0.70), size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
