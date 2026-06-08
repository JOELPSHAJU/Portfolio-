// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$portfolioLocalDataSourceHash() =>
    r'ef69f8a3fa2ad137dafe9e0cb66ed9a9876b1c35';

/// Provider for local datasource
///
/// Copied from [portfolioLocalDataSource].
@ProviderFor(portfolioLocalDataSource)
final portfolioLocalDataSourceProvider =
    AutoDisposeProvider<PortfolioLocalDataSource>.internal(
      portfolioLocalDataSource,
      name: r'portfolioLocalDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$portfolioLocalDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PortfolioLocalDataSourceRef =
    AutoDisposeProviderRef<PortfolioLocalDataSource>;
String _$serverpodClientHash() => r'29e7d214bbce19b442d9cd9f1e12efd0187454b1';

/// Provider for Serverpod client instance
///
/// Copied from [serverpodClient].
@ProviderFor(serverpodClient)
final serverpodClientProvider = AutoDisposeProvider<pc.Client>.internal(
  serverpodClient,
  name: r'serverpodClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$serverpodClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ServerpodClientRef = AutoDisposeProviderRef<pc.Client>;
String _$portfolioRemoteDataSourceHash() =>
    r'5a46e46ef20da9b8881b52ae4f27b861ae47ac00';

/// Provider for Serverpod remote datasource
///
/// Copied from [portfolioRemoteDataSource].
@ProviderFor(portfolioRemoteDataSource)
final portfolioRemoteDataSourceProvider =
    AutoDisposeProvider<PortfolioRemoteDataSource>.internal(
      portfolioRemoteDataSource,
      name: r'portfolioRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$portfolioRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PortfolioRemoteDataSourceRef =
    AutoDisposeProviderRef<PortfolioRemoteDataSource>;
String _$portfolioRepositoryHash() =>
    r'4cce8610d61148ccb64e9d24eef8c4315bd3a3b0';

/// Provider for portfolio repository
///
/// Copied from [portfolioRepository].
@ProviderFor(portfolioRepository)
final portfolioRepositoryProvider =
    AutoDisposeProvider<PortfolioRepository>.internal(
      portfolioRepository,
      name: r'portfolioRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$portfolioRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PortfolioRepositoryRef = AutoDisposeProviderRef<PortfolioRepository>;
String _$portfolioControllerHash() =>
    r'a4ce1e9ca4c8c2aef2bc13ff8154b321e6abc1a9';

/// Main controller for managing portfolio page states and interactions
///
/// Copied from [PortfolioController].
@ProviderFor(PortfolioController)
final portfolioControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      PortfolioController,
      PortfolioState
    >.internal(
      PortfolioController.new,
      name: r'portfolioControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$portfolioControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PortfolioController = AutoDisposeAsyncNotifier<PortfolioState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
