import 'package:app_centro_espirita/global.dart';
import 'package:app_centro_espirita/Utils/show_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseDBMethods {
  FirebaseDBMethods(this._firestore);
  final FirebaseFirestore _firestore;

  //CRUD TRABALHADORES------------------------------------------------------
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
      showSnackBar(context, 'Trabalhador atualizado!');
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
  //-----------------------------------------------------------------------------

  //CRUD GRUPO_ESTUDOS-----------------------------------------------------------
  Future<void> createGrupoEstudos(
      {required String nameGrupo, required BuildContext context}) async {
    try {
      final grupo = GrupoEsutdoDB(
          nameGrupo: nameGrupo,
          id: _firestore.collection('Grupo_Estudos').doc().id);
      final jsonGrupo = grupo.toJson();
      await _firestore.collection('Grupo_Estudos').doc(grupo.id).set(jsonGrupo);
      weekdaysGlobal.forEach((key, value) async {
        if (value) {
          final weekday = WeekdayDB(
              grupoID: _firestore.collection('Dia_semana').doc(grupo.id).id,
              weekdayname: key,
              id: _firestore.collection('Dia_semana').doc().id);
          final jsonWeekday = weekday.toJson();
          await _firestore
              .collection('Dia_semana')
              .doc(weekday.id)
              .set(jsonWeekday);
          weekdaysGlobal[key] = false;
        }
      });
      showSnackBar(context, 'Grupo criado com sucesso!');
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Stream<List<GrupoEsutdoDB>> readGruposEstudos() =>
      _firestore.collection('Grupo_Estudos').snapshots().map((snapshot) =>
          snapshot.docs.map((e) => GrupoEsutdoDB.fromJson(e.data())).toList());

  Future<GrupoEsutdoDB?> readSingleGrupoEstudo(id,
      {required BuildContext context}) async {
    try {
      final singleGrupo = _firestore.collection('Grupo_Estudos').doc(id);
      final snapshot = await singleGrupo.get();
      return GrupoEsutdoDB.fromJson(snapshot.data()!);
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
      return null;
    }
  }

  void updateGrupoEstudo(
      {required String id,
      required String nameGrupo,
      required BuildContext context}) {
    try {
      final docUser = _firestore.collection('Grupo_Estudos').doc(id);
      docUser.update({
        'nomeGrupo': nameGrupo,
      });
      _firestore
          .collection('Dia_semana')
          .where('grupo_estudos_id', isEqualTo: id)
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          print(doc.data());
        }
      });
      showSnackBar(context, 'Grupo atualizado!');
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  void deleteGrupoEstudo({
    required String id,
    required BuildContext context,
  }) async {
    try {
      _firestore.collection('Grupo_Estudos').doc(id).delete();
      _firestore
          .collection('Dia_semana')
          .where('grupo_estudos_id', isEqualTo: id)
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          _firestore.collection('Dia_semana').doc(doc.id).delete();
        }
      });
      showSnackBar(context, 'Grupo foi deletado com sucesso!');
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
  //--------------------------------------------------------------------------------

  //CRUD DIA SEMANA-----------------------------------------------------------------

  Stream<List<WeekdayDB>> readWeekdays() =>
      _firestore.collection('Dia_semana').snapshots().map((snapshot) =>
          snapshot.docs.map((e) => WeekdayDB.fromJson(e.data())).toList());

  Future<void> readWeekdaysById({required String grupoId}) async {
    await _firestore
        .collection('Dia_semana')
        .where('grupo_estudos_id', isEqualTo: grupoId)
        .get()
        .then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        weekdaysGlobal[doc.data()['dia_semana']] = true;
      }
    });
  }

  //CRUD TrabalhadoresXGrupoEstudos-----------------------------------------------------------------
  Future<void> createWorkerXGrupoEstudo(
      {required String grupoId,
      required String workerId,
      required BuildContext context}) async {
    try {
      _firestore
          .collection('Dia_semana')
          .where('grupo_estudos_id', isEqualTo: grupoId)
          .get()
          .then((querySnapshot) async {
        for (var doc in querySnapshot.docs) {
          final grupo = WorkerXGrupoEstudoDB(
              id: _firestore.collection('TrabalhadorXGrupo_Estudo').doc().id,
              grupoId: grupoId,
              workerId: workerId,
              weekdayId: doc.id);
          final jsonGrupo = grupo.toJson();
          await _firestore
              .collection('TrabalhadorXGrupo_Estudos')
              .doc(grupo.id)
              .set(jsonGrupo);
        }
      });
      showSnackBar(context, 'Grupo adicionado com sucesso!');
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  readWorkerXGrupoEstudo({required String workerId}) => _firestore
          .collection("TrabalhadorXGrupo_Estudos")
          .where('trabalhador_id', isEqualTo: workerId)
          .get()
          .then((querySnapshot) async {
        for (var doc in querySnapshot.docs) {}
      });
}

class WorkerXGrupoEstudoDB {
  String id;
  String workerId;
  String grupoId;
  String weekdayId;

  WorkerXGrupoEstudoDB(
      {required this.grupoId,
      required this.id,
      required this.weekdayId,
      required this.workerId});

  Map<String, dynamic> toJson() => {
        'id': id,
        'grupo_estudos_id': grupoId,
        'dia_semana_id': weekdayId,
        'trabalhador_id': workerId
      };

  static WorkerXGrupoEstudoDB fromJson(Map<String, dynamic> json) =>
      WorkerXGrupoEstudoDB(
          grupoId: json['grupo_estudos_id'],
          id: json['id'],
          workerId: json['trabalhador_id'],
          weekdayId: json['dia_semana_id']);
}

class WeekdayDB {
  String id;
  final String grupoID;
  final String weekdayname;

  WeekdayDB(
      {required this.weekdayname, required this.grupoID, required this.id});

  Map<String, dynamic> toJson() => {
        'id': id,
        'grupo_estudos_id': grupoID,
        'dia_semana': weekdayname,
      };

  static WeekdayDB fromJson(Map<String, dynamic> json) => WeekdayDB(
      grupoID: json['grupo_estudos_id'],
      weekdayname: json['dia_semana'],
      id: json['id']);
}

class GrupoEsutdoDB {
  String id;
  final String nameGrupo;

  GrupoEsutdoDB({required this.nameGrupo, required this.id});

  Map<String, dynamic> toJson() => {
        'id': id,
        'nomeGrupo': nameGrupo,
      };

  static GrupoEsutdoDB fromJson(Map<String, dynamic> json) =>
      GrupoEsutdoDB(nameGrupo: json['nomeGrupo'], id: json['id']);
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
