class Appearance {
  late String gender;
  late String race;
  late List<String> height;
  late List<String> weight;
  late String eyeColor;
  late String hairColor;

  Appearance(
      {required this.gender,
      required this.race,
      required this.height,
      required this.weight,
      required this.eyeColor,
      required this.hairColor});

  Appearance.fromJson(Map<String, dynamic> json) {
    gender = json['gender'] == 'null' ? 'Undefined' : json['gender'];
    race = json['race'] == 'null' ? 'Undefined' : json['race'];
    height = json['height'].cast<String>() == 'null'
        ? 'Undefined'
        : json['height'].cast<String>();
    weight = json['weight'].cast<String>() == 'null'
        ? 'Undefined'
        : json['weight'].cast<String>();
    eyeColor = json['eye-color'] == 'null' ? 'Undefined' : json['eye-color'];
    hairColor = json['hair-color'] == 'null' ? 'Undefined' : json['hair-color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['race'] = this.race;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['eye-color'] = this.eyeColor;
    data['hair-color'] = this.hairColor;
    return data;
  }
}
