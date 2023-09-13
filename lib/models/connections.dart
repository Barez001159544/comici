class Connections {
  late String? groupAffiliation;
  late String? relatives;

  Connections(
    this.groupAffiliation,
    this.relatives,
  );

  Connections.fromJson(Map<String, dynamic> json) {
    groupAffiliation = json["group-affiliation"];
    relatives = json["relatives"];
  }
}