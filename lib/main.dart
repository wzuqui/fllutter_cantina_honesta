import 'package:cantina_honesta/pages/compradores.page.dart';
import 'package:cantina_honesta/pages/login.page.dart';
import 'package:cantina_honesta/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider<AuthService>(
        child: App(),
        builder: (context) {
          return AuthService();
        },
      ),
    );

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder(
        future: Provider.of<AuthService>(context).getToken(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.hasData ? CompradoresPage() : LoginPage();
          } else {
            return Container(color: Colors.white);
          }
        },
      ),
    );
  }
}
