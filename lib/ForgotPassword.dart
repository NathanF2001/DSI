import 'package:dsi/constants.dart';
import 'package:dsi/infra.dart';
import 'package:flutter/material.dart';

// Dentro do validator seria necessário colocar a seguinte condição:
//      Se a senha existe
// Se for verdadeiro manda um e-mail com codigo de recuperação e
// caso o usuário coloque código enviado pelo e-mail, retorna tela de nova senha
//
// No caso dessa aplicação será ignorando o processo de checar a senha e o código,
// pois não tem um banco de dados para checar tal e-mail.
// Portanto o botão de recuperar senha terá três campos: Email, senha e confirmar senha.

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return DsiScaffold(
      body: Column(
        children: [
          Spacer(),
          Image(
            image: Images.bsiLogo,
            height: 100,
          ),

          Text("Recuperar senha",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
          Constants.spaceMediumHeight,
          FormRecuperation(),
          Spacer(),
        ],
      ),
    );;
  }
}


class FormRecuperation extends StatefulWidget {
  @override
  _FormRecuperationState createState() => _FormRecuperationState();
}

class _FormRecuperationState extends State<FormRecuperation> {
  final _formKeyEmail = GlobalKey<FormState>();

  final _pass = TextEditingController();
  final _cpass = TextEditingController();

  void check_email() {
    if (!_formKeyEmail.currentState.validate()) return;

    dsiDialog.showInfo(
      context: context,
      message: 'Sua senha foi recuperada com sucesso',
      buttonPressed: () => dsiHelper..back(context)..back(context),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKeyEmail,
        child: Padding(
          padding: Constants.paddingMedium,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration:
                const InputDecoration(labelText: 'Insira seu E-mail*'),
                validator: (String value) {
                  return value.isEmpty ? 'Email inválido.' : null;
                },
              ),
              Constants.spaceSmallHeight,
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: _pass,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Nova Senha*'),
                validator: (String value) {
                  return value.isEmpty ? 'Senha inválida.' : null;
                },
              ),
              Constants.spaceSmallHeight,
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: _cpass,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Confirme a senha*'),
                validator: (String value) {
                  if (value.isEmpty){
                    return "Senha inválida";
                  }
                  return (_pass.text != _cpass.text) ? 'Senha não são iguais.' : null;
                },
              ),
              Constants.spaceMediumHeight,
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                    child: Text("Recuperar"), onPressed: () => check_email()),
              )

            ],
          ),
        ));
  }
}
