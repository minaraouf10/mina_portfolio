import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme/app_text_styles.dart';
import '../data/portfolio_data.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final secondaryTextColor =
        isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF070A10) : const Color(0xFFF1F5F9),
        border: Border(
          top: BorderSide(
            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _FooterSocialIcon(
                icon: 'assets/icons/github_icon.svg',
                url: PortfolioData.githubUrl,
                tooltip: 'GitHub',
              ),
              const SizedBox(width: 16),
              _FooterSocialIcon(
                icon: 'assets/icons/linkedin_icon.svg',
                url: PortfolioData.linkedinUrl,
                tooltip: 'LinkedIn',
              ),
              const SizedBox(width: 16),
              _FooterSocialIcon(
                icon: 'assets/icons/gmail_icon.svg',
                url: 'mailto:${PortfolioData.email}',
                tooltip: 'Email',
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '© ${DateTime.now().year} ${PortfolioData.name}. All Rights Reserved.',
            style: AppTextStyles.caption(secondaryTextColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Built with Flutter Web · Responsive · Modern Glassmorphism',
            style: AppTextStyles.caption(secondaryTextColor.withValues(alpha: 0.7)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FooterSocialIcon extends StatefulWidget {
  final String icon;
  final String url;
  final String tooltip;

  const _FooterSocialIcon({
    required this.icon,
    required this.url,
    required this.tooltip,
  });

  @override
  State<_FooterSocialIcon> createState() => _FooterSocialIconState();
}

class _FooterSocialIconState extends State<_FooterSocialIcon> {
  bool _isHovered = false;

  Future<void> _launchUrl() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final defaultColor = isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8);
    final activeColor = theme.colorScheme.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launchUrl,
        child: Tooltip(
          message: widget.tooltip,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _isHovered
                  ? theme.colorScheme.primary.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              widget.icon,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                _isHovered ? activeColor : defaultColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
