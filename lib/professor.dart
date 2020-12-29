

import 'package:dsi/constants.dart';
import 'package:dsi/dsi_widgets.dart';
import 'package:dsi/infra.dart';
import 'package:dsi/pessoa.dart';
import 'package:flutter/material.dart';

class Professor extends Pessoa{
  String codigo_professor;

  Professor({cpf,nome,endereco,this.codigo_professor})
    : super(cpf: cpf, nome: nome, endereco: endereco);
}

var professorController = ProfessorController();

class ProfessorController{
  List<Professor> getAll(){
    return pessoaController.getAll().whereType<Professor>().toList();
  }

  Professor save(professor){
    return pessoaController.save(professor);
  }

  bool remove(professor){
    return pessoaController.remove(professor);
  }
}

class ListProfessorPage extends StatefulWidget {
  @override
  _ListProfessorPageState createState() => _ListProfessorPageState();
}

class _ListProfessorPageState extends State<ListProfessorPage> {
  List<Professor> _professor = professorController.getAll();

  @override
  Widget build(BuildContext context) {
    return DsiScaffold(
        title: "Listagem de professores",
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => dsiHelper.go(context, '/maintain_professor'),
        ),
        body: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: _professor.length,
            itemBuilder: _buildListTileProfessor));
  }

  Widget _buildListTileProfessor(BuildContext context, int index) {
    var professor = _professor[index];
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction){
        setState(() {
          professorController.remove(professor);
          _professor.remove(professor);
        });
        dsiHelper.showMessage(
          context: context,
          message: "${professor.nome} foi removido"
        );
      },
      background: Container(
        color: Colors.red,
        child: Row(
          children: [
            Constants.spaceSmallWidth,
            Icon(Icons.delete,color: Colors.white,),
            Spacer(),
            Icon(Icons.delete,color: Colors.white),
            Constants.spaceSmallWidth
          ],
        ),
      ),
      child: ListTile(
        title: Text(professor.nome),
        subtitle: Column(
          children: [
            Text('id. ${professor.id} (Nunca fique mostrando id na tela!)'),
            SizedBox(width: 8.0),
            Text("cod. ${professor.codigo_professor}")
          ],
        ),
        onTap: () => dsiHelper.go(context, '/maintain_professor',arguments: professor),
      ),
    );
  }
}

class MaintainProfessorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Professor professor = dsiHelper.getRouteArgs(context);
    if (professor == null){
      professor = Professor();
    }
    return DsiBasicFormPage(
        title: "Professor",
        onSave: (){
          professorController.save(professor);
          dsiHelper.go(context, "/list_professor");
        },
        body: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: Constants.spaceSmallHeight.height,
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'CPF*'),
              validator: (String value) {
                return value.isEmpty ? 'CPF inválido.' : null;
              },
              initialValue: professor.cpf,
              onSaved: (newValue) => professor.cpf = newValue,
            ),
            Constants.spaceSmallHeight,
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'Nome*'),
              validator: (String value) {
                return value.isEmpty ? 'Nome inválido.' : null;
              },
              initialValue: professor.nome,
              onSaved: (newValue) => professor.nome = newValue,
            ),
            Constants.spaceSmallHeight,
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'Endereço*'),
              validator: (String value) {
                return value.isEmpty ? 'Endereço inválido.' : null;
              },
              initialValue: professor.endereco,
              onSaved: (newValue) => professor.endereco = newValue,
            ),
            Constants.spaceSmallHeight,
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Código professor*'),
              validator: (String value) {
                return value.isEmpty ? 'Código professor inválida.' : null;
              },
              initialValue: professor.codigo_professor,
              onSaved: (newValue) => professor.codigo_professor = newValue,
            ),
          ],
        ));
  }
}



