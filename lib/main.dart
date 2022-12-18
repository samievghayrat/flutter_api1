import 'package:flutter/material.dart';
import 'classes_and_functions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Sample Shopping App"),
        ),
        body: ShoppingList(
          products: [
            Product(name: 'Eggs'),
            Product(name: 'Flour'),
            Product(name: 'Chocolate chips'),],
        ),
      ),
    );
  }
}

class Shopping extends StatelessWidget {
  Shopping({required this.product,
    required this.inCard,
    required this.onCardChanged})
      : super(key: ObjectKey(product));
  final Product product;
  final bool inCard;
  final CardChangedCallBack onCardChanged;

  Color _getColor(BuildContext context) {
    return inCard ? Colors.black54 : Theme
        .of(context)
        .primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!inCard) return null;
    return const TextStyle(
        color: Colors.black54, decoration: TextDecoration.lineThrough);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCardChanged(product, inCard);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(
        product.name,
        style: _getTextStyle(context),
      ),
    );
  }
}

class ShoppingList extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ShoppingList({required this.products, super.key});
  final List<Product> products;
  @override
  State<ShoppingList> createState() => _ShoppingListState();
}
class _ShoppingListState extends State<ShoppingList> {
  final _shoppingCart = <Product>{};
  void _handleCardChanges(Product product, bool inCart) {
    setState(() {
      if (!inCart) {
        _shoppingCart.add(product);
      } else {
        _shoppingCart.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView(padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: widget.products.map((product) {
        return Shopping(product: product,
          inCard: _shoppingCart.contains(product),
          onCardChanged: _handleCardChanges);
      }).toList(),),);
  }
}
