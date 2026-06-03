class PortfolioData {
  // ── Hero ──────────────────────────────────────────────
  static const String name = 'Mina Raouf';
  static const String title = 'Flutter Developer & Mobile Solution Architect';
  static const String bio = 'Passionate software engineer with 2+ years of experience building high-performance, beautiful mobile and web applications using Flutter & Dart. Specialized in clean architecture, reactive state management, and seamless integrations.';
  
  // Custom mock assets for demonstration
  static const String avatarAsset = 'assets/images/profile_image.jpg';

  static const String githubUrl = 'https://github.com/minaraouf10';
  static const String linkedinUrl = 'https://www.linkedin.com/in/mina-raouf-911a39221';
  static const String email = 'mina1335446@gmail.com';
  static const String cvAsset = 'assets/cv/mina_cv.pdf'; 

  // ── Skills ────────────────────────────────────────────
  static const List<Map<String, dynamic>> skillCategories = [
    {
      'category': 'Mobile & Web',
      'skills': ['Flutter', 'Dart', 'Android/Kotlin', 'iOS/Swift'],
    },
    {
      'category': 'Backend & Databases',
      'skills': ['Firebase', 'Supabase', 'Node.js', 'REST APIs'],
    },
    {
      'category': 'Architecture & State',
      'skills': ['Clean Architecture', 'Bloc / Cubit', 'Riverpod', 'Provider', 'MVVM'],
    },
    {
      'category': 'DevOps & Tools',
      'skills': ['Git', 'GitHub Actions', 'CI/CD', 'Postman'],
    },
  ];

  // ── Projects ──────────────────────────────────────────
  static const List<Map<String, dynamic>> projects = [
    {
      'title': 'Waseela HR',
      'description': 'A high-fidelity cross-platform retail app with offline-first synchronization, real-time analytics, and smooth stripe payment integration.',
      'tech': ['Flutter', 'BLoC', 'Supabase', 'Stripe API'],
      'url': 'https://github.com/minaraouf/ecommerce-pulse',
      'imageAssets': [
        'assets/images/hr/hr_1.png',
        'assets/images/hr/hr_2.png',
        'assets/images/hr/hr_3.png',
        'assets/images/hr/hr_4.png',
        'assets/images/hr/hr_5.png',
      ],
    },
    {
      'title': 'Digx',
      'description': 'A web-focused project management dashboard featuring collaborative boards, interactive Gantt charts, and custom workflow automations.',
      'tech': ['Flutter Web', 'Riverpod', 'Appwrite', 'Fl Chart'],
      'url': 'https://github.com/minaraouf/taskflow-dashboard',
      'imageAssets': [
        'assets/images/digx/digx_1.png',
        'assets/images/digx/digx_2.png',
        'assets/images/digx/digx_3.png',
        'assets/images/digx/digx_4.png',
      ],
    },
    {
      'title': 'Bab El Ezz',
      'description': 'A fitness tracking application with smart device integrations (Apple HealthKit & Google Fit), interactive charts, and localized plans.',
      'tech': ['Flutter', 'Clean Architecture', 'Firebase', 'HealthKit'],
      'url': 'https://github.com/minaraouf/fittrack-pro',
      'imageAssets': [
        'assets/images/bab_elezz/bab_el_ezz_1.jpg',
        'assets/images/bab_elezz/bab_el_ezz_2.jpg',
        'assets/images/bab_elezz/bab_el_ezz_3.jpg',
        'assets/images/bab_elezz/bab_el_ezz_4.jpg',
      ],
    },
    {
      'title': 'Shibrawi',
      'description': 'A comprehensive food ordering application featuring interactive menus, cart management, Google Maps location tracking, and multi-language support.',
      'tech': ['Flutter', 'Riverpod', 'Dio', 'Google Maps', 'Slang'],
      'url': 'https://github.com/minaraouf10',
      'imageAssets': [
        'assets/images/shibrawi/shibrawi_1.png',
        'assets/images/shibrawi/shibrawi_2.png',
      ],
    },
    {
      'title': 'Yal Spa',
      'description': 'A premium e-commerce and wellness booking application with secure authentication, location-based services, dynamic offers, and AutoRoute navigation.',
      'tech': ['Flutter', 'Riverpod', 'Dio', 'AutoRoute', 'Slang'],
      'url': 'https://github.com/minaraouf10',
      'imageAssets': [
        'assets/images/yal_spa/yal_spa_1.png',
        'assets/images/yal_spa/yal_spa_2.png',
      ],
    },
  ];

  // ── Experience ────────────────────────────────────────
  static const List<Map<String, dynamic>> experience = [
    {
      'role': 'Flutter Developer',
      'company': 'Waseela Consumer Finance.',
      'period': 'Jun 2025 – Present',
      'location': 'Dokki , Giza , Egypt ',
      'points': [
        'Designed and implemented a custom core UI design system package shared across multiple platforms.',
        'Integrated GitHub Actions CI/CD pipelines reducing testing and build delivery times by 50%.',
      ],
    },
    {
      'role': 'Mobile Developer',
      'company': 'Freelancer',
      'period': 'Feb 2023 – Present',
      'location': 'Cairo, Egypt',
      'points': [
        'Developed and successfully launched  production-grade Flutter apps ',
        'Implemented real-time messaging and notifications features using Agora and Firebase Cloud Messaging.',
      ],
    },
    {
      'role': 'Mobile Developer Intern',
      'company': 'Instant Software Solutions',
      'period': 'Aug 2022 – Jan 2023',
      'location': 'Cairo, Egypt',
      'points': [
        'Built mobile applications using Flutter, including an AR-based learning application',
      ],
    },
  ];

  // ── Education ─────────────────────────────────────────
  static const List<Map<String, dynamic>> education = [
    {
      'degree': 'B.Sc. in Computer Science & Engineering',
      'institution': 'Thebes Academy',
      'period': '2019 – 2023',
      'gpa': '3.0 / 4.0 (Very Good)',
    },
  ];
}
