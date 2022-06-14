import 'dart:convert';

// part 'produto.g.dart';
// https://www.bezkoder.com/dart-flutter-parse-json-string-array-to-object-list/
class Factoria {
  final int? id;
  final String? name;
  Factoria({
    required this.id,
    required this.name,
  });

  factory Factoria.fromJson(dynamic json) {
    return Factoria(id: json['id'] as int, name: json['name'] as String);
  }
}

class Produto {
  final int? id;
  final String? name;
  final double? price;
  final int? amount;
  final Factoria factor;

  Produto(
      {required this.id,
      required this.name,
      required this.price,
      required this.amount,
      required this.factor});

  factory Produto.fromJson(dynamic json) {
    return Produto(
        id: json['id'] as int,
        name: json['name'] as String,
        price: json['price'] as double,
        amount: json['amount'] as int,
        factor: Factoria.fromJson(json['factory']));
  }

  @override
  String toString() {
    return '{ ${this.name}, ${this.amount} }';
  }
  // factory Produto.fromJson(dynamic json) {
  //   return Produto(id: json['id'] as String, json['description'] as String,
  //       Factoria.fromJson(json['author']));
  // }
  // @override
  // String toString() {
  //   return '{ ${this.id}, ${this.name}, ${this.price} }';
  // }
}
