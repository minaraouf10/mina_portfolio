import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/responsive_util.dart';
import '../../data/portfolio_data.dart';
import '../../widgets/section_header.dart';
import '../hero/hero_section.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    int crossAxisCount = 3;
    if (isMobile) {
      crossAxisCount = 1;
    } else if (isTablet) {
      crossAxisCount = 2;
    }

    return VisibilityDetector(
      key: const Key('projects-section-key'),
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
                    title: 'Featured Projects',
                    subtitle: 'A selection of some digital products I built recently.',
                  ),
                  const SizedBox(height: 20),
                  // Project cards list
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      mainAxisExtent: 480,
                    ),
                    itemCount: PortfolioData.projects.length,
                    itemBuilder: (context, index) {
                      return _ProjectCard(project: PortfolioData.projects[index]);
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

class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;
  late final PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) return;
      final imageAssets = widget.project['imageAssets'] as List<String>;
      if (imageAssets.length <= 1) return;

      int nextPage = _currentPage + 1;
      if (nextPage >= imageAssets.length) {
        nextPage = 0;
      }

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void _stopAutoPlay() {
    _timer?.cancel();
  }

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

    final title = widget.project['title'] as String;
    final description = widget.project['description'] as String;
    final tech = widget.project['tech'] as List<String>;
    final url = widget.project['url'] as String;
    final imageAssets = widget.project['imageAssets'] as List<String>;

    final cardBg = isDark ? const Color(0xFF161B2E) : Colors.white;
    final cardBorder = isDark ? const Color(0xFF2E3B52) : const Color(0xFFE2E8F0);
    final textPrimaryColor = isDark ? Colors.white : const Color(0xFF1E293B);
    final textSecondaryColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _stopAutoPlay();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _startAutoPlay();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        transform: _isHovered
            ? Matrix4.translationValues(0, -8, 0)
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
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image carousel with loading/error handling
              SizedBox(
                height: 180,
                width: double.infinity,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemCount: imageAssets.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierColor: Colors.black.withValues(alpha: 0.85),
                              builder: (context) => _FullScreenImageViewer(
                                images: imageAssets,
                                initialPage: index,
                              ),
                            );
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Image.asset(
                              imageAssets[index],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        theme.colorScheme.primary.withValues(alpha: 0.8),
                                        theme.colorScheme.secondary.withValues(alpha: 0.3),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.computer,
                                      size: 48,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    if (imageAssets.length > 1) ...[
                      // Left arrow
                      Positioned(
                        left: 8,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: _isHovered ? 1.0 : 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.4),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.chevron_left, color: Colors.white, size: 20),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                onPressed: () {
                                  int prevPage = _currentPage - 1;
                                  if (prevPage < 0) {
                                    prevPage = imageAssets.length - 1;
                                  }
                                  _pageController.animateToPage(
                                    prevPage,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Right arrow
                      Positioned(
                        right: 8,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: _isHovered ? 1.0 : 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.4),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.chevron_right, color: Colors.white, size: 20),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                onPressed: () {
                                  int nextPage = _currentPage + 1;
                                  if (nextPage >= imageAssets.length) {
                                    nextPage = 0;
                                  }
                                  _pageController.animateToPage(
                                    nextPage,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Indicators
                      Positioned(
                        bottom: 8,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            imageAssets.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              width: _currentPage == index ? 16 : 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: _currentPage == index
                                    ? theme.colorScheme.primary
                                    : Colors.white.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Body
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tech Tags
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: tech.map((tag) {
                            return Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                tag,
                                style: AppTextStyles.caption(theme.colorScheme.primary).copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Title
                      Text(
                        title,
                        style: AppTextStyles.cardTitle(textPrimaryColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      // Description
                      Expanded(
                        child: Text(
                          description,
                          style: AppTextStyles.body(textSecondaryColor).copyWith(fontSize: 13),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Action Link Button
                      Row(
                        children: [
                          TextButton(
                            onPressed: () => _launchUrl(url),
                            style: TextButton.styleFrom(
                              foregroundColor: theme.colorScheme.primary,
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(50, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Row(
                              children: [
                                Text('View Project', style: AppTextStyles.label(theme.colorScheme.primary).copyWith(fontSize: 13)),
                                const SizedBox(width: 4),
                                const Icon(Icons.arrow_outward, size: 14),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
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

class _FullScreenImageViewer extends StatefulWidget {
  final List<String> images;
  final int initialPage;

  const _FullScreenImageViewer({
    required this.images,
    required this.initialPage,
  });

  @override
  State<_FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<_FullScreenImageViewer> {
  late final PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Semi-transparent background that closes dialog on tap
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: Colors.black.withValues(alpha: 0.85),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Image viewer
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900, maxHeight: 600),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  color: Colors.black,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: widget.images.length,
                    itemBuilder: (context, index) {
                      return InteractiveViewer(
                        panEnabled: true,
                        boundaryMargin: const EdgeInsets.all(20),
                        minScale: 0.5,
                        maxScale: 4.0,
                        child: Image.asset(
                          widget.images[index],
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          // Close button at top right
          Positioned(
            top: 20,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.black.withValues(alpha: 0.5),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          // Left chevron button
          if (widget.images.length > 1)
            Positioned(
              left: 24,
              child: CircleAvatar(
                backgroundColor: Colors.black.withValues(alpha: 0.5),
                radius: 24,
                child: IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
                  onPressed: () {
                    int prevPage = _currentPage - 1;
                    if (prevPage < 0) {
                      prevPage = widget.images.length - 1;
                    }
                    _pageController.animateToPage(
                      prevPage,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
          // Right chevron button
          if (widget.images.length > 1)
            Positioned(
              right: 24,
              child: CircleAvatar(
                backgroundColor: Colors.black.withValues(alpha: 0.5),
                radius: 24,
                child: IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.white, size: 28),
                  onPressed: () {
                    int nextPage = _currentPage + 1;
                    if (nextPage >= widget.images.length) {
                      nextPage = 0;
                    }
                    _pageController.animateToPage(
                      nextPage,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
          // Indicators
          if (widget.images.length > 1)
            Positioned(
              bottom: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.images.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 12 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? Colors.white : Colors.white.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
