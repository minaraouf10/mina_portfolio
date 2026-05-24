import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/theme_provider.dart';
import '../core/theme/app_text_styles.dart';
import '../core/utils/responsive_util.dart';
import '../data/portfolio_data.dart';

class NavBar extends StatefulWidget implements PreferredSizeWidget {
  final ScrollController scrollController;
  final Function(int) onNavItemTap;
  final List<String> navItems;

  const NavBar({
    super.key,
    required this.scrollController,
    required this.onNavItemTap,
    required this.navItems,
  });

  @override
  State<NavBar> createState() => _NavBarState();

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class _NavBarState extends State<NavBar> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (widget.scrollController.hasClients) {
      final offset = widget.scrollController.offset;
      if (offset > 20 && !_isScrolled) {
        setState(() => _isScrolled = true);
      } else if (offset <= 20 && _isScrolled) {
        setState(() => _isScrolled = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    final backgroundColor = _isScrolled
        ? (isDark
            ? const Color(0xFF0D1117).withValues(alpha: 0.7)
            : const Color(0xFFFAF9F6).withValues(alpha: 0.7))
        : Colors.transparent;

    final borderBottomColor = _isScrolled
        ? (isDark ? const Color(0xFF2E3B52) : const Color(0xFFE2E8F0))
        : Colors.transparent;

    final showDrawer = !Responsive.isDesktop(context);

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _isScrolled ? 10 : 0, sigmaY: _isScrolled ? 10 : 0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 70,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border(
              bottom: BorderSide(color: borderBottomColor, width: _isScrolled ? 1.0 : 0.0),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.sectionPadding(context),
          ),
          child: Row(
            children: [
              // Logo/Brand Name
              GestureDetector(
                onTap: () => widget.onNavItemTap(0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Row(
                    children: [
                      Text(
                        PortfolioData.name,
                        style: AppTextStyles.cardTitle(
                          isDark ? Colors.white : const Color(0xFF1E293B),
                        ).copyWith(letterSpacing: -0.5),
                      ),
                      Text(
                        '.',
                        style: AppTextStyles.cardTitle(theme.colorScheme.primary),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              // Navigation Items
              if (!showDrawer) ...[
                ...List.generate(widget.navItems.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _NavBarLink(
                      label: widget.navItems[index],
                      onTap: () => widget.onNavItemTap(index),
                    ),
                  );
                }),
                const SizedBox(width: 8),
              ],
              // Theme Switcher Button
              IconButton(
                onPressed: themeProvider.toggle,
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: isDark ? Colors.white : const Color(0xFF1E293B),
                ),
                tooltip: 'Toggle Theme',
              ),
              // Drawer Trigger Button
              if (showDrawer) ...[
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: isDark ? Colors.white : const Color(0xFF1E293B),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavBarLink({
    required this.label,
    required this.onTap,
  });

  @override
  State<_NavBarLink> createState() => _NavBarLinkState();
}

class _NavBarLinkState extends State<_NavBarLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final defaultColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
    final activeColor = theme.colorScheme.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: AppTextStyles.label(
                _isHovered ? activeColor : defaultColor,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: _isHovered ? 20 : 0,
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
