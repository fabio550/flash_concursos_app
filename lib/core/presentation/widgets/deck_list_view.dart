import 'package:flash_concursos_app/core/presentation/widgets/deck_list_tile.dart';
import 'package:flutter/material.dart';

class DeckListView extends StatelessWidget {
  const DeckListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
          child: Card(
            clipBehavior: Clip.antiAlias,
            color: const Color(0xFF1C1C1F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: DeckListTile(),
          )
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 8),
    );
  }
}