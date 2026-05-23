import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme/app_text_styles.dart';
import '../data/portfolio_data.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

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
              IconButton(
                icon: const Icon(Icons.code),
                onPressed: () => _launchUrl(PortfolioData.githubUrl),
                tooltip: 'GitHub',
              ),
              IconButton(
                icon: const Icon(Icons.business_center),
                onPressed: () => _launchUrl(PortfolioData.linkedinUrl),
                tooltip: 'LinkedIn',
              ),
              IconButton(
                icon: const Icon(Icons.email),
                onPressed: () => _launchUrl('mailto:${PortfolioData.email}'),
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
