class PortfolioData {
  // ── Hero ──────────────────────────────────────────────
  static const String name = 'Mina Raouf';
  static const String title = 'Senior Flutter Developer & Mobile Solution Architect';
  static const String bio = 'Passionate software engineer with 5+ years of experience building high-performance, beautiful mobile and web applications using Flutter & Dart. Specialized in clean architecture, reactive state management, and seamless integrations.';
  
  // Custom mock assets for demonstration
  static const String avatarAsset = 'assets/images/avatar.png';

  static const String githubUrl = 'https://github.com/minaraouf';
  static const String linkedinUrl = 'https://linkedin.com/in/minaraouf';
  static const String email = 'mina1335446@gmail.com';
  static const String cvAsset = 'assets/files/cv.pdf'; // optional downloadable CV

  // ── Skills ────────────────────────────────────────────
  static const List<Map<String, dynamic>> skillCategories = [
    {
      'category': 'Mobile & Web',
      'skills': ['Flutter', 'Dart', 'Android/Kotlin', 'iOS/Swift', 'HTML/CSS/JS'],
    },
    {
      'category': 'Backend & Databases',
      'skills': ['Firebase', 'Supabase', 'Node.js', 'REST APIs', 'PostgreSQL', 'GraphQL'],
    },
    {
      'category': 'Architecture & State',
      'skills': ['Clean Architecture', 'Bloc / Cubit', 'Riverpod', 'Provider', 'MVVM'],
    },
    {
      'category': 'DevOps & Tools',
      'skills': ['Git', 'GitHub Actions', 'CI/CD', 'Figma', 'Docker', 'Postman'],
    },
  ];

  // ── Projects ──────────────────────────────────────────
  static const List<Map<String, dynamic>> projects = [
    {
      'title': 'E-Commerce Pulse',
      'description': 'A high-fidelity cross-platform retail app with offline-first synchronization, real-time analytics, and smooth stripe payment integration.',
      'tech': ['Flutter', 'BLoC', 'Supabase', 'Stripe API'],
      'url': 'https://github.com/minaraouf/ecommerce-pulse',
      'imageAsset': 'assets/images/project1.png',
    },
    {
      'title': 'TaskFlow Dashboard',
      'description': 'A web-focused project management dashboard featuring collaborative boards, interactive Gantt charts, and custom workflow automations.',
      'tech': ['Flutter Web', 'Riverpod', 'Appwrite', 'Fl Chart'],
      'url': 'https://github.com/minaraouf/taskflow-dashboard',
      'imageAsset': 'assets/images/project2.png',
    },
    {
      'title': 'FitTrack Pro',
      'description': 'A fitness tracking application with smart device integrations (Apple HealthKit & Google Fit), interactive charts, and localized plans.',
      'tech': ['Flutter', 'Clean Architecture', 'Firebase', 'HealthKit'],
      'url': 'https://github.com/minaraouf/fittrack-pro',
      'imageAsset': 'assets/images/project3.png',
    },
  ];

  // ── Experience ────────────────────────────────────────
  static const List<Map<String, dynamic>> experience = [
    {
      'role': 'Senior Flutter Engineer',
      'company': 'Tech Solutions Inc.',
      'period': 'Jan 2023 – Present',
      'location': 'Cairo, Egypt (Remote)',
      'points': [
        'Led a team of 4 developers to redesign a high-scale financial app, improving app launch times by 35%.',
        'Designed and implemented a custom core UI design system package shared across multiple platforms.',
        'Integrated GitHub Actions CI/CD pipelines reducing testing and build delivery times by 50%.',
      ],
    },
    {
      'role': 'Mobile App Developer',
      'company': 'AppCraft Studio',
      'period': 'Jun 2021 – Dec 2022',
      'location': 'Cairo, Egypt',
      'points': [
        'Developed and successfully launched 5+ production-grade Flutter apps to Play Store and App Store.',
        'Achieved 99.9% crash-free sessions by writing extensive unit, widget, and integration tests.',
        'Implemented real-time messaging and notifications features using WebSockets and Firebase Cloud Messaging.',
      ],
    },
  ];

  // ── Education ─────────────────────────────────────────
  static const List<Map<String, dynamic>> education = [
    {
      'degree': 'B.Sc. in Computer Science & Engineering',
      'institution': 'Cairo University',
      'period': '2017 – 2021',
      'gpa': '3.8 / 4.0 (Excellent with Honors)',
    },
  ];
}
