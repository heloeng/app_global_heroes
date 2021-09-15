class UserModel {
  final String nome;
  final String email;
  final String nickName;
  final String? key;

  UserModel({
    required this.nome,
    required this.email,
    required this.nickName,
    this.key,
  });

  static UserModel fromMap(Map<String, dynamic> map, [String? key]) {
    return UserModel(
      key: key,
      nome: map['nome'],
      email: map['email'],
      nickName: map['nickName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'nome': nome,
      'nickName': nickName,
      'email': email,
    };
  }
}
