import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String nome;
  final String email;
  final String nickName;
  final String? key;
  final List<dynamic>? favoritos;
  final Uint8List? image;

  UserModel(
      {required this.nome,
      required this.email,
      required this.nickName,
      this.key,
      this.favoritos,
      this.image});

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      key: map['key'],
      nome: map['nome'],
      email: map['email'],
      nickName: map['nickName'],
      favoritos: map['favoritos'],
      image: map['image']?.bytes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'nome': nome,
      'nickName': nickName,
      'email': email,
      'favoritos': favoritos,
      'image': image != null ? Blob(image!) : null,
    };
  }
}
