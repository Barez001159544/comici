class Appearance {
  late String? gender;
  late String? race;
  late List<dynamic> height;
  late List<dynamic> weight;
  late String? eyeColor;
  late String? hairColor;

  Appearance({
    required this.gender,
    required this.race,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hairColor,
  });

  Appearance.fromJson(Map<String, dynamic> json) {
    gender = json["gender"];
    race = json["race"];
    height = json["height"];
    weight = json["weight"];
    eyeColor = json["eyeColor"];
    hairColor = json["hairColor"];
  }
}