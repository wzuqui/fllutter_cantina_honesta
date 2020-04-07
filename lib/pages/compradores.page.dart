import 'package:cantina_honesta/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompradoresPage extends StatefulWidget {
  @override
  _CompradoresPageState createState() => _CompradoresPageState();
}

class _CompradoresPageState extends State<CompradoresPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compradores"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Compradores'),
            SizedBox(height: 20.0),
            RaisedButton(
                child: Text("Sair"),
                onPressed: () async {
                  await Provider.of<AuthService>(context).logout();
                })
          ],
        ),
      ),
    );
  }
}
