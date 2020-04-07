import 'package:cantina_honesta/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _senha;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'Cantina Honesta',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20.0),
            TextFormField(
                onSaved: (value) => _email = value,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "E-mail")),
            TextFormField(
                onSaved: (value) => _senha = value,
                obscureText: true,
                decoration: InputDecoration(labelText: "Senha")),
            SizedBox(height: 20.0),
            RaisedButton(
                child: Text("Entrar"),
                onPressed: () async {
                  final form = _formKey.currentState;
                  form.save();

                  if (form.validate()) {
                    var result = await Provider.of<AuthService>(context)
                        .login(email: _email, senha: _senha);
                    if (result != null) {
                    } else {
                      return _buildShowErrorDialog(
                          context, "Erro ao fazer logon com essas credenciais");
                    }
                  }
                })
          ]),
        ),
      ),
    );
  }

  Future _buildShowErrorDialog(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Error Message'),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}
