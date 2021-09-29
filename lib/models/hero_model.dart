import 'powerstats_model.dart';
import 'work_model.dart';

import 'appearance_model.dart';
import 'biography.dart';
import 'connections_model.dart';
import 'image_model.dart';

class HeroModel {
  late String id;
  late String name;
  late Powerstats powerstats;
  late Biography biography;
  late Appearance appearance;
  late Work work;
  late Connections connections;
  late Image image;

  HeroModel(
      {required this.id,
      required this.name,
      required this.powerstats,
      required this.biography,
      required this.appearance,
      required this.work,
      required this.connections,
      required this.image});

  HeroModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    powerstats = (json['powerstats'] != null
        ? new Powerstats.fromJson(json['powerstats'])
        : null)!;
    biography = (json['biography'] != null
        ? new Biography.fromJson(json['biography'])
        : null)!;
    appearance = (json['appearance'] != null
        ? new Appearance.fromJson(json['appearance'])
        : null)!;
    work = (json['work'] != null ? new Work.fromJson(json['work']) : null)!;
    connections = (json['connections'] != null
        ? new Connections.fromJson(json['connections'])
        : null)!;
    image = (json['image'] != null ? new Image.fromJson(json['image']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['powerstats'] = this.powerstats.toJson();
    data['biography'] = this.biography.toJson();
    data['appearance'] = this.appearance.toJson();
    data['work'] = this.work.toJson();
    data['connections'] = this.connections.toJson();
    data['image'] = this.image.toJson();
    return data;
  }
}
