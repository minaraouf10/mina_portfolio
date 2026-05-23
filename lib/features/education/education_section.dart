import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/responsive_util.dart';
import '../../data/portfolio_data.dart';
import '../../widgets/section_header.dart';
import '../hero/hero_section.dart';

class EducationSection extends StatefulWidget {
  const EducationSection({super.key});

  @override
  State<EducationSection> createState() => _EducationSectionState();
}

class _EducationSectionState extends State<EducationSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
   // final isDark = theme.brightness == Brightness.dark;

    return VisibilityDetector(
      key: const Key('education-section-key'),
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
                    title: 'Education',
                    subtitle: 'Academic background and certifications.',
                  ),
                  const SizedBox(height: 20),
                  // List of Education Cards
                  Column(
                    children: PortfolioData.education.map((edu) {
                      return _EducationCard(edu: edu);
                    }).toList(),
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

class _EducationCard extends StatefulWidget {
  final Map<String, dynamic> edu;

  const _EducationCard({required this.edu});

  @override
  State<_EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<_EducationCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final degree = widget.edu['degree'] as String;
    final institution = widget.edu['institution'] as String;
    final period = widget.edu['period'] as String;
    final gpa = widget.edu['gpa'] as String?;

    final textPrimaryColor = isDark ? Colors.white : const Color(0xFF1E293B);
    final textSecondaryColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
    final cardBg = isDark ? const Color(0xFF161B2E).withValues(alpha: 0.4) : Colors.white;
    final cardBorder = isDark ? const Color(0xFF2E3B52).withValues(alpha: 0.6) : const Color(0xFFE2E8F0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(28),
        transform: _isHovered
            ? (Matrix4.identity()..translate(4, 0, 0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: cardBorder, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? theme.colorScheme.primary.withValues(alpha: 0.05)
                  : Colors.transparent,
              blurRadius: 20,
              offset: const Offset(4, 0),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Decorative left accent bar
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 5,
                decoration: BoxDecoration(
                  color: _isHovered ? theme.colorScheme.primary : theme.colorScheme.primary.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
              const SizedBox(width: 24),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Institution & Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            institution,
                            style: AppTextStyles.label(theme.colorScheme.primary),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          period,
                          style: AppTextStyles.caption(textSecondaryColor).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Degree title
                    Text(
                      degree,
                      style: AppTextStyles.cardTitle(textPrimaryColor),
                    ),
                    if (gpa != null) ...[
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.grade, size: 16, color: theme.colorScheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            'GPA: $gpa',
                            style: AppTextStyles.body(textSecondaryColor).copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
