import 'package:flash_concursos_app/core/system_design/app_colors.dart';
import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final double? points;
  final double? percent;
  final String? upText;
  final String centerText;
  final String bottomText;

  const StatCard({
    super.key,
    this.points,
    this.percent,
    this.upText,
    required this.centerText,
    required this.bottomText,
  }): assert(
    points == null || percent == null,
    'Informe apenas points OU percent, nunca os dois.',
  );

    

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          upText != null ? Text(
            'upText',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ) : SizedBox(),
          Row(
            children: [
              Text(
                centerText,
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 2,),
              _buildTrend(
                points: points,
                percent: percent,
              )
            ],
          ),
          Text(
            bottomText,
            style: TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ]
      )
    );
  }

  Widget _buildTrend({
    double? points,
    double? percent,
  }) {
    // Nenhum dos dois → nada
    if (points == null && percent == null) {
      return const SizedBox.shrink();
    }

    final isPercent = percent != null;
    final value = isPercent ? percent : points!;
    final isPositive = value >= 0;

    final color = isPositive ? Colors.green : Colors.red;

    final icon = isPercent
        ? (isPositive ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down)
        : (isPositive ? Icons.add : Icons.remove);

    final label = isPercent
        ? '${value.abs().toStringAsFixed(0)}%'
        : '${value.abs().toStringAsFixed(0)} pts';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 14),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

}

