import 'package:flutter/material.dart';

class Product{
  final String name;
  Product({required this.name});
}

typedef CardChangedCallBack = Function(Product, bool inCard);


TextStyle? titleStyle = const TextStyle(color: Colors.white, fontSize: 16);

