import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projeto_mobile/models/produto.dart';

class Produtos extends StatelessWidget {
  final List<Produto> _userProducts;
  const Produtos(this._userProducts);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Produtos')),
      body: Center(
        child: Container(
          height: 500,
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                child: Row(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 1)),
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        // tx.amount.toString(),
                        '\$: ${_userProducts[index].price}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.purple),
                      ),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_userProducts[index].name.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Text(_userProducts[index].factor.name.toString(),
                              style: TextStyle(color: Colors.grey))
                        ])
                  ],
                ),
              );
            },
            itemCount: _userProducts.length,
            // children: _userTransactions.map((tx) {}).toList(),
          ),
        ),
      ),
    );
  }
}
