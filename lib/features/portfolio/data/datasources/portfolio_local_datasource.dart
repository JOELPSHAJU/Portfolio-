import '../models/project_model.dart';
import '../models/experience_model.dart';
import '../models/skill_model.dart';

abstract class PortfolioLocalDataSource {
  Future<List<ProjectModel>> getProjects();
  Future<List<ExperienceModel>> getExperiences();
  Future<List<SkillModel>> getSkills();
  Future<bool> saveContactMessage(String name, String email, String message);
}

class PortfolioLocalDataSourceImpl implements PortfolioLocalDataSource {
  @override
  Future<List<ProjectModel>> getProjects() async {
    // Simulating light network delay for realistic visual loading animations
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      const ProjectModel(
        id: 'kahramaa',
        title: 'Kahramaa',
        type: 'Official Enterprise Mobile App',
        clientOrOrg: 'Qatar General Electricity & Water Corporation',
        description:
            'The KAHRAMAA app is the official enterprise mobile application for the Qatar General Electricity & Water Corporation. It’s a comprehensive self-service platform used by citizens and residents to manage their utility services—such as paying bills, submitting move-in/move-out requests, inputting meter readings, and tracking consumption history.',
        technologies: [
          'Flutter',
          'Clean Architecture',
          'Riverpod',
          'GoRouter',
          'Dio Interceptors',
          'Keychain/Keystore',
          'RTL Workflows',
        ],
        points: [
          'Revamped the KAHRAMAA mobile application using Flutter and Clean Architecture with a modular and scalable codebase.',
          'Implemented Riverpod state management and GoRouter navigation, improving maintainability and development efficiency.',
          'Built secure networking infrastructure using Dio interceptors, token refresh workflows, and encrypted session storage with Keychain/Keystore.',
          'Developed multilingual English/Arabic RTL workflows with optimized file uploads and enterprise-grade user experiences.',
        ],
      ),
      const ProjectModel(
        id: 'khadoom',
        title: 'Khadoom',
        type: 'Employee Self-Service (ESS) & MSS Platform',
        clientOrOrg: 'Enterprise HR / Appstation Pvt Ltd',
        description:
            'Kadoom is the official employee portal for the Qatar Olympic Committee (QOC), providing a centralized platform for HR services, approvals, employee requests, notifications, and AI-powered assistance. Built with Flutter, it supports both mobile and web platforms with a scalable enterprise architecture.',
        technologies: [
          'Flutter',
          'Melos Monorepo',
          'OAuth2',
          'Microsoft Entra ID (Azure AD)',
          'Biometric Auth',
          'Dynamic Forms',
          'Audit Logging',
        ],
        points: [
          'Architected a scalable monorepo structure using Melos with reusable internal packages shared across multiple applications.',
          'Developed a dynamic schema-driven form engine capable of rendering ERP-configured forms without requiring app redeployment.',
          'Implemented secure approval workflows with audit logging for enterprise operations including Approve, Reject, RFI, and RFC handling.',
          'Integrated Microsoft Entra ID (Azure AD), OAuth2 authentication, and native biometric authentication for secure access management.',
        ],
      ),
      const ProjectModel(
        id: 'qsw',
        title: 'QSW Mobile',
        type: 'Official Social Work App',
        clientOrOrg: 'Qatar Foundation for Social Work',
        description:
            'QSW (Qatar Foundation for Social Work) is a bilingual mobile application that serves as a centralized platform for social welfare resources, news, events, research publications, and community services in Qatar. It helps users easily access information and services offered by various social support organizations under QSW.',
        technologies: [
          'Flutter',
          'Clean Architecture',
          'Bloc/Cubit',
          'AutoRoute',
          'GetIt',
          'Google Maps API',
          'Video Streaming',
        ],
        points: [
          'Built a scalable Flutter application using Clean Architecture with well-structured Data, Domain, and Presentation layers.',
          'Managed complex application states and navigation using Bloc/Cubit, AutoRoute, GetIt, and Injectable for predictable workflows.',
          'Developed lifecycle-aware connectivity monitoring with active network checks and seamless UI state restoration.',
          'Integrated Google Maps, calendar scheduling, multilingual Arabic/English support, and video streaming capabilities.',
        ],
      ),
      const ProjectModel(
        id: 'qatar_museums',
        title: 'Qatar Museums',
        type: 'Official Employee App',
        clientOrOrg: 'Qatar Museums',
        description:
            'Qatar Museums is a digital platform that allows users to explore Qatar’s museums, exhibitions, cultural events, and heritage sites. The application provides information about exhibitions, tickets, memberships, events, and museum services, offering a seamless cultural experience for visitors across mobile and web platforms.',
        technologies: [
          'Flutter',
          'MVVM',
          'Microsoft SSO',
          'Workflow Automation',
          'AnimatedSwitcher',
          'REST API',
          'Real-time Dashboard',
        ],
        points: [
          'Built a high-performance, cross-platform mobile application for Qatar Museums using Flutter & Dart, adhering to the MVVM architectural pattern.',
          'Implemented secure enterprise authentication by integrating Microsoft Single Sign-On (SSO) for identity management.',
          'Developed an interactive Services Catalogue covering critical departments (HR, IT, Procurement, Finance, Security) with a real-time ticket tracking dashboard.',
          'Crafted a modern user interface utilizing customized widgets, automated slideshows powered by AnimatedSwitcher, and smooth micro-animations.',
        ],
      ),
    ];
  }

  @override
  Future<List<ExperienceModel>> getExperiences() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [
      const ExperienceModel(
        role: 'Associate Flutter Developer',
        company: 'Appstation Pvt Ltd',
        location: 'Trivandrum, India',
        duration: 'Sept 2024 – Present',
        technologies: [
          'Flutter SDK',
          'Clean Architecture',
          'Riverpod',
          'REST API',
          'Dio',
          'OAuth2',
          'Melos Monorepo',
        ],
        points: [
          'Developing scalable enterprise-grade Flutter applications using Clean Architecture and modular design principles.',
          'Collaborating with cross-functional teams to deliver high-performance Android and iOS applications.',
          'Working with Riverpod, REST APIs, secure authentication systems, and multilingual application support.',
        ],
      ),
    ];
  }

  @override
  Future<List<SkillModel>> getSkills() async {
    return [
      // Languages
      const SkillModel(name: 'Dart', category: 'Languages', level: 0.95),
      const SkillModel(name: 'C', category: 'Languages', level: 0.70),
      const SkillModel(name: 'C++', category: 'Languages', level: 0.75),
      const SkillModel(name: 'SQL', category: 'Languages', level: 0.80),

      // Mobile Development
      const SkillModel(
        name: 'Flutter SDK',
        category: 'Mobile Development',
        level: 0.96,
      ),
      const SkillModel(
        name: 'Android SDK',
        category: 'Mobile Development',
        level: 0.85,
      ),
      const SkillModel(
        name: 'Cross-Platform Development',
        category: 'Mobile Development',
        level: 0.95,
      ),

      // Architecture
      const SkillModel(
        name: 'Clean Architecture',
        category: 'Architecture',
        level: 0.95,
      ),
      const SkillModel(name: 'MVVM', category: 'Architecture', level: 0.90),
      const SkillModel(name: 'MVC', category: 'Architecture', level: 0.90),
      const SkillModel(name: 'MVP', category: 'Architecture', level: 0.90),
      const SkillModel(
        name: 'Repository Pattern',
        category: 'Architecture',
        level: 0.92,
      ),
      const SkillModel(
        name: 'Modular Architecture',
        category: 'Architecture',
        level: 0.94,
      ),

      // State Management
      const SkillModel(
        name: 'Riverpod',
        category: 'State Management',
        level: 0.96,
      ),
      const SkillModel(
        name: 'BLoC/Cubit',
        category: 'State Management',
        level: 0.92,
      ),
      const SkillModel(
        name: 'Provider',
        category: 'State Management',
        level: 0.90,
      ),
      const SkillModel(name: 'GetX', category: 'State Management', level: 0.80),

      // API & Security
      const SkillModel(
        name: 'REST APIs (Dio/HTTP)',
        category: 'API & Security',
        level: 0.95,
      ),
      const SkillModel(
        name: 'JWT Authentication',
        category: 'API & Security',
        level: 0.92,
      ),
      const SkillModel(
        name: 'OAuth2 & Entra ID',
        category: 'API & Security',
        level: 0.90,
      ),
      const SkillModel(
        name: 'Biometric Security',
        category: 'API & Security',
        level: 0.88,
      ),
      const SkillModel(
        name: 'Token Refresh Interceptors',
        category: 'API & Security',
        level: 0.93,
      ),
      const SkillModel(
        name: 'Keychain & Keystore',
        category: 'API & Security',
        level: 0.88,
      ),
      const SkillModel(
        name: 'WebSockets & Push Notifications',
        category: 'API & Security',
        level: 0.85,
      ),

      // Tools & Platforms
      const SkillModel(
        name: 'Git & GitHub',
        category: 'Tools & Platforms',
        level: 0.92,
      ),
      const SkillModel(
        name: 'VS Code & Android Studio',
        category: 'Tools & Platforms',
        level: 0.95,
      ),
      const SkillModel(
        name: 'Melos (Monorepos)',
        category: 'Tools & Platforms',
        level: 0.90,
      ),
      const SkillModel(
        name: 'Postman',
        category: 'Tools & Platforms',
        level: 0.90,
      ),
      const SkillModel(
        name: 'Figma',
        category: 'Tools & Platforms',
        level: 0.80,
      ),

      // AI-Assisted Development
      const SkillModel(
        name: 'Cursor',
        category: 'AI-Assisted Development',
        level: 0.98,
      ),
      const SkillModel(
        name: 'Claude & GPT-4',
        category: 'AI-Assisted Development',
        level: 0.96,
      ),
      const SkillModel(
        name: 'Antigravity',
        category: 'AI-Assisted Development',
        level: 0.96,
      ),
      const SkillModel(
        name: 'GitHub Copilot',
        category: 'AI-Assisted Development',
        level: 0.92,
      ),
    ];
  }

  @override
  Future<bool> saveContactMessage(
    String name,
    String email,
    String message,
  ) async {
    // Simulating message storage (or sending it to an API)
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
