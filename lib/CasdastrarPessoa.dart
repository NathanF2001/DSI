import 'dart:math';

import 'package:dsi/constants.dart';
import 'package:dsi/infra.dart';
import 'package:flutter/material.dart';

class CadastrarPessoa extends StatefulWidget {
  @override
  _CadastrarPessoaState createState() => _CadastrarPessoaState();
}
// Dentro dessa janela tem um listview onde cada usuário cadastrado é adicionado a ele.

class _CadastrarPessoaState extends State<CadastrarPessoa> {
  final _nome = TextEditingController();
  final _idade = TextEditingController();
  final _hab = TextEditingController();
  List _pessoas = [];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DsiScaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar(context) {
    return AppBar(
      title: Text('Cadastrar Pessoas'),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _FormName(),
            Container(
              height: 350,
              child: ListView.builder(
                  itemCount: _pessoas.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top:16),
                      padding: EdgeInsets.only(left:16,top: 8),
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.25),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_pessoas[index]["Nome"],
                            style: TextStyle(
                              fontSize: 20,
                            ),),
                          Text("${_pessoas[index]["Idade"]} anos",
                            style: TextStyle(
                              fontSize: 14,
                            ),),
                          Text("Habilidade: ${_pessoas[index]["Habilidade"]}",
                            style: TextStyle(
                              fontSize: 18,
                            ),)
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      )
    );
  }

  _FormName() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 320,
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: _nome,
              decoration:
              const InputDecoration(labelText: 'Insira o nome do usuário:'),
              validator: (String value) {
                return value.isEmpty ? 'Nome inválido.' : null;
              },
            ),
          ),
          Constants.spaceSmallHeight,
          Container(
            width: 320,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _idade,
              decoration:
              const InputDecoration(labelText: 'Insira a idade do usuário:'),
              validator: (String value) {
                return value.isEmpty ? 'Idade inválida.' : null;
              },
            ),
          ),
          Constants.spaceSmallHeight,
          Container(
            width: 320,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _hab,
              decoration:
              const InputDecoration(labelText: 'Insira uma habilidade do usuário:'),
              validator: (String value) {
                return value.isEmpty ? 'Habilidade inválida.' : null;
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
                child: Text("Adicionar"), onPressed: () {setState(() {
                  _pessoas.add({
                    "Nome": _nome.text,
                    "Idade": _idade.text,
                    "Habilidade": _hab.text
                  });
                });}),
          ),
        ],
      ),
    );
  }
}


