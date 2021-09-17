class Work {
  late String occupation;
  late String base;

  Work({required this.occupation, required this.base});

  Work.fromJson(Map<String, dynamic> json) {
    occupation = json['occupation'];
    base = json['base'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['occupation'] = this.occupation;
    data['base'] = this.base;
    return data;
  }
}
