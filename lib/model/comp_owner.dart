class CompetitionOwner {
  List<String> ownedCompetitionsIDs;

  CompetitionOwner({this.ownedCompetitionsIDs});

  CompetitionOwner.fromMap(Map<String, dynamic> map) : ownedCompetitionsIDs = map['ownedCompetitionsIDs'];

  Map<String, dynamic> toMap() => {
        'ownedCompetitionsIDs': ownedCompetitionsIDs,
      };
}
