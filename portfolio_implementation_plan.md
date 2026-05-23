# Flutter Web Portfolio — Cursor Implementation Plan

> **Stack:** Flutter Web · **Hosting:** Vercel · **Theme:** Auto (Light/Dark system) · **Style:** Professional & Corporate

---

## Project Overview

A personal portfolio website built with Flutter Web, inspired by [ibrahim-medhat.web.app](https://ibrahim-medhat.web.app/). The site will include six sections: Hero/About Me, Skills, Projects, Experience, Education, and Contact. It will adapt to the user's system theme (light/dark) and maintain a professional, corporate visual identity.

---

## Epic 1 — Project Setup & Infrastructure

### Task 1.1 — Create Flutter Web Project

**Goal:** Bootstrap the Flutter project and configure it for web.

**Steps:**
1. Run `flutter create portfolio --platforms web`
2. Remove unused platforms (`android`, `ios`, `linux`, `macos`, `windows`) from the project root if not needed.
3. Verify `flutter run -d chrome` works.

**Expected Output:** A running blank Flutter Web app in Chrome.

---

### Task 1.2 — Folder Structure

**Goal:** Establish clean architecture folder structure.

**Create the following under `lib/`:**

```
lib/
├── core/
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── app_colors.dart
│   │   └── app_text_styles.dart
│   ├── constants/
│   │   └── app_constants.dart
│   └── utils/
│       └── responsive_util.dart
├── data/
│   └── portfolio_data.dart        # All static content (name, bio, skills, etc.)
├── features/
│   ├── hero/
│   │   └── hero_section.dart
│   ├── skills/
│   │   └── skills_section.dart
│   ├── projects/
│   │   └── projects_section.dart
│   ├── experience/
│   │   └── experience_section.dart
│   ├── education/
│   │   └── education_section.dart
│   └── contact/
│       └── contact_section.dart
├── widgets/
│   ├── nav_bar.dart
│   ├── section_header.dart
│   ├── footer.dart
│   └── scroll_to_top_button.dart
└── main.dart
```

**Expected Output:** Empty files created with correct directory structure.

---

### Task 1.3 — Add Dependencies

**Goal:** Add required packages to `pubspec.yaml`.

```yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.1.0
  url_launcher: ^6.2.5
  flutter_svg: ^2.0.10+1
  scroll_to_id: ^2.0.3          # Smooth scroll to section by ID
  visibility_detector: ^0.4.0+2  # Trigger animations on scroll
  animate_do: ^3.3.4             # Fade/slide animations
  provider: ^6.1.1               # Theme mode state

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

Run `flutter pub get` after editing.

**Expected Output:** All packages resolved with no conflicts.

---

### Task 1.4 — Vercel Configuration

**Goal:** Configure the project for deployment on Vercel.

1. Create `vercel.json` at project root:

```json
{
  "buildCommand": "flutter build web --release",
  "outputDirectory": "build/web",
  "framework": null,
  "rewrites": [
    { "source": "/(.*)", "destination": "/index.html" }
  ]
}
```

2. Ensure `web/index.html` has `<base href="/">` set.
3. In Vercel dashboard: set build command to `flutter build web --release` and output to `build/web`.

**Note:** Flutter must be available in the Vercel build environment. Use a `build.sh` script if needed:

```bash
#!/bin/bash
git clone https://github.com/flutter/flutter.git -b stable --depth 1 /opt/flutter
export PATH="$PATH:/opt/flutter/bin"
flutter build web --release
```

Then set Vercel's build command to `bash build.sh`.

**Expected Output:** A `vercel.json` file and confirmed build pipeline.

---

## Epic 2 — Theme & Design System

### Task 2.1 — Color Palette

**File:** `lib/core/theme/app_colors.dart`

**Goal:** Define light and dark palettes for a professional corporate feel.

```dart
import 'package:flutter/material.dart';

class AppColors {
  // Light Mode
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightPrimary = Color(0xFF1A1A2E);      // Deep navy
  static const Color lightAccent = Color(0xFF0066CC);        // Corporate blue
  static const Color lightTextPrimary = Color(0xFF0D0D0D);
  static const Color lightTextSecondary = Color(0xFF555555);
  static const Color lightDivider = Color(0xFFE0E0E0);
  static const Color lightCard = Color(0xFFFFFFFF);

  // Dark Mode
  static const Color darkBackground = Color(0xFF0D1117);     // GitHub-dark style
  static const Color darkSurface = Color(0xFF161B22);
  static const Color darkPrimary = Color(0xFFE6EDF3);
  static const Color darkAccent = Color(0xFF4D9EFF);         // Bright corporate blue
  static const Color darkTextPrimary = Color(0xFFE6EDF3);
  static const Color darkTextSecondary = Color(0xFF8B949E);
  static const Color darkDivider = Color(0xFF30363D);
  static const Color darkCard = Color(0xFF161B22);
}
```

---

### Task 2.2 — Typography

**File:** `lib/core/theme/app_text_styles.dart`

**Goal:** Define consistent text styles using Google Fonts.

Use **Sora** for headings (professional, geometric) and **Inter** for body text.

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle heroName(Color color) => GoogleFonts.sora(
    fontSize: 52, fontWeight: FontWeight.w700, color: color, height: 1.1,
  );

  static TextStyle heroTitle(Color color) => GoogleFonts.sora(
    fontSize: 22, fontWeight: FontWeight.w400, color: color,
  );

  static TextStyle sectionHeader(Color color) => GoogleFonts.sora(
    fontSize: 32, fontWeight: FontWeight.w700, color: color,
  );

  static TextStyle cardTitle(Color color) => GoogleFonts.sora(
    fontSize: 18, fontWeight: FontWeight.w600, color: color,
  );

  static TextStyle body(Color color) => GoogleFonts.inter(
    fontSize: 15, fontWeight: FontWeight.w400, color: color, height: 1.6,
  );

  static TextStyle label(Color color) => GoogleFonts.inter(
    fontSize: 13, fontWeight: FontWeight.w500, color: color,
  );

  static TextStyle caption(Color color) => GoogleFonts.inter(
    fontSize: 12, fontWeight: FontWeight.w400, color: color,
  );
}
```

---

### Task 2.3 — ThemeData (Light & Dark)

**File:** `lib/core/theme/app_theme.dart`

**Goal:** Build `ThemeData` for both modes using the colors defined above.

```dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData light() => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: ColorScheme.light(
      primary: AppColors.lightAccent,
      surface: AppColors.lightSurface,
    ),
    dividerColor: AppColors.lightDivider,
    cardColor: AppColors.lightCard,
  );

  static ThemeData dark() => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkAccent,
      surface: AppColors.darkSurface,
    ),
    dividerColor: AppColors.darkDivider,
    cardColor: AppColors.darkCard,
  );
}
```

---

### Task 2.4 — Responsive Breakpoints

**File:** `lib/core/utils/responsive_util.dart`

```dart
import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1100;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static double sectionPadding(BuildContext context) =>
      isMobile(context) ? 24 : isTablet(context) ? 48 : 100;
}
```

---

## Epic 3 — Static Data

### Task 3.1 — Portfolio Content Model

**File:** `lib/data/portfolio_data.dart`

**Goal:** Centralize all portfolio content as Dart constants. Replace placeholder values with real data.

```dart
class PortfolioData {
  // ── Hero ──────────────────────────────────────────────
  static const String name = 'YOUR NAME';
  static const String title = 'Flutter Developer & Software Engineer';
  static const String bio = 'YOUR SHORT BIO — 2-3 sentences about who you are and what you do.';
  static const String avatarAsset = 'assets/images/avatar.jpg'; // add your photo

  static const String githubUrl = 'https://github.com/YOUR_HANDLE';
  static const String linkedinUrl = 'https://linkedin.com/in/YOUR_HANDLE';
  static const String email = 'your@email.com';
  static const String cvAsset = 'assets/files/cv.pdf'; // optional downloadable CV

  // ── Skills ────────────────────────────────────────────
  static const List<Map<String, dynamic>> skillCategories = [
    {
      'category': 'Mobile',
      'skills': ['Flutter', 'Dart', 'Android', 'iOS'],
    },
    {
      'category': 'Backend & Cloud',
      'skills': ['Firebase', 'REST APIs', 'Supabase'],
    },
    {
      'category': 'Architecture',
      'skills': ['Clean Architecture', 'Cubit / BLoC', 'MVVM', 'GoRouter'],
    },
    {
      'category': 'Tools',
      'skills': ['Git', 'GitHub Actions', 'Figma', 'Postman'],
    },
  ];

  // ── Projects ──────────────────────────────────────────
  static const List<Map<String, dynamic>> projects = [
    {
      'title': 'Project Name',
      'description': 'Brief description of what the project does and the problem it solves.',
      'tech': ['Flutter', 'Firebase', 'Clean Architecture'],
      'url': 'https://github.com/...',         // or live URL
      'imageAsset': 'assets/images/project1.png', // optional screenshot
    },
    // Add more projects...
  ];

  // ── Experience ────────────────────────────────────────
  static const List<Map<String, dynamic>> experience = [
    {
      'role': 'Flutter Developer',
      'company': 'Company Name',
      'period': 'Jan 2023 – Present',
      'location': 'Cairo, Egypt',
      'points': [
        'Built and maintained X feature used by Y users.',
        'Led integration of Firebase Authentication and Firestore.',
        'Collaborated with design team to implement pixel-perfect Figma mockups.',
      ],
    },
    // Add more roles...
  ];

  // ── Education ─────────────────────────────────────────
  static const List<Map<String, dynamic>> education = [
    {
      'degree': 'B.Sc. Computer Science',
      'institution': 'University Name',
      'period': '2017 – 2021',
      'gpa': '3.8 / 4.0', // optional
    },
  ];
}
```

---

## Epic 4 — Navigation

### Task 4.1 — Navbar Widget

**File:** `lib/widgets/nav_bar.dart`

**Goal:** Sticky top navigation bar with smooth scroll-to-section links and a theme toggle button.

**Behavior:**
- Desktop: horizontal links (About, Skills, Projects, Experience, Education, Contact) + dark/light toggle icon button.
- Mobile: hamburger icon that opens a drawer with the same links.
- On scroll past 80px, add a subtle shadow/blur background to the navbar.
- Clicking a link scrolls smoothly to the corresponding section using `scroll_to_id`.

**Technical notes:**
- Use `ScrollController` passed down from `main.dart` or use `scroll_to_id`'s `ScrollController`.
- Wrap the navbar in a `ValueListenableBuilder` or `Consumer<ThemeProvider>` to react to theme changes.

---

### Task 4.2 — Theme Provider

**File:** `lib/core/theme/theme_provider.dart`

**Goal:** Manage theme mode state via Provider.

```dart
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  void toggle() {
    _themeMode = _themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    notifyListeners();
  }
}
```

Register in `main.dart`:
```dart
ChangeNotifierProvider(create: (_) => ThemeProvider())
```

---

## Epic 5 — Sections

### Task 5.1 — Hero Section

**File:** `lib/features/hero/hero_section.dart`

**Goal:** Full-viewport-height intro with avatar, name, title, bio, and CTA buttons.

**Layout (Desktop):**
```
[ Left: Name + Title + Bio + Buttons ]   [ Right: Avatar photo in a card ]
```

**Layout (Mobile):** Stack vertically — avatar on top, text below.

**Elements:**
- Animated text entrance: use `animate_do`'s `FadeInLeft` for text, `FadeInRight` for avatar.
- Name: styled with `AppTextStyles.heroName`.
- Subtitle: typed-text effect (optional — can be a static string initially).
- Two buttons: **Download CV** (outlined) and **Contact Me** (filled, accent color).
- Social icons row: GitHub, LinkedIn — use `url_launcher` to open in new tab.

---

### Task 5.2 — Skills Section

**File:** `lib/features/skills/skills_section.dart`

**Goal:** Display skill categories in a responsive grid of cards.

**Layout:** 2-column grid on desktop, 1-column on mobile.

Each card:
- Category title (e.g., "Mobile")
- Skill chips: `Chip` widget with accent border, label text.

Animate cards in with `FadeInUp` + staggered delay when section enters viewport (use `visibility_detector`).

---

### Task 5.3 — Projects Section

**File:** `lib/features/projects/projects_section.dart`

**Goal:** Project cards in a responsive grid.

Each card:
- Optional screenshot image (with `BoxFit.cover`, rounded corners)
- Project title
- Description text
- Tech stack chips
- "View Project" button / icon that opens `url_launcher`

Desktop: 2–3 column grid. Mobile: 1 column.

Animate with `FadeInUp` on scroll.

---

### Task 5.4 — Experience Section

**File:** `lib/features/experience/experience_section.dart`

**Goal:** Vertical timeline of work experience.

**Layout:** A centered vertical line with alternating or left-aligned cards.

Each timeline item:
- Period badge (e.g., "Jan 2023 – Present")
- Role title + Company name
- Location
- Bullet points as a Column of `Row(icon, text)` widgets

Use `visibility_detector` to animate each item sliding in from the left as the user scrolls.

---

### Task 5.5 — Education Section

**File:** `lib/features/education/education_section.dart`

**Goal:** Clean cards showing degree, institution, period, and optional GPA.

Layout: Horizontal cards on desktop (Row), stacked on mobile.

Each card has a subtle left border in the accent color as a decorative element.

---

### Task 5.6 — Contact Section

**File:** `lib/features/contact/contact_section.dart`

**Goal:** Contact info display + optional mailto link button.

**Elements:**
- Section header: "Get In Touch"
- Short paragraph inviting contact
- Email button (opens `mailto:` via `url_launcher`)
- LinkedIn and GitHub icon buttons
- Optional: Copyable email address widget

> **Note:** No backend form is required. All contact actions use `url_launcher` (mailto, https links).

---

## Epic 6 — Layout & Main Screen

### Task 6.1 — Main Screen

**File:** `lib/main.dart` + `lib/home_page.dart`

**Goal:** Assemble all sections into a single scrollable page.

```dart
// home_page.dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavBar(),
          HeroSection(),
          SkillsSection(),
          ProjectsSection(),
          ExperienceSection(),
          EducationSection(),
          ContactSection(),
          Footer(),
        ],
      ),
    );
  }
}
```

Use `SingleChildScrollView` wrapping the `Column`, or use a `ListView` with `physics: ClampingScrollPhysics()`.

**main.dart:**
```dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'YOUR NAME — Portfolio',
      themeMode: themeProvider.themeMode,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
```

---

### Task 6.2 — Section Header Widget

**File:** `lib/widgets/section_header.dart`

**Goal:** Reusable widget used at the top of every section.

```dart
// Usage: SectionHeader(title: 'Skills')
// Output: Styled heading + decorative underline accent bar
```

---

### Task 6.3 — Footer Widget

**File:** `lib/widgets/footer.dart`

**Goal:** Simple footer at the bottom of the page.

Content: `© 2025 YOUR NAME. Built with Flutter.`

---

### Task 6.4 — Scroll-to-Top Button

**File:** `lib/widgets/scroll_to_top_button.dart`

**Goal:** A `FloatingActionButton` that appears after the user scrolls 300px, and scrolls back to top on tap.

---

## Epic 7 — Assets & Metadata

### Task 7.1 — Add Assets

Create `assets/` folder at project root:
```
assets/
├── images/
│   ├── avatar.jpg          # Your profile photo
│   └── project1.png        # Project screenshots
└── files/
    └── cv.pdf              # Optional downloadable CV
```

Register in `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/images/
    - assets/files/
```

---

### Task 7.2 — Web Metadata

**File:** `web/index.html`

Update the `<head>` section:
```html
<title>YOUR NAME — Flutter Developer</title>
<meta name="description" content="YOUR NAME — Flutter Developer & Software Engineer. Portfolio showcasing projects, skills, and experience." />
<meta property="og:title" content="YOUR NAME — Portfolio" />
<meta property="og:description" content="Flutter Developer & Software Engineer" />
<link rel="icon" type="image/png" href="favicon.png"/>
```

Replace `favicon.png` with your own icon.

---

### Task 7.3 — Web Renderer

In `web/index.html`, ensure the Flutter renderer is set to `canvaskit` for best web fidelity:
```html
<script>
  window.flutterConfiguration = {
    renderer: "canvaskit"
  };
</script>
```

---

## Epic 8 — Polish & Performance

### Task 8.1 — Scroll Animations

**Goal:** Add entrance animations to each section using `visibility_detector` + `animate_do`.

Pattern for each section:
```dart
VisibilityDetector(
  key: Key('skills-section'),
  onVisibilityChanged: (info) {
    if (info.visibleFraction > 0.1) {
      setState(() => _isVisible = true);
    }
  },
  child: AnimatedOpacity(
    opacity: _isVisible ? 1 : 0,
    duration: Duration(milliseconds: 500),
    child: // section content
  ),
);
```

---

### Task 8.2 — Hover Effects (Desktop)

**Goal:** Add hover states to project cards and nav links.

Use `MouseRegion` + `AnimatedContainer` to scale or change card shadow on hover:
```dart
MouseRegion(
  onEnter: (_) => setState(() => _hovered = true),
  onExit: (_) => setState(() => _hovered = false),
  child: AnimatedContainer(
    duration: Duration(milliseconds: 200),
    decoration: BoxDecoration(
      boxShadow: _hovered ? [BoxShadow(blurRadius: 20, color: Colors.black26)] : [],
    ),
    child: // card content
  ),
)
```

---

### Task 8.3 — Build & Deploy

**Goal:** Build and deploy the final site to Vercel.

```bash
# Test release build locally
flutter build web --release
cd build/web && python3 -m http.server 8080

# Push to GitHub, then connect repo to Vercel
# Vercel auto-builds on every push to main
```

Verify on Vercel:
- Light/dark system theme works
- Scroll animations work
- All links open correctly
- Site is responsive on mobile

---

## Task Checklist Summary

| # | Task | Epic |
|---|------|------|
| 1.1 | Create Flutter Web project | Setup |
| 1.2 | Folder structure | Setup |
| 1.3 | Add dependencies | Setup |
| 1.4 | Vercel config | Setup |
| 2.1 | Color palette | Theme |
| 2.2 | Typography | Theme |
| 2.3 | ThemeData (light/dark) | Theme |
| 2.4 | Responsive breakpoints | Theme |
| 3.1 | Portfolio data model | Data |
| 4.1 | Navbar widget | Nav |
| 4.2 | Theme provider | Nav |
| 5.1 | Hero section | Sections |
| 5.2 | Skills section | Sections |
| 5.3 | Projects section | Sections |
| 5.4 | Experience section | Sections |
| 5.5 | Education section | Sections |
| 5.6 | Contact section | Sections |
| 6.1 | Main screen assembly | Layout |
| 6.2 | Section header widget | Layout |
| 6.3 | Footer widget | Layout |
| 6.4 | Scroll-to-top button | Layout |
| 7.1 | Assets | Assets |
| 7.2 | Web metadata | Assets |
| 7.3 | Web renderer config | Assets |
| 8.1 | Scroll animations | Polish |
| 8.2 | Hover effects | Polish |
| 8.3 | Build & deploy | Deploy |

---

## Notes for Cursor

- Fill in all `YOUR NAME`, `YOUR BIO`, etc. placeholders in `lib/data/portfolio_data.dart` before building sections.
- Start with Epic 1 → 2 → 3, then build sections one at a time (Epic 5).
- The `portfolio_data.dart` file is the single source of truth — sections should read from it, not hardcode strings.
- Test on both Chrome (desktop) and Chrome DevTools mobile viewport after each section.
