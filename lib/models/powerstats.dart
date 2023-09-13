class Powerstats {
  late String? intelligence;
  late String? strength;
  late String? speed;
  late String? durability;
  late String? power;
  late String? combat;

  Powerstats(
    this.intelligence,
    this.strength,
    this.speed,
    this.durability,
    this.power,
    this.combat,
  );
  Powerstats.fromJson(Map<String, dynamic> json) {
    intelligence = json["intelligence"];
    strength = json["strength"];
    speed = json["speed"];
    durability = json["durability"];
    power = json["power"];
    combat = json["combat"];
  }
}
