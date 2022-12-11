import 'package:swe363project/model/local_user.dart';

class Competitor extends LocalUser {
  List<String> registeredCompetitionsIDs;

  Competitor({this.registeredCompetitionsIDs, String uid});

  Competitor.fromMap(Map<String, dynamic> map) : registeredCompetitionsIDs = map['registeredCompetitionsIDs'];

  @override
  Map<String, dynamic> toMap() => {
        'registeredCompetitionsIDs': registeredCompetitionsIDs,
      };
}
