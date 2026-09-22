import 'package:flash_concursos_app/core/presentation/widgets/app_tag.dart';
import 'package:flash_concursos_app/core/presentation/widgets/deck_summary.dart';
import 'package:flash_concursos_app/core/system_design/app_colors.dart';
import 'package:flutter/material.dart';

class DeckListTile extends StatelessWidget {
  final DeckSummary summary;

  const DeckListTile({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Icon(
            Icons.book_rounded,
            color: Colors.black54,
          )
        ),
      ),
      title: Text(
        summary.deck.title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
          '${summary.deck.examBoard} · ${summary.deck.subject}',
          style: const TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8,),
          Row(
            children: [
              Text(
                '${summary.totalCards} cards',
                style: const TextStyle(
                  color: AppColors.accent,
                  fontSize: 10,
                ),
              ),
              const SizedBox(width: 8,),
              AppTag(
                text: '${summary.pendingCards} pendentes',
                fontSize: 10,
                backgroundColor: AppColors.accent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
