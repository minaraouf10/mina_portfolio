import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/responsive_util.dart';
import '../../data/portfolio_data.dart';
import '../../widgets/section_header.dart';
import '../hero/hero_section.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    // final theme = Theme.of(context);
    // final isDark = theme.brightness == Brightness.dark;

    return VisibilityDetector(
      key: const Key('skills-section-key'),
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
                    title: 'My Skills',
                    subtitle: 'Technologies, programming languages, and engineering concepts I work with.',
                  ),
                  const SizedBox(height: 20),
                  // Responsive Grid
                  isMobile
                      ? Column(
                          children: PortfolioData.skillCategories.map((category) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: _SkillCategoryCard(category: category),
                            );
                          }).toList(),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 24,
                            mainAxisExtent: 220,
                          ),
                          itemCount: PortfolioData.skillCategories.length,
                          itemBuilder: (context, index) {
                            return _SkillCategoryCard(
                              category: PortfolioData.skillCategories[index],
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

class _SkillCategoryCard extends StatefulWidget {
  final Map<String, dynamic> category;

  const _SkillCategoryCard({required this.category});

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final title = widget.category['category'] as String;
    final skills = widget.category['skills'] as List<String>;

    final cardBg = isDark
        ? const Color(0xFF161B2E).withValues(alpha: 0.5)
        : Colors.white;
    final cardBorder = isDark
        ? const Color(0xFF2E3B52).withValues(alpha: 0.6)
        : const Color(0xFFE2E8F0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(28),
        transform: _isHovered
            ? (Matrix4.identity()..translate(0, -6, 0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? theme.colorScheme.primary.withValues(alpha: 0.5) : cardBorder,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? theme.colorScheme.primary.withValues(alpha: 0.08)
                  : Colors.transparent,
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: AppTextStyles.cardTitle(isDark ? Colors.white : const Color(0xFF1E293B)),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: skills.map((skill) {
                    return _SkillChip(label: skill);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String label;

  const _SkillChip({required this.label});

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final defaultChipBg = isDark
        ? const Color(0xFF0F172A)
        : const Color(0xFFF1F5F9);
    final activeChipBg = theme.colorScheme.primary.withValues(alpha: 0.15);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _isHovered ? activeChipBg : defaultChipBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _isHovered
                ? theme.colorScheme.primary
                : (isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
            width: 1,
          ),
        ),
        child: Text(
          widget.label,
          style: AppTextStyles.caption(
            _isHovered
                ? theme.colorScheme.primary
                : (isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569)),
          ).copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
