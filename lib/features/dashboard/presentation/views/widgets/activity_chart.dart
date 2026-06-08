import 'package:flutter/material.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';

class ActivityChart extends StatelessWidget {
  final List<double> values;
  
  const ActivityChart({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Weekly Performance',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: BrandColors.secondaryNeon.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: BrandColors.secondaryNeon.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.trending_up, color: BrandColors.secondaryNeon, size: 14),
                  SizedBox(width: 4),
                  Text(
                    '+14.2%',
                    style: TextStyle(
                      color: BrandColors.secondaryNeon,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 140,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(values.length, (index) {
              final val = values[index];
              // Normalize value (max height limit of 100 for display)
              final heightPct = (val / 100.0).clamp(0.1, 1.0);
              
              return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final maxHeight = constraints.maxHeight;
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeOutBack,
                              width: 14,
                              height: maxHeight * heightPct,
                              decoration: BoxDecoration(
                                gradient: index == values.length - 1
                                    ? BrandColors.neonPinkGradient
                                    : BrandColors.cyanGradient,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  if (index == values.length - 1)
                                    BoxShadow(
                                      color: BrandColors.accentNeon.withOpacity(0.4),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    )
                                  else
                                    BoxShadow(
                                      color: BrandColors.secondaryNeon.withOpacity(0.2),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      days[index % days.length],
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
