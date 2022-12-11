import 'package:cloud_firestore/cloud_firestore.dart';

class Competition {
  String name;
  String cid;
  String oid;
  bool isApproved = false;
  String description;
  Timestamp lastRegisterDate;
  Timestamp startDate;
  Timestamp endDate;
  String competitionLink;
  String location;
  List<dynamic> registeredCompetitorsIDs;

  Competition({
    this.name,
    this.cid,
    this.oid,
    this.isApproved,
    this.description,
    this.lastRegisterDate,
    this.startDate,
    this.endDate,
    this.competitionLink,
    this.location,
    this.registeredCompetitorsIDs,
  });

  Competition.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    oid = map['oid'];
    isApproved = map['isApproved'];
    description = map['description'];
    lastRegisterDate = map['lastRegisterDate'];
    startDate = map['startDate'];
    endDate = map['endDate'];
    competitionLink = map['competitionLink'];
    location = map['location'];
    registeredCompetitorsIDs = map['registeredCompetitorsIDs'];
    cid = map['cid'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'oid': oid,
      'isApproved': isApproved,
      'description': description,
      'lastRegisterDate': lastRegisterDate,
      'startDate': startDate,
      'endDate': endDate,
      'competitionLink': competitionLink,
      'location': location,
      'registeredCompetitorsIDs': registeredCompetitorsIDs,
      'cid': cid
    };
  }

  getCompetitorsNumber() {
    return registeredCompetitorsIDs.length;
  }

  @override
  String toString() {
    return 'Competition{name: $name, cid: $cid, oid: $oid, isApproved: $isApproved, description: $description, lastRegisterDate: $lastRegisterDate, startDate: $startDate, endDate: $endDate, competitionLink: $competitionLink, location: $location, registeredCompetitorsIDs: $registeredCompetitorsIDs}';
  }
}
