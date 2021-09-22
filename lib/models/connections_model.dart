class Connections {
  late String groupAffiliation;
  late String relatives;

  Connections({required this.groupAffiliation, required this.relatives});

  Connections.fromJson(Map<String, dynamic> json) {
    groupAffiliation = json['group-affiliation'] == 'null'
        ? 'Undefined'
        : json['group-affiliation'];
    relatives = json['relatives'] == 'null' ? 'Undefined' : json['relatives'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group-affiliation'] = this.groupAffiliation;
    data['relatives'] = this.relatives;
    return data;
  }
}
