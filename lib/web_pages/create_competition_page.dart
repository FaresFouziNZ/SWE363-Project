import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swe363project/cloud_functions/database_service.dart';
import 'package:swe363project/model/competition.dart';
import 'package:swe363project/model/local_user.dart';
import 'package:swe363project/web_pages/home_page.dart';

class CreateCompetitionPage extends StatefulWidget {
  const CreateCompetitionPage({Key key, this.competition, @required this.isEdit}) : super(key: key);
  final bool isEdit;
  final Competition competition;
  @override
  State<CreateCompetitionPage> createState() => _CreateCompetitionPageState();
}

class _CreateCompetitionPageState extends State<CreateCompetitionPage> {
  TextEditingController _nameController,
      _descriptionController,
      _locationController,
      _startDateController,
      _endDateController,
      _lastRegisterDateController,
      _competitionLinkController;
  bool isEdit;

  Competition competition;

  @override
  void initState() {
    if (widget.isEdit == true) {
      competition = widget.competition;
      isEdit = true;
    } else {
      competition = Competition(
          name: '',
          description: '',
          location: '',
          startDate: Timestamp.now(),
          endDate: Timestamp.now(),
          lastRegisterDate: Timestamp.now(),
          isApproved: false,
          registeredCompetitorsIDs: [],
          competitionLink: '');
      isEdit = false;
    }
    _nameController = TextEditingController(text: competition.name);
    _descriptionController = TextEditingController(text: competition.description);
    _locationController = TextEditingController(text: competition.description);
    _startDateController = TextEditingController(
        text: competition.startDate
            .toDate()
            .toIso8601String()
            .substring(0, competition.startDate.toDate().toIso8601String().indexOf('T')));
    _endDateController = TextEditingController(
        text: competition.endDate
            .toDate()
            .toIso8601String()
            .substring(0, competition.endDate.toDate().toIso8601String().indexOf('T')));
    _lastRegisterDateController = TextEditingController(
        text: competition.lastRegisterDate
            .toDate()
            .toIso8601String()
            .substring(0, competition.lastRegisterDate.toDate().toIso8601String().indexOf('T')));
    _competitionLinkController = TextEditingController(text: competition.competitionLink);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _lastRegisterDateController.dispose();
    _competitionLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LocalUser>(context);
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://firebasestorage.googleapis.com/v0/b/spc-watch-23a53.appspot.com/o/asd.jpg?alt=media&token=10133f7c-fdea-4c6a-ba8b-b1ca797dc212'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: Colors.white.withOpacity(0.3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text('Competition Name:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.22,
                              child: TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white, width: 2),
                                      borderRadius: BorderRadius.all(Radius.circular(20))),
                                  labelText: 'Enter Competition Name',
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.width * 0.21,
                    color: Colors.grey,
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.29,
                    child: TextFormField(
                      controller: _descriptionController,
                      keyboardType: TextInputType.multiline,
                      minLines: 15,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Competition Description',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 58, 0),
                        child: Text('Start date:'),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.21,
                          child: GestureDetector(
                            onTap: () async {
                              var result = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2021),
                                lastDate: DateTime(2023),
                              );
                              if (result.isAfter(competition.endDate.toDate())) {
                                return;
                              }
                              if (result != null) {
                                _startDateController.text =
                                    result.toIso8601String().substring(0, result.toIso8601String().indexOf('T'));
                                if (isEdit == true) {
                                  competition.startDate = Timestamp.fromDate(result);
                                }
                              }
                            },
                            child: TextFormField(
                              controller: _startDateController,
                              enabled: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                labelText: 'Enter Date',
                              ),
                            ),
                          ))
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 63, 0),
                        child: Text('End date:'),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.21,
                          child: GestureDetector(
                            onTap: () async {
                              var result = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2021),
                                lastDate: DateTime(2023),
                              );
                              if (result.isBefore(competition.startDate.toDate())) {
                                return;
                              }
                              if (result != null) {
                                _endDateController.text =
                                    result.toIso8601String().substring(0, result.toIso8601String().indexOf('T'));
                              }
                            },
                            child: TextFormField(
                              controller: _endDateController,
                              enabled: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                labelText: 'Enter Date',
                              ),
                            ),
                          ))
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 10, 0),
                        child: Text('Register deadline:'),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.21,
                          child: GestureDetector(
                            onTap: () async {
                              var result = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2021),
                                lastDate: DateTime(2023),
                              );

                              if (result != null) {
                                _lastRegisterDateController.text =
                                    result.toIso8601String().substring(0, result.toIso8601String().indexOf('T'));
                                if (isEdit == true) {
                                  competition.startDate = Timestamp.fromDate(result);
                                }
                              }
                            },
                            child: TextFormField(
                              controller: _startDateController,
                              enabled: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                labelText: 'Enter Date',
                              ),
                            ),
                          ))
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(8, 8, 65, 8),
                          child: Text('Location:'),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.21,
                            child: TextFormField(
                              controller: _locationController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                labelText: 'Enter Location',
                              ),
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(8, 8, 68, 8),
                          child: Text('Website:'),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.21,
                            child: TextFormField(
                              controller: _competitionLinkController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                labelText: 'Enter website link',
                              ),
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.075,
                      height: MediaQuery.of(context).size.width * 0.03,
                      child: ElevatedButton(
                          onPressed: () async {
                            competition.name = _nameController.text;
                            competition.description = _descriptionController.text;
                            competition.location = _locationController.text;
                            competition.competitionLink = _competitionLinkController.text;
                            competition.endDate = Timestamp.fromDate(DateTime.parse(_endDateController.text));
                            competition.lastRegisterDate =
                                Timestamp.fromDate(DateTime.parse(_lastRegisterDateController.text));
                            competition.startDate = Timestamp.fromDate(DateTime.parse(_startDateController.text));
                            competition.oid = user.uid;
                            if (isEdit == true) {
                              await DatabaseService().updateCompetition(competition);
                              await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text('Competition updated successfully'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => const HomePage(),
                                                  ),
                                                );
                                              },
                                              child: const Text('OK'))
                                        ],
                                      ));
                            } else {
                              var id = await DatabaseService().createCompetition(competition);
                              competition.cid = id;
                              await DatabaseService().updateCompetition(competition);
                              await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text('Competition created successfully'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => const HomePage(),
                                                  ),
                                                );
                                              },
                                              child: const Text('OK'))
                                        ],
                                      ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5C9CBF),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          child: Text(
                            isEdit == false ? 'Create' : 'Update',
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          )),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
