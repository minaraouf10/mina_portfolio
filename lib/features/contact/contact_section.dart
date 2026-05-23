import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/responsive_util.dart';
import '../../data/portfolio_data.dart';
import '../../widgets/section_header.dart';
import '../hero/hero_section.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _isVisible = false;
  bool _copied = false;

  Future<void> _launchMail() async {
    final uri = Uri.parse('mailto:${PortfolioData.email}?subject=Collaboration%20Inquiry');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _copyEmail() {
    Clipboard.setData(const ClipboardData(text: PortfolioData.email));
    setState(() => _copied = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Email copied to clipboard!'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _copied = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardBg = isDark ? const Color(0xFF161B2E) : Colors.white;
    final cardBorder = isDark ? const Color(0xFF2E3B52) : const Color(0xFFE2E8F0);
    final textPrimaryColor = isDark ? Colors.white : const Color(0xFF1E293B);
    final textSecondaryColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    return VisibilityDetector(
      key: const Key('contact-section-key'),
      onVisibilityChanged: (visibilityInfo) {
        final visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 15 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 600),
        opacity: _isVisible ? 1.0 : 0.0,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 600),
          offset: _isVisible ? Offset.zero : const Offset(0.0, 0.05),
          curve: Curves.easeOutCubic,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 80,
              horizontal: Responsive.sectionPadding(context),
            ),
            child: MaxWidthContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: 'Get In Touch',
                    subtitle: 'I\'m currently open to new opportunities, freelance work, or collaborations.',
                  ),
                  const SizedBox(height: 20),
                  // Contact Card Design
                  Center(
                    child: Container(
                    //  maxWidth: 800,
                      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: cardBorder, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withValues(alpha: 0.04),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.mail_outline_rounded,
                            size: 64,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Let\'s build something together!',
                            style: AppTextStyles.cardTitle(textPrimaryColor).copyWith(
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Whether you want to discuss a potential project, hire me for your development team, or just say hello, my inbox is always open. I\'ll do my best to get back to you as soon as possible!',
                            style: AppTextStyles.body(textSecondaryColor),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 36),
                          // Email copy block
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: _copyEmail,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                decoration: BoxDecoration(
                                  color: isDark ? const Color(0xFF0D1117) : const Color(0xFFF8F9FA),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isDark ? const Color(0xFF2E3B52) : const Color(0xFFE2E8F0),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.email,
                                      size: 18,
                                      color: theme.colorScheme.primary,
                                    ),
                                    const SizedBox(width: 12),
                                    SelectableText(
                                      PortfolioData.email,
                                      style: AppTextStyles.label(textPrimaryColor).copyWith(
                                        fontFamily: 'monospace',
                                        fontSize: 14,
                                      ),
                                      onTap: _copyEmail,
                                    ),
                                    const SizedBox(width: 12),
                                    Icon(
                                      _copied ? Icons.check : Icons.copy,
                                      size: 16,
                                      color: _copied ? Colors.green : textSecondaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          // Action email button
                          ElevatedButton(
                            onPressed: _launchMail,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: isDark ? Colors.black : Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 22),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.send_rounded, size: 18),
                                const SizedBox(width: 10),
                                Text(
                                  'Send Email Message',
                                  style: AppTextStyles.label(isDark ? Colors.black : Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
