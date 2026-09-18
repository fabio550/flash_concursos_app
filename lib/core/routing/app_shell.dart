import 'package:flash_concursos_app/core/system_design/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _icons = [
    Icons.home_rounded,        // Início
    Icons.layers_rounded,      // Decks / Loja
    Icons.timer_rounded,       // Simulado
    Icons.bar_chart_rounded,   // Desempenho
  ];

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      // Se já está na aba, volta pro topo da pilha dela em vez de empilhar.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  Widget _activeIcon(IconData icon) {
    return Transform.translate(
      offset: const Offset(0, 4),
      child: CircleAvatar(
        radius: 18,
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.background,
        child: Icon(icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: navigationShell,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
              bottom: Radius.circular(24),
            ),
            child: BottomNavigationBar(
              backgroundColor: AppColors.surface,
              selectedItemColor: AppColors.accent,
              unselectedItemColor: AppColors.navUnselected,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: navigationShell.currentIndex,
              onTap: _onTap,
              items: [
                for (final icon in _icons)
                  BottomNavigationBarItem(
                    icon: Icon(icon),
                    activeIcon: _activeIcon(icon),
                    label: '',
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}