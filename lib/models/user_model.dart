class UserModel {
  final String nome;
  final String email;
  final String nickName;
  final String? key;
  final List<dynamic>? favoritos;

  UserModel(
      {required this.nome,
      required this.email,
      required this.nickName,
      this.key,
      this.favoritos});

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      key: map['key'],
      nome: map['nome'],
      email: map['email'],
      nickName: map['nickName'],
      favoritos: map['favoritos'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'nome': nome,
      'nickName': nickName,
      'email': email,
      'favoritos': favoritos,
    };
  }
}
