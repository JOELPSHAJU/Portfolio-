// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'443508efda9b44aec96e97805dfadbca7681b0a0';

/// Provider for SharedPreferences. Must be overridden in main.dart once initialized.
///
/// Copied from [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider =
    AutoDisposeProvider<SharedPreferences>.internal(
      sharedPreferences,
      name: r'sharedPreferencesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sharedPreferencesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedPreferencesRef = AutoDisposeProviderRef<SharedPreferences>;
String _$dashboardLocalDataSourceHash() =>
    r'e3db4388c06284ee93cdd8bceb0f0fd2b39b7fdf';

/// Provider for the local data source.
///
/// Copied from [dashboardLocalDataSource].
@ProviderFor(dashboardLocalDataSource)
final dashboardLocalDataSourceProvider =
    AutoDisposeProvider<DashboardLocalDataSource>.internal(
      dashboardLocalDataSource,
      name: r'dashboardLocalDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$dashboardLocalDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DashboardLocalDataSourceRef =
    AutoDisposeProviderRef<DashboardLocalDataSource>;
String _$dashboardRepositoryHash() =>
    r'13acf4058dffd4c39721e175c9b7bfd46ee497a9';

/// Provider for the repository.
///
/// Copied from [dashboardRepository].
@ProviderFor(dashboardRepository)
final dashboardRepositoryProvider =
    AutoDisposeProvider<DashboardRepository>.internal(
      dashboardRepository,
      name: r'dashboardRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$dashboardRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DashboardRepositoryRef = AutoDisposeProviderRef<DashboardRepository>;
String _$dashboardControllerHash() =>
    r'0f59b0aae0cdf96545e077abeeef82c55908e9d8';

/// Riverpod controller managing the dashboard state using modern code generation.
///
/// Copied from [DashboardController].
@ProviderFor(DashboardController)
final dashboardControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      DashboardController,
      DashboardStats
    >.internal(
      DashboardController.new,
      name: r'dashboardControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$dashboardControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DashboardController = AutoDisposeAsyncNotifier<DashboardStats>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
