import 'package:flash_concursos_app/core/system_design/app_buttons.dart';
import 'package:flutter/material.dart';

class TodayReviewHero extends StatelessWidget {
  final int revisions;
  final int newCards;

  const TodayReviewHero({
    required this.revisions,
    required this.newCards,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: Color(0xFFd7f24c),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(22),
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'TJSP - Analista de Sistemas',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  //-----------------------------------------------
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 20,
                      vertical: 0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              revisions.toString(),
                              style: TextStyle(
                                fontSize: 64,
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'revisões para hoje',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        //----------------------------------------------
                        SizedBox(width: 20),
                        Container(
                          width: 1,
                          height: 100,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 20),
                        //----------------------------------------------
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              newCards == 0 ? '0' : '+ ${newCards.toString()}',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'novos flashcards',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //-----------------------------------------------
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 26, vertical: 32),
                child: ElevatedButton(
                  style: context.buttons.secondary,
                  onPressed: () {},
                  child: const Text('Começar revisão'),
                )
              )
            ]
          )
        ),
      ),
    );
  }
}