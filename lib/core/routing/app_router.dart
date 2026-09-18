import 'package:flash_concursos_app/core/presentation/pages/home_page.dart';
import 'package:flash_concursos_app/core/presentation/pages/practice_page.dart';
import 'package:flash_concursos_app/features/analytics/performance_page.dart';
import 'package:flash_concursos_app/features/flashcards/decks_page.dart';
import 'package:flash_concursos_app/features/flashcards/study_page.dart';
import 'package:flash_concursos_app/features/mock_exams/mock_exam_page.dart';
import 'package:flash_concursos_app/features/questions/questions_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

// 4 branches persistentes: Home, Decks, Practice e Performance são telas
// de "navegar/browsear" e preservam estado (scroll, filtro, aba interna)
// ao trocar — batendo com o design, que só mostra a bottom nav flutuante
// nelas (Inicio.dc.html, Decks.dc.html, Praticar.dc.html, Desempenho.dc.html).
final _shellHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellDecksKey = GlobalKey<NavigatorState>(debugLabel: 'shellDecks');
final _shellPracticeKey = GlobalKey<NavigatorState>(debugLabel: 'shellPractice');
final _shellPerformanceKey = GlobalKey<NavigatorState>(debugLabel: 'shellPerformance');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellHomeKey,
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellDecksKey,
          routes: [
            GoRoute(
              path: '/decks',
              builder: (context, state) => const DecksPage(),
              routes: [
                // Detalhe de um deck entra aqui como filha, ex:
                // GoRoute(path: ':deckId', builder: (context, state) => ...),
                // fica dentro da pilha da própria aba Decks.
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellPracticeKey,
          routes: [
            GoRoute(
              path: '/practice',
              builder: (context, state) => const PracticePage(),
              // As abas Questões/Simulados do design (Praticar.dc.html)
              // são estado interno da própria página (segmented control),
              // não rotas.
              routes: [
                // MockExam e Questions só existem a partir daqui — Practice
                // é o único ponto de entrada dos dois — por isso viram
                // filhas na árvore (o path fica /practice/mock-exam/:id).
                // parentNavigatorKey continua forçando o push no navigator
                // raiz: cobre a tela inteira e some com a bottom nav, igual
                // antes — aninhar na árvore só organiza a URL, não muda
                // o navigator em que a rota empilha.
                GoRoute(
                  path: 'mock-exam/:id',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    return MockExamPage();
                  },
                  routes: [
                    // GoRoute(
                    //   // Resultado do simulado (SimuladoResumo.dc.html)
                    //   // empilha por cima do próprio simulado.
                    //   path: 'summary',
                    //   parentNavigatorKey: _rootNavigatorKey,
                    //   builder: (context, state) {
                    //     return MockExamSummaryPage(id: state.pathParameters['id']!);
                    //   },
                    // ),
                  ],
                ),
                GoRoute(
                  path: 'questions/:materiaId',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    return QuestionsPage();
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellPerformanceKey,
          routes: [
            GoRoute(
              path: '/performance',
              builder: (context, state) => const PerformancePage(),
            ),
          ],
        ),
      ],
    ),

    // Study fica de FORA de qualquer branch — ao contrário de mock-exam e
    // questions, ele tem dois pontos de entrada (CTA do Home E toque num
    // deck em Decks), então não pertence a um branch só. deckId vira query
    // param opcional em vez de forçar uma rota filha de /decks: atende os
    // dois fluxos com uma rota única, sem duplicar a tela.
    GoRoute(
      path: '/study',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return StudyPage();
      },
    ),
  ],
);