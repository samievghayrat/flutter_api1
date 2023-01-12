import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final _incrementCounter = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Value Notifier"),
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: _incrementCounter,
          builder: (context, value, _) {
            return Text('counter: $value', style: titleStyle,);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(
            () {
              _incrementCounter.value++;
              // _incrementCounter++;
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _incrementCounter.dispose();
    super.dispose();
  }
}

TextStyle titleStyle = TextStyle(fontSize: 20);
//
// class Contact {
//   final String number;
//   final String name;
//
//   Contact({required this.name, required this.number});
// }
//
// class ContactBook extends ValueNotifier<List<Contact>> {
//   ContactBook._sharedInstance() : super([]);
//
//   static final ContactBook _shared = ContactBook._sharedInstance();
//
//   factory ContactBook() => _shared;
//   final List<Contact> _contacts = [];
//
//   int get length => value.length;
//
//   void add({required Contact contact}) {
//     final contacts = value;
//
//     contacts.add(contact);
//     notifyListeners();
//   }
//
//   void remove({required Contact contact}) {
//     final contacts = value;
//     if (contacts.contains(contact)) {
//       contacts.remove(contact);
//       notifyListeners();
//     }
//   }
//
//   Contact? contact({required int atIndex}) =>
//       value.length > atIndex ? value[atIndex] : null;
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   late final TextEditingController _nameController;
//   late final TextEditingController _phoneNumberController;
//
//   @override
//   void initState() {
//     _phoneNumberController = TextEditingController();
//     _nameController = TextEditingController();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneNumberController = TextEditingController();
//     super.dispose();
//   }
//
//   _displayDialog(BuildContext context) async {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Enter Contact'),
//           actions: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(hintText: "Enter your name "),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 keyboardType: TextInputType.number,
//                 controller: _phoneNumberController,
//                 decoration:
//                     const InputDecoration(hintText: "Enter your number"),
//               ),
//             ),
//             TextButton(
//               child: const Text('Add'),
//               onPressed: () {
//                 final contact = Contact(
//                     name: _nameController.text,
//                     number: _phoneNumberController.text.toString());
//                 ContactBook().add(contact: contact);
//                 Navigator.of(context).pop();
//                 _nameController.clear();
//                 _phoneNumberController.clear();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final contactBook = ContactBook();
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Contacts'),
//       ),
//       body: ValueListenableBuilder(
//         valueListenable: ContactBook(),
//         builder: (contact, value, child) {
//           final contacts = value as List<Contact>;
//           return ListView.builder(
//             itemCount: contactBook.length,
//             itemBuilder: (context, index) {
//               final contact = contacts[index];
//               return Material(
//                 color: Colors.white,
//                 elevation: 8.00000,
//                 child: ListTile(
//                   title: Text(contact.name),
//                   subtitle: Text(contact.number.toString()),
//                   leading: const Icon(Icons.shopping_bag),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.delete),
//                     onPressed: () {
//                       ContactBook().remove(contact: contact);
//                     },
//                   ),
//                 ),
//                 );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () {
//           _displayDialog(context);
//         },
//       ),
//     );
//   }
// }
