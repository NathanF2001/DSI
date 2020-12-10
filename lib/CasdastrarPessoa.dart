import 'dart:math';

import 'package:dsi/constants.dart';
import 'package:dsi/infra.dart';
import 'package:flutter/material.dart';

class CadastrarPessoa extends StatefulWidget {
  @override
  _CadastrarPessoaState createState() => _CadastrarPessoaState();
}

class _CadastrarPessoaState extends State<CadastrarPessoa> {
  final _nome = TextEditingController();
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
              height: 500,
              child: ListView.builder(
                  itemCount: _pessoas.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top:16),
                      padding: EdgeInsets.only(left:16,top: 8),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.25),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(1, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Text(_pessoas[index],
                      style: TextStyle(
                        fontSize: 20,
                      ),),
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
      child: Row(
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
          IconButton(icon: Icon(Icons.add), onPressed: (){
            if (!_formKey.currentState.validate()) return;
            setState(() {
              _pessoas.add(_nome.text);
              _nome.text = "";
            });
          })
        ],
      ),
    );
  }
}


