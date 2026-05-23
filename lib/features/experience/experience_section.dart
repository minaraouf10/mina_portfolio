import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/responsive_util.dart';
import '../../data/portfolio_data.dart';
import '../../widgets/section_header.dart';
import '../hero/hero_section.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final isDark = theme.brightness == Brightness.dark;

    return VisibilityDetector(
      key: const Key('experience-section-key'),
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
              vertical: 60,
              horizontal: Responsive.sectionPadding(context),
            ),
            child: MaxWidthContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: 'Work Experience',
                    subtitle: 'A timeline of my professional journey in software engineering.',
                  ),
                  const SizedBox(height: 20),
                  // Timeline structure
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: PortfolioData.experience.length,
                    itemBuilder: (context, index) {
                      final item = PortfolioData.experience[index];
                      final isLast = index == PortfolioData.experience.length - 1;
                      return _TimelineItem(
                        item: item,
                        isLast: isLast,
                      );
                    },
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

class _TimelineItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool isLast;

  const _TimelineItem({
    required this.item,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final role = item['role'] as String;
    final company = item['company'] as String;
    final period = item['period'] as String;
    final location = item['location'] as String;
    final points = item['points'] as List<String>;

    final textPrimaryColor = isDark ? Colors.white : const Color(0xFF1E293B);
    final textSecondaryColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
    final cardBg = isDark ? const Color(0xFF161B2E).withValues(alpha: 0.4) : Colors.white;
    final cardBorder = isDark ? const Color(0xFF2E3B52).withValues(alpha: 0.6) : const Color(0xFFE2E8F0);

    return Stack(
      children: [
        // Timeline line
        if (!isLast)
          Positioned(
            left: 7, // Center of the 16px indicator (16/2 - 2/2 = 7)
            top: 32, // Starts from the center of the indicator node
            bottom: 0, // Extends to the bottom of the card's container
            child: Container(
              width: 2,
              color: isDark ? const Color(0xFF2E3B52) : const Color(0xFFE2E8F0),
            ),
          ),
        // Timeline node
        Positioned(
          left: 0,
          top: 24, // Aligned with the top section of the content card
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.3),
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.4),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
        ),
        // Content card
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: cardBorder, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date badge & Location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          period,
                          style: AppTextStyles.caption(theme.colorScheme.primary).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 14, color: textSecondaryColor),
                          const SizedBox(width: 4),
                          Text(
                            location,
                            style: AppTextStyles.caption(textSecondaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Role and Company
                  Text(
                    role,
                    style: AppTextStyles.cardTitle(textPrimaryColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    company,
                    style: AppTextStyles.label(theme.colorScheme.primary),
                  ),
                  const SizedBox(height: 16),
                  // Points list
                  ...points.map((pt) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Icon(
                              Icons.circle,
                              size: 6,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              pt,
                              style: AppTextStyles.body(textSecondaryColor).copyWith(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
