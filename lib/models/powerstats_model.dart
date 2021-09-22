class Powerstats {
  late String intelligence;
  late String strength;
  late String speed;
  late String durability;
  late String power;
  late String combat;

  Powerstats(
      {required this.intelligence,
      required this.strength,
      required this.speed,
      required this.durability,
      required this.power,
      required this.combat});

  Powerstats.fromJson(Map<String, dynamic> json) {
    intelligence = json['intelligence'] == 'null' ? '0' : json['intelligence'];
    strength = json['strength'] == 'null' ? '0' : json['strength'];
    speed = json['speed'] == 'null' ? '0' : json['speed'];
    durability = json['durability'] == 'null' ? '0' : json['durability'];
    power = json['power'] == 'null' ? '0' : json['power'];
    combat = json['combat'] == 'null' ? '0' : json['combat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intelligence'] = this.intelligence;
    data['strength'] = this.strength;
    data['speed'] = this.speed;
    data['durability'] = this.durability;
    data['power'] = this.power;
    data['combat'] = this.combat;
    return data;
  }
}
