import 'package:flash_concursos_app/core/presentation/widgets/deck_list_tile.dart';
import 'package:flash_concursos_app/core/presentation/widgets/deck_summary.dart';
import 'package:flash_concursos_app/core/system_design/app_colors.dart';
import 'package:flutter/material.dart';

class DeckListView extends StatelessWidget {
  final List<DeckSummary> summaries;

  const DeckListView({
    super.key,
    required this.summaries,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: summaries.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Card(
            clipBehavior: Clip.antiAlias,
            color: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: DeckListTile(summary: summaries[index]),
          )
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
