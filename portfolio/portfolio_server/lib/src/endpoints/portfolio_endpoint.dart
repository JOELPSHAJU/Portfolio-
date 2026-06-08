import '../generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class PortfolioEndpoint extends Endpoint {
  final List<Map<String, String>> _inquiries = [];

  Future<PortfolioData> getPortfolioData(Session session) async {
    final projects = [
      Project(
        id: 'kahramaa',
        title: 'Kahramaa',
        type: 'Official Enterprise Mobile App',
        clientOrOrg: 'Qatar General Electricity & Water Corporation',
        description: 'Revamped and modernized the official KAHRAMAA mobile application with high-security, performance optimization, and multilingual support.',
        technologies: ['Flutter', 'Clean Architecture', 'Riverpod', 'GoRouter', 'Dio Interceptors', 'Keychain/Keystore', 'RTL Workflows'],
        points: [
          'Revamped the KAHRAMAA mobile application using Flutter and Clean Architecture with a modular and scalable codebase.',
          'Implemented Riverpod state management and GoRouter navigation, improving maintainability and development efficiency.',
          'Built secure networking infrastructure using Dio interceptors, token refresh workflows, and encrypted session storage with Keychain/Keystore.',
          'Developed multilingual English/Arabic RTL workflows with optimized file uploads and enterprise-grade user experiences.'
        ],
      ),
      Project(
        id: 'khadoom',
        title: 'Khadoom',
        type: 'Employee Self-Service (ESS) & MSS Platform',
        clientOrOrg: 'Enterprise HR / Appstation Pvt Ltd',
        description: 'Architected a scalable monorepo structure with dynamic schema-driven form generation and secure Microsoft Entra ID authentication.',
        technologies: ['Flutter', 'Melos Monorepo', 'OAuth2', 'Microsoft Entra ID (Azure AD)', 'Biometric Auth', 'Dynamic Forms', 'Audit Logging'],
        points: [
          'Architected a scalable monorepo structure using Melos with reusable internal packages shared across multiple applications.',
          'Developed a dynamic schema-driven form engine capable of rendering ERP-configured forms without requiring app redeployment.',
          'Implemented secure approval workflows with audit logging for enterprise operations including Approve, Reject, RFI, and RFC handling.',
          'Integrated Microsoft Entra ID (Azure AD), OAuth2 authentication, and native biometric authentication for secure access management.'
        ],
      ),
      Project(
        id: 'qsw',
        title: 'QSW Mobile',
        type: 'Official Social Work App',
        clientOrOrg: 'Qatar Foundation for Social Work',
        description: 'Built a highly performant application with advanced state management, connectivity fallbacks, streaming capabilities, and map integrations.',
        technologies: ['Flutter', 'Clean Architecture', 'Bloc/Cubit', 'AutoRoute', 'GetIt', 'Google Maps API', 'Video Streaming'],
        points: [
          'Built a scalable Flutter application using Clean Architecture with well-structured Data, Domain, and Presentation layers.',
          'Managed complex application states and navigation using Bloc/Cubit, AutoRoute, GetIt, and Injectable for predictable workflows.',
          'Developed lifecycle-aware connectivity monitoring with active network checks and seamless UI state restoration.',
          'Integrated Google Maps, calendar scheduling, multilingual Arabic/English support, and video streaming capabilities.'
        ],
      ),
      Project(
        id: 'qatar_museums',
        title: 'Qatar Museums',
        type: 'Official Employee App',
        clientOrOrg: 'Qatar Museums',
        description: 'Built a high-performance cross-platform employee services application using MVVM architecture, integrating Microsoft SSO, a rich service catalogue, and a real-time ticket tracking dashboard.',
        technologies: ['Flutter', 'MVVM', 'Microsoft SSO', 'Workflow Automation', 'AnimatedSwitcher', 'REST API', 'Real-time Dashboard'],
        points: [
          'Built a high-performance, cross-platform mobile application for Qatar Museums using Flutter & Dart, adhering to the MVVM architectural pattern.',
          'Implemented secure enterprise authentication by integrating Microsoft Single Sign-On (SSO) for identity management.',
          'Developed an interactive Services Catalogue covering critical departments (HR, IT, Procurement, Finance, Security) with a real-time ticket tracking dashboard.',
          'Crafted a modern user interface utilizing customized widgets, automated slideshows powered by AnimatedSwitcher, and smooth micro-animations.'
        ],
      ),
    ];

    final experiences = [
      Experience(
        role: 'Associate Flutter Developer',
        company: 'Appstation Pvt Ltd',
        duration: 'Sept 2024 – Present',
        location: 'Trivandrum, India',
        technologies: ['Flutter SDK', 'Clean Architecture', 'Riverpod', 'REST API', 'Dio', 'OAuth2', 'Melos Monorepo'],
        points: [
          'Developing scalable enterprise-grade Flutter applications using Clean Architecture and modular design principles.',
          'Collaborating with cross-functional teams to deliver high-performance Android and iOS applications.',
          'Working with Riverpod, REST APIs, secure authentication systems, and multilingual application support.'
        ],
      ),
      Experience(
        role: 'Flutter Developer',
        company: 'Freelancer',
        duration: '2023 – 2024',
        location: 'Remote',
        technologies: ['Flutter', 'Firebase SDK', 'REST APIs', 'Provider', 'Hive', 'Shared Preferences'],
        points: [
          'Developed and maintained Flutter applications for multiple clients with responsive and user-centric interfaces.',
          'Integrated Firebase services, REST APIs, local storage, and state management solutions for scalable applications.',
          'Delivered production-ready applications with focus on performance optimization and maintainability.'
        ],
      ),
    ];

    final skills = [
      Skill(name: 'Dart', category: 'Languages', level: 0.95),
      Skill(name: 'SQL', category: 'Languages', level: 0.80),
      Skill(name: 'Flutter SDK', category: 'Mobile Development', level: 0.96),
      Skill(name: 'Clean Architecture', category: 'Architecture', level: 0.95),
      Skill(name: 'Riverpod', category: 'State Management', level: 0.96),
      Skill(name: 'BLoC/Cubit', category: 'State Management', level: 0.92),
      Skill(name: 'REST APIs (Dio/HTTP)', category: 'API & Security', level: 0.95),
      Skill(name: 'OAuth2 & Entra ID', category: 'API & Security', level: 0.90),
      Skill(name: 'Melos (Monorepos)', category: 'Tools & Platforms', level: 0.90),
      Skill(name: 'Cursor', category: 'AI-Assisted Development', level: 0.98),
    ];

    return PortfolioData(
      projects: projects,
      experiences: experiences,
      skills: skills,
    );
  }

  Future<bool> submitInquiry(
    Session session, {
    required String name,
    required String email,
    required String message,
  }) async {
    _inquiries.add({
      'name': name,
      'email': email,
      'message': message,
      'timestamp': DateTime.now().toIso8601String(),
    });
    session.log('Portfolio inquiry: Name: $name, Email: $email, Message: $message');
    return true;
  }
}
