import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../dashboard/presentation/controllers/dashboard_controller.dart'; // sharing sharedPreferencesProvider
import '../../data/datasources/portfolio_local_datasource.dart';
import '../../data/datasources/portfolio_remote_datasource.dart';
import '../../data/repositories/portfolio_repository_impl.dart';
import '../../domain/entities/contact_message.dart';
import '../../domain/entities/experience.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/skill.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../../domain/usecases/get_portfolio_data.dart';
import '../../domain/usecases/submit_contact.dart';
import 'package:portfolio_client/portfolio_client.dart' as pc;
import 'package:serverpod_flutter/serverpod_flutter.dart';

part 'portfolio_controller.g.dart';

enum ContactFormStatus { idle, submitting, success, error }

class PortfolioState {
  final bool isLoading;
  final String? errorMessage;
  final List<Project> projects;
  final List<Experience> experiences;
  final List<Skill> skills;
  final String activeSection; // 'home', 'about', 'experience', 'skills', 'projects', 'contact'
  final ContactFormStatus contactStatus;

  const PortfolioState({
    this.isLoading = false,
    this.errorMessage,
    this.projects = const [],
    this.experiences = const [],
    this.skills = const [],
    this.activeSection = 'home',
    this.contactStatus = ContactFormStatus.idle,
  });

  PortfolioState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<Project>? projects,
    List<Experience>? experiences,
    List<Skill>? skills,
    String? activeSection,
    ContactFormStatus? contactStatus,
  }) {
    return PortfolioState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      projects: projects ?? this.projects,
      experiences: experiences ?? this.experiences,
      skills: skills ?? this.skills,
      activeSection: activeSection ?? this.activeSection,
      contactStatus: contactStatus ?? this.contactStatus,
    );
  }
}

/// Provider for local datasource
@riverpod
PortfolioLocalDataSource portfolioLocalDataSource(PortfolioLocalDataSourceRef ref) {
  return PortfolioLocalDataSourceImpl();
}

/// Provider for Serverpod client instance
@riverpod
pc.Client serverpodClient(ServerpodClientRef ref) {
  return pc.Client('http://localhost:8080/')
    ..connectivityMonitor = FlutterConnectivityMonitor();
}

/// Provider for Serverpod remote datasource
@riverpod
PortfolioRemoteDataSource portfolioRemoteDataSource(PortfolioRemoteDataSourceRef ref) {
  final clientInstance = ref.watch(serverpodClientProvider);
  return PortfolioRemoteDataSourceImpl(clientInstance: clientInstance);
}

/// Provider for portfolio repository
@riverpod
PortfolioRepository portfolioRepository(PortfolioRepositoryRef ref) {
  final localDataSource = ref.watch(portfolioLocalDataSourceProvider);
  final remoteDataSource = ref.watch(portfolioRemoteDataSourceProvider);
  return PortfolioRepositoryImpl(
    localDataSource: localDataSource,
    remoteDataSource: remoteDataSource,
  );
}

/// Main controller for managing portfolio page states and interactions
@riverpod
class PortfolioController extends _$PortfolioController {
  late final GetPortfolioData _getDataUseCase;
  late final SubmitContact _submitContactUseCase;

  @override
  FutureOr<PortfolioState> build() async {
    final repository = ref.watch(portfolioRepositoryProvider);
    _getDataUseCase = GetPortfolioData(repository);
    _submitContactUseCase = SubmitContact(repository);

    state = const AsyncValue.loading();
    try {
      final data = await _getDataUseCase();
      return PortfolioState(
        projects: data.projects,
        experiences: data.experiences,
        skills: data.skills,
        isLoading: false,
      );
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return PortfolioState(errorMessage: e.toString(), isLoading: false);
    }
  }

  /// Updates the currently viewed section for visual indicators (sticky navigation highlights)
  void updateActiveSection(String sectionId) {
    final currentVal = state.value;
    if (currentVal == null) return;
    state = AsyncValue.data(currentVal.copyWith(activeSection: sectionId));
  }

  /// Submits the contact message and transitions loading/success visual states
  Future<bool> sendInquiry({required String name, required String email, required String message}) async {
    final currentVal = state.value;
    if (currentVal == null) return false;

    state = AsyncValue.data(currentVal.copyWith(contactStatus: ContactFormStatus.submitting));

    try {
      final success = await _submitContactUseCase(
        ContactMessage(name: name, email: email, message: message),
      );

      if (success) {
        state = AsyncValue.data(state.value!.copyWith(contactStatus: ContactFormStatus.success));
        // Reset to idle after a brief period so user can send another message if needed
        Future.delayed(const Duration(seconds: 4), () {
          if (state.value != null) {
            state = AsyncValue.data(state.value!.copyWith(contactStatus: ContactFormStatus.idle));
          }
        });
        return true;
      } else {
        state = AsyncValue.data(state.value!.copyWith(contactStatus: ContactFormStatus.error));
        return false;
      }
    } catch (e) {
      state = AsyncValue.data(state.value!.copyWith(
        contactStatus: ContactFormStatus.error,
        errorMessage: e.toString(),
      ));
      return false;
    }
  }
}
