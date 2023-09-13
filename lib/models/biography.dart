class Biography {
  late String? fullName;
  late String? alterEgos;
  late List<dynamic> aliases;
  late String? placeOfBirth;
  late String? firstAppearance;
  late String? publisher;
  late String? alignment;

  Biography(
    this.fullName,
    this.alterEgos,
    this.aliases,
    this.placeOfBirth,
    this.firstAppearance,
    this.publisher,
    this.alignment,
  );

  Biography.fromJson(Map<String, dynamic> json) {
    fullName = json["full-name"];
    alterEgos = json["alterEgos"];
    aliases = json["aliases"];
    placeOfBirth = json["place-of-birth"];
    firstAppearance = json["firstAppearance"];
    publisher = json["publisher"];
    alignment = json["alignment"];
  }

}