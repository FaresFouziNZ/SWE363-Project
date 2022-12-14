import 'package:flutter/material.dart';
import 'package:swe363project/model/competition.dart';
import 'package:swe363project/web_pages/create_competition_page.dart';

import '../web_pages/competition_details_page.dart';

class CompetitionCard extends StatelessWidget {
  const CompetitionCard({Key key, this.competition, this.isOwner, this.isRegistered}) : super(key: key);
  final bool isOwner;
  final bool isRegistered;
  final Competition competition;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFD9D9D9),
      ),
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.435,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.height * 0.36,
              child: const Image(
                image: AssetImage('assets/images/asda.jpg'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              competition.name ?? 'alo',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Date: ${competition.startDate.toDate().toIso8601String().substring(0, competition.startDate.toDate().toIso8601String().indexOf('T'))}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                    'End date: ${competition.endDate.toDate().toIso8601String().substring(0, competition.endDate.toDate().toIso8601String().indexOf('T'))}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  'Location: ${competition.location}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.height * 0.17,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                if (isOwner) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateCompetitionPage(
                        competition: competition,
                        isEdit: true,
                      ),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CompetitionDetailsPage(
                        competition: competition,
                        isRegistered: isRegistered,
                      ),
                    ),
                  );
                }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF5C9CBF)),
              ),
              child: Text(
                isOwner ? 'Edit' : 'Details' '',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
