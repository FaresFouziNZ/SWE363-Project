import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:swe363project/model/competition.dart';
import 'package:swe363project/widgets/competition_card.dart';

class PendingCompetitionsPage extends StatelessWidget {
  const PendingCompetitionsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Competition> list = [
      Competition(),
      Competition(),
      Competition(),
      Competition(),
      Competition(),
      Competition(),
      Competition(),
      Competition(),
      Competition(),
      Competition(),
      Competition(),
      Competition(),
      Competition(),
      Competition(),
      Competition(),
      Competition(),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF5C9CBF),
        title: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.04,
              color: const Color(0xFF477281),
              child: Icon(
                Icons.home_filled,
                size: MediaQuery.of(context).size.width * 0.03,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Pending Competitions',
              style: TextStyle(
                fontSize: 18,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/asd.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 60, 20, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Text('Available Competitions'),
                  ),
                  Wrap(
                      children: list
                          .map((e) => const Padding(
                                padding: EdgeInsets.fromLTRB(40, 8, 40, 8),
                                child: CompetitionCard(),
                              ))
                          .toList()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
