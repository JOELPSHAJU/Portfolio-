import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/brand_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/premium_button.dart';
import '../controllers/dashboard_controller.dart';
import 'widgets/activity_chart.dart';
import 'widgets/counter_display.dart';
import 'widgets/metric_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardControllerProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: BrandColors.cosmicGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar / Header Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CREATIVE ENGINE',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: BrandColors.primaryNeon.withOpacity(0.8),
                              letterSpacing: 2.0,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: BrandColors.secondaryNeon.withOpacity(0.3), width: 1.5),
                        ),
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: BrandColors.darkSurface,
                          child: Icon(Icons.person_outline, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),

                  // Animated Counter Orb Display
                  dashboardState.when(
                    data: (stats) => CounterDisplay(
                      count: stats.counter,
                      isLoading: dashboardState.isRefreshing || dashboardState.isLoading,
                    ),
                    loading: () => const CounterDisplay(count: 0, isLoading: true),
                    error: (err, stack) => CounterDisplay(count: 0, isLoading: false),
                  ),
                  const SizedBox(height: 32),

                  // Premium Control Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: PremiumButton(
                          label: 'DECREMENT',
                          icon: Icons.remove,
                          gradient: const LinearGradient(
                            colors: [BrandColors.deepPurpleMuted, BrandColors.deepPurpleCard],
                          ),
                          glowColor: Colors.transparent,
                          onPressed: () => ref.read(dashboardControllerProvider.notifier).decrement(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: PremiumButton(
                          label: 'INCREMENT',
                          icon: Icons.add,
                          gradient: BrandColors.primaryGradient,
                          glowColor: BrandColors.primaryNeon,
                          onPressed: () => ref.read(dashboardControllerProvider.notifier).increment(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Reset Button (translucent glass style)
                  Center(
                    child: TextButton.icon(
                      onPressed: () => ref.read(dashboardControllerProvider.notifier).reset(),
                      icon: const Icon(Icons.refresh, color: Colors.white70, size: 18),
                      label: const Text(
                        'RESET ENGINE',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Metrics Cards Section
                  Row(
                    children: [
                      Expanded(
                        child: MetricCard(
                          title: 'ACTIVE STREAK',
                          value: dashboardState.when(
                            data: (stats) => '${stats.streakCount} Days',
                            loading: () => '--',
                            error: (_, __) => '0 Days',
                          ),
                          subtitle: 'Multiplies every 5 pts',
                          icon: Icons.bolt_rounded,
                          iconColor: BrandColors.successNeon,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: MetricCard(
                          title: 'LAST ACCESSED',
                          value: dashboardState.when(
                            data: (stats) => _formatTime(stats.lastUpdated),
                            loading: () => 'Loading',
                            error: (_, __) => 'Error',
                          ),
                          subtitle: 'Realtime background sync',
                          icon: Icons.sync,
                          iconColor: BrandColors.secondaryNeon,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Weekly Performance Graph Card
                  GlassContainer(
                    child: dashboardState.when(
                      data: (stats) => ActivityChart(values: stats.weeklyActivity),
                      loading: () => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(color: BrandColors.primaryNeon),
                        ),
                      ),
                      error: (err, stack) => Center(
                        child: Text(
                          'Error loading graph metrics: $err',
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final second = dateTime.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }
}
