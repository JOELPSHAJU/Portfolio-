import 'package:flutter/material.dart';
import 'package:joel_portfolio/core/theme/brand_colors.dart';

class CounterDisplay extends StatelessWidget {
  final int count;
  final bool isLoading;

  const CounterDisplay({
    super.key,
    required this.count,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background glowing aura
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 190,
            height: 190,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  BrandColors.primaryNeon.withOpacity(isLoading ? 0.3 : 0.18),
                  BrandColors.primaryNeon.withOpacity(0.0),
                ],
              ),
            ),
          ),
          
          // Outer orbit rotating ring simulation
          Container(
            width: 170,
            height: 170,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: BrandColors.secondaryNeon.withOpacity(0.2),
                width: 1.5,
              ),
            ),
          ),
          
          // Inner glowing glass orb
          Container(
            width: 145,
            height: 145,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.08),
                  Colors.white.withOpacity(0.02),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.18),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        color: BrandColors.secondaryNeon,
                        strokeWidth: 3.5,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return ScaleTransition(scale: animation, child: child);
                          },
                          child: Text(
                            '$count',
                            key: ValueKey<int>(count),
                            style: const TextStyle(
                              fontSize: 54,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: -1.0,
                            ),
                          ),
                        ),
                        const Text(
                          'POINTS',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: BrandColors.secondaryNeon,
                            letterSpacing: 3.0,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
