import 'package:flash_concursos_app/core/presentation/widgets/app_tag.dart';
import 'package:flash_concursos_app/core/system_design/app_colors.dart';
import 'package:flutter/material.dart';

class DeckListTile extends StatelessWidget {
  
  const DeckListTile({
    super.key
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
        child: Center(
          child: Icon(
            Icons.book_rounded,
            color: Colors.black54,
          )
        ),
      ),
      title: Text(
        'Lei 8.112/90',
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
          'VUNESP · Direito Administrativo',
          style: const TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 8,),
          Row(
            children: [
              Text(
                '62 cards',
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 10,
                ),
              ),
              SizedBox(width: 8,),
              AppTag(
                text: '18 pendentes',
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