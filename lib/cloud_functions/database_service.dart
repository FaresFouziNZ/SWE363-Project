import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:swe363project/cloud_functions/firebase_collections.dart';
import 'package:swe363project/model/competition.dart';

import '../model/local_user.dart';

class DatabaseService {
  static DatabaseService _instance;
  final FirebaseCollections collections = FirebaseCollections();

  static DatabaseService get instance {
    _instance ??= DatabaseService();

    return _instance;
  }

  Future createUser({@required LocalUser user}) async {
    return await collections.users.doc(user.uid).set(user.toMap(), SetOptions(merge: true));
  }

  Future createCompetition(Competition competition) async {
    return await collections.competitions.add(competition.toMap()).then((value) => value.id);
  }

  Future updateCompetition(Competition competition) async {
    return await collections.competitions.doc(competition.cid).update(competition.toMap());
  }

  Future deleteCompetition(Competition competition) async {
    return await collections.competitions.doc(competition.cid).delete();
  }

  Future registerForCompetition(Competition competition, String uid) async {
    return await collections.competitions.doc(competition.cid).update({
      'registeredCompetitorsIDs': FieldValue.arrayUnion([uid]),
    });
  }

  Future approveCompetition(Competition competition) async {
    return await collections.competitions.doc(competition.cid).update({
      'isApproved': true,
    });
  }

  Future getAllCompetitions(String id) async {
    List<Competition> competitions = [];
    await collections.competitions.get().then((value) {
      for (var element in value.docs) {
        var competition = Competition.fromMap(element.data());
        competition.registeredCompetitorsIDs ??= [];
        if (!competition.registeredCompetitorsIDs.contains(id)) competitions.add(competition);
      }
    });
    return competitions;
  }

  Future getOwnedCompetitions(String id) async {
    List<Competition> competitions = [];
    await collections.competitions.where('oid', isEqualTo: id).where('oid', isNull: false).get().then((value) {
      for (var element in value.docs) {
        competitions.add(Competition.fromMap(element.data()));
      }
    });
    return competitions;
  }

  Future getMyCompetitions(String id) async {
    List<Competition> competitions = [];
    await collections.competitions.where('registeredCompetitorsIDs', arrayContains: id).get().then((value) {
      for (var element in value.docs) {
        competitions.add(Competition.fromMap(element.data()));
      }
    });
    return competitions;
  }
}
