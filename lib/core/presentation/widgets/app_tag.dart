import 'package:flash_concursos_app/core/system_design/app_colors.dart';
import 'package:flutter/material.dart';

class AppTag extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsets? padding;
  final double? fontSize;

  const AppTag({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.tagBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 14,
          color: textColor ?? AppColors.tagText,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}