import 'package:flutter/material.dart';
import 'package:projeto_mobile/cadastro.dart';
import 'package:projeto_mobile/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Teste'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _logado = false;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _loginF(bool logado) {
    print('LOGOU');
    print(logado);
    setState(() {
      _logado = logado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _logado
          ? AppBar(
              title: Text(widget.title),
            )
          : null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Login(_loginF),
            // Cadastro()
            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
