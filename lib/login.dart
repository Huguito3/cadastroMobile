import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projeto_mobile/cadastro.dart';
import 'package:http/http.dart';
import 'package:projeto_mobile/produtos.dart';

import 'models/produto.dart';

class Login extends StatelessWidget {
  final Function loginF;
  Login(this.loginF);

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    void _navegaCadastro() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Cadastro()),
      );
    }

    void _login() async {
      final enteredEmail = _emailController.text;
      final enteredPassword = _passwordController.text;
      // int.parse(_ageController.text.isEmpty ? '0' : _ageController.text);
      if (enteredEmail.isEmpty || enteredPassword.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Favor preencher todos os campos!'),
            actions: [
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      } else {
        String api = 'https://example-ecommerce.herokuapp.com/user/login';
        Response response = await post(
          Uri.parse(api),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode(<String, String>{
            'login': enteredEmail,
            'password': enteredPassword
          }),
        );
        print(response.body);
        if (response.statusCode == 200) {
          // loginF(true);
          String apiP = 'https://example-ecommerce.herokuapp.com/product/list';
          Response responseProdutos = await get(
            Uri.parse(apiP),
            headers: <String, String>{'Content-Type': 'application/json'},
          );

          var tagObjsJson = jsonDecode(responseProdutos.body) as List;
          List<Produto> tagObjs =
              tagObjsJson.map((tagJson) => Produto.fromJson(tagJson)).toList();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Produtos(tagObjs)),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Login ou senha inválido(a)!'),
              actions: [
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        }
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 80,
          child: Text('DOE + MAIS',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          alignment: Alignment.center,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue.shade100,
                border: OutlineInputBorder(),
                labelText: 'E-mail',
                prefixIcon: Icon(Icons.mail),
              ),
              keyboardType: TextInputType.emailAddress),
          alignment: Alignment.center,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.blue.shade100,
              border: OutlineInputBorder(),
              labelText: 'Senha',
              prefixIcon: Icon(Icons.key),
            ),
            obscureText: true,
          ),
          alignment: Alignment.topCenter,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ElevatedButton(
              onPressed: _login,
              child: Text('Entrar'),
              // style: ElevatedButton.styleFrom(
              //   primary: Colors.blue,
              //   onPrimary: Colors.blue,
              //   minimumSize: const Size.fromHeight(50), // NEW
              // ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  foregroundColor: MaterialStateProperty.all(Colors.white))),
        ),
        Container(
          height: 150,
          margin: EdgeInsets.only(top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Ainda não é cadastrado?',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextButton(
                  onPressed: _navegaCadastro,
                  child: Text('CADASTRE-SE'),
                  style: ButtonStyle(
                      // backgroundColor: MaterialStateProperty.all(Colors.blue),
                      foregroundColor: MaterialStateProperty.all(Colors.blue)))
            ],
          ),
          alignment: Alignment.bottomCenter,
        )
      ],
    );
  }
}
