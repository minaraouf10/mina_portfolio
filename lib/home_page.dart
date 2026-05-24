import 'package:flutter/material.dart';
import 'core/theme/app_text_styles.dart';
import 'core/utils/responsive_util.dart';
import 'features/hero/hero_section.dart';
import 'features/skills/skills_section.dart';
import 'features/projects/projects_section.dart';
import 'features/experience/experience_section.dart';
import 'features/education/education_section.dart';
import 'features/contact/contact_section.dart';
import 'widgets/nav_bar.dart';
import 'widgets/footer.dart';
import 'widgets/scroll_to_top_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  // Navigation Items
  final List<String> _navItems = [
    'About',
    'Skills',
    'Projects',
    'Experience',
    'Education',
    'Contact',
  ];

  // Section Keys for smooth scrolling
  final List<GlobalKey> _sectionKeys = List.generate(6, (index) => GlobalKey());

  void _scrollToSection(int index) {
    final key = _sectionKeys[index];
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final showDrawer = !Responsive.isDesktop(context);

    final drawerBg = isDark ? const Color(0xFF0D1117) : const Color(0xFFFAF9F6);
    final drawerTextDefault = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: NavBar(
        scrollController: _scrollController,
        navItems: _navItems,
        onNavItemTap: (index) {
          _scrollToSection(index);
        },
      ),
      // Drawer configuration for mobile and tablet sizes
      drawer: showDrawer
          ? Drawer(
              backgroundColor: drawerBg,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          Text(
                            'Menu',
                            style: AppTextStyles.cardTitle(isDark ? Colors.white : const Color(0xFF1E293B)),
                          ),
                          Text(
                            '.',
                            style: AppTextStyles.cardTitle(theme.colorScheme.primary),
                          ),
                        ],
                      ),
                    ),
                    const Divider(indent: 24, endIndent: 24),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _navItems.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                            title: Text(
                              _navItems[index],
                              style: AppTextStyles.label(drawerTextDefault),
                            ),
                            hoverColor: theme.colorScheme.primary.withValues(alpha: 0.05),
                            onTap: () {
                              Navigator.pop(context); // Close drawer
                              _scrollToSection(index);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: Stack(
        children: [
          // Background subtle gradient patterns for high aesthetics
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.2,
                  colors: [
                    isDark
                        ? theme.colorScheme.primary.withValues(alpha: 0.05)
                        : theme.colorScheme.primary.withValues(alpha: 0.02),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.bottomRight,
                  radius: 1.5,
                  colors: [
                    isDark
                        ? theme.colorScheme.secondary.withValues(alpha: 0.03)
                        : theme.colorScheme.secondary.withValues(alpha: 0.01),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Scrollable layout containing all sections
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 70), // spacer for navbar height
                // 0. Hero Section
                HeroSection(
                  key: _sectionKeys[0],
                  onContactTap: () => _scrollToSection(5), // Link to Contact Section
                ),
                // 1. Skills Section
                SkillsSection(key: _sectionKeys[1]),
                // 2. Projects Section
                ProjectsSection(key: _sectionKeys[2]),
                // 3. Experience Section
                ExperienceSection(key: _sectionKeys[3]),
                // 4. Education Section
                EducationSection(key: _sectionKeys[4]),
                // 5. Contact Section
                ContactSection(key: _sectionKeys[5]),
                // Footer
                const Footer(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: ScrollToTopButton(scrollController: _scrollController),
    );
  }
}
