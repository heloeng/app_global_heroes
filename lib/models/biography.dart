class Biography {
  late String fullName;
  late String alterEgos;
  late List<String> aliases;
  late String placeOfBirth;
  late String firstAppearance;
  late String publisher;
  late String alignment;

  Biography(
      {required this.fullName,
      required this.alterEgos,
      required this.aliases,
      required this.placeOfBirth,
      required this.firstAppearance,
      required this.publisher,
      required this.alignment});

  Biography.fromJson(Map<String, dynamic> json) {
    fullName = json['full-name'];
    alterEgos = json['alter-egos'];
    aliases = json['aliases'].cast<String>();
    placeOfBirth = json['place-of-birth'];
    firstAppearance = json['first-appearance'];
    publisher = json['publisher'];
    alignment = json['alignment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full-name'] = this.fullName;
    data['alter-egos'] = this.alterEgos;
    data['aliases'] = this.aliases;
    data['place-of-birth'] = this.placeOfBirth;
    data['first-appearance'] = this.firstAppearance;
    data['publisher'] = this.publisher;
    data['alignment'] = this.alignment;
    return data;
  }
}
