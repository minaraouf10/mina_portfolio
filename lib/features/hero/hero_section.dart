import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/responsive_util.dart';
import '../../data/portfolio_data.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onContactTap;

  const HeroSection({
    super.key,
    required this.onContactTap,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
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
    final isMobile = Responsive.isMobile(context);
    final size = MediaQuery.of(context).size;

    final primaryTextColor = isDark ? Colors.white : const Color(0xFF1E293B);
    final secondaryTextColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    final leftColumn = Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Welcome badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon(
              //   Icons.emoji_people,
              //   size: 16,
              //   color: theme.colorScheme.primary,
              // ),
              // const SizedBox(width: 8),
              Text(
                'WELCOME TO MY PORTFOLIO',
                style: AppTextStyles.label(theme.colorScheme.primary).copyWith(
                  letterSpacing: 1.5,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Name
        SelectableText.rich(
          TextSpan(
            children: [
              TextSpan(text: "Hi, I'm ", style: AppTextStyles.heroName(primaryTextColor)),
              TextSpan(
                text: PortfolioData.name,
                style: AppTextStyles.heroName(theme.colorScheme.primary),
              ),
            ],
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 12),
        // Title
        Text(
          PortfolioData.title,
          style: AppTextStyles.heroTitle(secondaryTextColor),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 24),
        // Bio
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            PortfolioData.bio,
            style: AppTextStyles.body(secondaryTextColor),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ),
        const SizedBox(height: 36),
        // Buttons
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton(
              onPressed: widget.onContactTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: isDark ? Colors.black : Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Let\'s Talk', style: AppTextStyles.label(isDark ? Colors.black : Colors.white)),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 16),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () => _launchUrl(PortfolioData.githubUrl),
              style: OutlinedButton.styleFrom(
                foregroundColor: primaryTextColor,
                side: BorderSide(color: isDark ? const Color(0xFF2E3B52) : const Color(0xFFCBD5E1), width: 1.5),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.code, size: 16),
                  const SizedBox(width: 8),
                  Text('View CV', style: AppTextStyles.label(primaryTextColor)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        // Social icons
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            _SocialIcon(
              icon: 'assets/icons/github_icon.svg',
              url: PortfolioData.githubUrl,
              tooltip: 'GitHub',
            ),
            const SizedBox(width: 16),
            _SocialIcon(
              icon: 'assets/icons/linkedin_icon.svg',
              url: PortfolioData.linkedinUrl,
              tooltip: 'LinkedIn',
            ),
            const SizedBox(width: 16),
            _SocialIcon(
              icon: 'assets/icons/gmail_icon.svg',
              url: 'mailto:${PortfolioData.email}',
              tooltip: 'Email',
            ),
          ],
        ),
      ],
    );

    // Avatar image layout
    final avatarCard = Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.15),
                blurRadius: 40,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              color: isDark ? const Color(0xFF161B2E) : Colors.white,
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.asset(
                  PortfolioData.avatarAsset,
                  height: isMobile ? 260 : 360,
                  width: isMobile ? 260 : 360,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback visual design if image fails to load
                    return Container(
                      height: isMobile ? 260 : 360,
                      width: isMobile ? 260 : 360,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.primary,
                            theme.colorScheme.secondary.withValues(alpha: 0.5),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return Container(
      constraints: BoxConstraints(minHeight: size.height - 70), // subtract navbar height
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: Responsive.sectionPadding(context),
      ),
      alignment: Alignment.center,
      child: MaxWidthContainer(
        child: SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: isMobile
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      avatarCard,
                      const SizedBox(height: 48),
                      leftColumn,
                    ],
                  )
                : Row(
                    children: [
                      Expanded(flex: 3, child: leftColumn),
                      const SizedBox(width: 48),
                      Expanded(flex: 2, child: avatarCard),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final String icon;
  final String url;
  final String tooltip;

  const _SocialIcon({
    required this.icon,
    required this.url,
    required this.tooltip,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
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
              border: Border.all(
                color: _isHovered ? theme.colorScheme.primary.withValues(alpha: 0.3) : Colors.transparent,
                width: 1,
              ),
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

class MaxWidthContainer extends StatelessWidget {
  final Widget child;

  const MaxWidthContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: Responsive.contentMaxWidth(context),
        ),
        child: child,
      ),
    );
  }
}
