import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsi_app/pessoa.dart';

class Professor {
  String id;
  String disciplina;
  Pessoa pessoa;

  Professor({this.id, this.disciplina, this.pessoa});

  Professor.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    disciplina = json['disciplina'];
  }

  Map<String, dynamic> toJson() => {'disciplina': disciplina};
}

ProfessorController professorController = ProfessorController();

class ProfessorController {
  CollectionReference professores;

  ProfessorController() {
    professores = FirebaseFirestore.instance.collection('professor');
  }

  DocumentReference getRef(String id) {
    return professores.doc(id);
  }

  FutureOr<Professor> fromJson(DocumentSnapshot snapshot) async {
    Map<String, dynamic> data = snapshot.data();
    Professor professor = Professor.fromJson(data);
    professor.id = snapshot.id;
    DocumentReference ref = data['pessoa'];
    professor.pessoa = pessoaController.fromJson(await ref.get());
    return professor;
  }

  Map<String, dynamic> toJson(Professor professor) {
    DocumentReference ref = pessoaController.getRef(professor.pessoa.id);
    return professor.toJson()..putIfAbsent('pessoa', () => ref);
  }

  FutureOr<List<FutureOr<Professor>>> getAll() async {
    QuerySnapshot documents = await professores.get();
    FutureOr<List<FutureOr<Professor>>> result =
    documents.docs.map(fromJson).toList();
    return result;
  }

  FutureOr<Professor> getById(String id) async {
    DocumentSnapshot doc = await professores.doc(id).get();
    return fromJson(doc);
  }

  Future<void> remove(FutureOr<Professor> professor) async {
    Professor p = await professor;

    Future<void> result = professores.doc(p.id).delete();
    pessoaController.remove(p.pessoa);
    return result;
  }

  Future<Professor> save(FutureOr<Professor> professor) async {
    Professor p = await professor;
    p.pessoa = await pessoaController.save(p.pessoa);
    Map<String, dynamic> data = toJson(p);
    if (p.id == null) {
      DocumentReference ref = await professores.add(data);
      return fromJson(await ref.get());
    } else {
      professores.doc(p.id).update(data);
      return p;
    }
  }
}