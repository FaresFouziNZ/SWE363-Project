import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swe363project/model/competition.dart';
import 'package:swe363project/widgets/competition_card.dart';

class CompetitionEditPage extends StatelessWidget {
  const CompetitionEditPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CompetitionCard(
            competition: Competition(
                name: 'asdasdasd',
                description: '',
                location: '',
                startDate: Timestamp.now(),
                endDate: Timestamp.now(),
                lastRegisterDate: Timestamp.now(),
                competitionLink: '')),
      ),
    );
  }
}
