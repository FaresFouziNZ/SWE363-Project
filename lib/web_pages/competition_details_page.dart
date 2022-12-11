import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swe363project/cloud_functions/database_service.dart';
import 'package:swe363project/model/competition.dart';
import 'dart:html' as html;

import 'package:swe363project/model/local_user.dart';

import 'home_page.dart';

class CompetitionDetailsPage extends StatelessWidget {
  const CompetitionDetailsPage({Key key, this.competition}) : super(key: key);
  final Competition competition;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LocalUser>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF5C9CBF),
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                  // color: const Color(0xFF477281),
                  child: Icon(
                    Icons.home_filled,
                    size: MediaQuery.of(context).size.width * 0.03,
                  ),
                ),
              ),
              const Visibility(
                visible: false,
                child: Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text(
                    'Create Competitions',
                    style: TextStyle(
                      fontSize: 18,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Visibility(
                visible: false,
                child: Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text(
                    'Pending Competitions',
                    style: TextStyle(
                      fontSize: 18,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/asd.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(competition.name,
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.width * 0.21,
                      color: Colors.grey,
                    )
                  ],
                ),
                Container(
                  color: Colors.white.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.29,
                            // height: MediaQuery.of(context).size.width * 0.29,
                            child: Text(competition.description,
                                style: const TextStyle(
                                  fontSize: 20,
                                ))),
                        SizedBox(
                          height: (10 < MediaQuery.of(context).size.width * 0.02)
                              ? MediaQuery.of(context).size.width * 0.02
                              : 10,
                        ),
                        Text(
                            'Start date: ${competition.startDate.toDate().toIso8601String().substring(0, competition.startDate.toDate().toIso8601String().indexOf('T'))}\nEnd date: ${competition.endDate.toDate().toIso8601String().substring(0, competition.endDate.toDate().toIso8601String().indexOf('T'))}\nLocation: ${competition.location} ${MediaQuery.of(context).size.width}',
                            style: const TextStyle(fontSize: 16, color: Colors.black)),
                        const SizedBox(
                          height: 20,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                            text: 'for more information visit: ',
                          ),
                          TextSpan(
                            text: competition.competitionLink,
                            style:
                                const TextStyle(color: Color.fromARGB(255, 26, 112, 182), fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                html.window.open(competition.competitionLink, "_blank");
                              },
                          )
                        ])),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            height: MediaQuery.of(context).size.width * 0.03,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (user?.uid == null) {
                                    await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text('Registration'),
                                              content:
                                                  const Text('You need to be logged in to register for a competition'),
                                              actions: [
                                                TextButton(
                                                    style: TextButton.styleFrom(
                                                      foregroundColor: Colors.white,
                                                      backgroundColor: Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text('Cancel')),
                                              ],
                                            ));
                                    return;
                                  }
                                  await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Text('Registration confirmation'),
                                            content:
                                                const Text('Are you sure you want to register for this competition?'),
                                            actions: [
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor: Colors.white,
                                                    backgroundColor: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Cancel')),
                                              TextButton(
                                                  onPressed: () async {
                                                    await DatabaseService()
                                                        .registerForCompetition(competition, user.uid);
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) => AlertDialog(
                                                              title: const Text('Registration'),
                                                              content: const Text(
                                                                  'You have successfully registered for this competition'),
                                                              actions: [
                                                                TextButton(
                                                                    style: TextButton.styleFrom(
                                                                      foregroundColor: Colors.white,
                                                                      backgroundColor: Colors.red,
                                                                    ),
                                                                    onPressed: () {
                                                                      Navigator.of(context).pop();
                                                                      Navigator.pushReplacement(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) => const HomePage(),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child: const Text('Confirm'))
                                                              ],
                                                            ));
                                                  },
                                                  child: const Text('Confirm')),
                                            ],
                                          ));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF5C9CBF),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 28,
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
