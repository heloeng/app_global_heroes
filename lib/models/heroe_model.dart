class HeroeModel {
  final String id;
  final String name;
  final String fullName;
  final String imagem;
  final String intelligence;
  final String strength;
  final String speed;
  final String durability;
  final String power;
  final String combat;

  HeroeModel({
    required this.id,
    required this.name,
    required this.fullName,
    required this.imagem,
    required this.intelligence,
    required this.strength,
    required this.speed,
    required this.durability,
    required this.power,
    required this.combat,
  });

  static HeroeModel fromMap(Map<String, dynamic> hero) => HeroeModel(
        id: hero['id'],
        name: hero['name'],
        fullName: hero['biography']['full-name'],
        imagem: hero['image']['url'],
        intelligence: hero['powerstats']['intelligence'],
        strength: hero['powerstats']['strength'],
        speed: hero['powerstats']['speed'],
        durability: hero['powerstats']['durability'],
        power: hero['powerstats']['power'],
        combat: hero['powerstats']['combat'],
      );
}
