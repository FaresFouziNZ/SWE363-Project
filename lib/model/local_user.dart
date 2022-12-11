class LocalUser {
  String name;
  String uid;

  LocalUser({this.name, this.uid});

  LocalUser.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    uid = map['uid'];
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'uid': uid,
      };
}
