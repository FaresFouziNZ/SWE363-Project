import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swe363project/cloud_functions/auth_service.dart';
import 'package:swe363project/cloud_functions/database_service.dart';
import 'package:swe363project/model/competition.dart';
import 'package:swe363project/model/local_user.dart';
import 'package:swe363project/web_pages/create_competition_page.dart';
import 'package:swe363project/web_pages/login_page.dart';
import 'package:swe363project/web_pages/owned_competition_page.dart';
import 'package:swe363project/widgets/competition_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LocalUser>(context);
    List<Competition> list = [];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF5C9CBF),
        title: Visibility(
          visible: user?.uid != null,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.04,
                color: const Color(0xFF477281),
                child: Icon(
                  Icons.home_filled,
                  size: MediaQuery.of(context).size.width * 0.03,
                ),
              ),
              Visibility(
                visible: true,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: TextButton(
                    onPressed: () {
                      if (user?.uid == null) {}
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateCompetitionPage(isEdit: false),
                        ),
                      );
                    },
                    child: const Text(
                      'Create Competitions',
                      style: TextStyle(fontSize: 18, color: Colors.white
                          // fontWeight: FontWeight.bold,
                          ),
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
              Visibility(
                visible: true,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: TextButton(
                    onPressed: () {
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const CreateCompetitionPage(isEdit: false),
                      //   ),
                      // );
                    },
                    child: const Text(
                      'My Competitions',
                      style: TextStyle(fontSize: 18, color: Colors.white
                          // fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: true,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OwnedCompetitionPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Owned Competitions',
                      style: TextStyle(fontSize: 18, color: Colors.white
                          // fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () async {
                  if (user?.uid == null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  } else {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Log out?'),
                            content: const Text('Are you sure you want to log out?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () async {
                                  await Auth().signOut();
                                  Navigator.pop(context);
                                },
                                child: const Text('Log out', style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          );
                        });
                  }
                },
                icon: const Icon(
                  Icons.person,
                  size: 30,
                )),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://firebasestorage.googleapis.com/v0/b/spc-watch-23a53.appspot.com/o/asd.jpg?alt=media&token=10133f7c-fdea-4c6a-ba8b-b1ca797dc212'),
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
                    child: Text(
                      'Available Competitions',
                      style: TextStyle(fontSize: 22, color: Colors.white
                          // fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  FutureBuilder(
                      future: DatabaseService().getAllCompetitions(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          list = snapshot.data;
                          return Center(
                            child: Wrap(
                                children: list
                                    .map((e) => Padding(
                                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                          child: CompetitionCard(competition: e, isOwner: false),
                                        ))
                                    .toList()),
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
