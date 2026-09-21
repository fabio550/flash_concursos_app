import 'package:flutter/material.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quinta-feira, 17 set',
          style: TextStyle(fontSize: 12, color: Colors.white54),
        ),
        SizedBox(height: 2),
        Text(
          'Bom dia, Fulano',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}