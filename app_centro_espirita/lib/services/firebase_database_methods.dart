import 'package:app_centro_espirita/utils/show_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseDBMethods {
  FirebaseDBMethods(this._firestore);
  final FirebaseFirestore _firestore;

  Future<void> createWorker(
      {required String name,
      required String email,
      required String telefone,
      required BuildContext context}) async {
    try {
      final worker = Worker(
          name: name,
          email: email,
          telefone: telefone,
          id: _firestore.collection('Trabalhadores').doc().id);
      final json = worker.toJson();
      await _firestore.collection('Trabalhadores').doc(worker.id).set(json);
      showSnackBar(context, 'Trabalhador criado com sucesso!');
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Stream<List<Worker>> readWorkers() =>
      _firestore.collection('Trabalhadores').snapshots().map((snapshot) =>
          snapshot.docs.map((e) => Worker.fromJson(e.data())).toList());

  Future<Worker?> readSingleWorker(String id,
      {required BuildContext context}) async {
    try {
      final singleWorker = _firestore.collection('Trabalhadores').doc(id);
      final snapshot = await singleWorker.get();
      return Worker.fromJson(snapshot.data()!);
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
      return null;
    }
  }

  void updateWorker(
      {required String id,
      required String name,
      required String email,
      required String telefone,
      required BuildContext context}) {
    try {
      final docUser = _firestore.collection('Trabalhadores').doc(id);
      docUser.update({
        'name': name,
        'email': email,
        'telefone': telefone,
      });
      showSnackBar(context,'Trabalhador atualizado!');
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  void deleteWorker({
    required String id,
    required BuildContext context,
  }) {
    try {
      _firestore.collection('Trabalhadores').doc(id).delete();
      showSnackBar(context, 'Trabalhador foi deletado com sucesso!');
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}

class Worker {
  String id;
  final String name;
  final String email;
  final String telefone;

  Worker(
      {required this.name,
      required this.email,
      required this.telefone,
      required this.id});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'telefone': telefone,
      };

  static Worker fromJson(Map<String, dynamic> json) => Worker(
      name: json['name'],
      email: json['email'],
      telefone: json['telefone'],
      id: json['id']);
}
