import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projeto_mobile/main.dart';
import 'package:http/http.dart';

class Cadastro extends StatelessWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _adressController = TextEditingController();
    final _nameController = TextEditingController();
    final _ageController = TextEditingController();

    void _voltaLogin() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
      );
    }

    void _cadastro() async {
      final enteredEmail = _emailController.text;
      final enteredPassword = _passwordController.text;
      final enteredAdress = _adressController.text;
      final enteredName = _nameController.text;
      final enteredAge = _ageController.text;
      // int.parse(_ageController.text.isEmpty ? '0' : _ageController.text);
      if (enteredEmail.isEmpty ||
          int.parse(_ageController.text.isEmpty ? '0' : _ageController.text) <=
              17 ||
          enteredPassword.isEmpty ||
          enteredAdress.isEmpty ||
          enteredName.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
                'Favor preencher todos os campos!. Ousuario deve ser maior de idade'),
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
        String api =
            'https://example-ecommerce.herokuapp.com/user/customer/add';
        Response response = await post(
          Uri.parse(api),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode(<String, String>{
            'email': enteredEmail,
            'userPassword': enteredPassword,
            'address': enteredAdress,
            'age': enteredAge,
            'name': enteredName
          }),
        );
        print(response.body);
        if (response.statusCode == 201) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text(
                        'Cadastrado com sucesso. Favor se logar com o usuario cadastrado'),
                    actions: [
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: _voltaLogin,
                      ),
                    ],
                  ));
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                  'Problemas ao fazer o cadastro. Favor tentar novamente'),
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('CADASTRE-SE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20))),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: _adressController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      border: OutlineInputBorder(),
                      labelText: 'Endereço',
                      prefixIcon: Icon(Icons.home),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: _ageController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blue.shade100,
                        border: OutlineInputBorder(),
                        labelText: 'Idade',
                        prefixIcon: Icon(Icons.cake)),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blue.shade100,
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.mail),
                      ),
                      keyboardType: TextInputType.emailAddress),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue.shade100,
                          border: OutlineInputBorder(),
                          labelText: 'Nome',
                          prefixIcon: Icon(Icons.man)),
                      keyboardType: TextInputType.name),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blue.shade100,
                        border: OutlineInputBorder(),
                        labelText: 'Senha',
                        prefixIcon: Icon(Icons.key)),
                    obscureText: true,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: ElevatedButton(
                          onPressed: _voltaLogin,
                          child: Text('Voltar'),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.blue))),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                          onPressed: _cadastro,
                          child: Text('Cadastrar'),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white))),
                    ),
                  ],
                )
                // Container(
                //   padding: EdgeInsets.only(top: 30),
                //   child: TextButton(
                //       onPressed: _voltaLogin,
                //       child: Text('Voltar'),
                //       style: ButtonStyle(
                //           // backgroundColor: MaterialStateProperty.all(Colors.blue),
                //           foregroundColor:
                //               MaterialStateProperty.all(Colors.blue))),
                // )
              ],
            )),
      ),
    );
  }
}
