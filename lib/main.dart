import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: ApiProvider(api: Api(), child: const HomePage()),
    ),
  );
}

class ApiProvider extends InheritedWidget {
  final Api api;
  final String uuid;

  ApiProvider({Key? key, required this.api, required Widget child})
      : uuid = const Uuid().v4(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant ApiProvider oldWidget) {
    // TODO: implement updateShouldNotify
    return uuid != oldWidget.uuid;
  }

  static ApiProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ApiProvider>()!;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueKey _textKey = const ValueKey<String?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(ApiProvider.of(context).api.dateAndTime ?? ''),
      ),
      body: GestureDetector(
        onTap: () async {
          final api = ApiProvider.of(context).api;
          final dateAndTime = await api.getDateAndTime();
          setState(() {
            _textKey = ValueKey(dateAndTime);
          });
        },
        child: SizedBox.expand(
          child: Container(
            child: DateTimeWidget(
              key: _textKey,
            ),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final api = ApiProvider.of(context).api;
    return Text(api.dateAndTime ?? 'Tap on screen to fetch data and time');
  }
}

class Api {
  String? dateAndTime;

  Future<String> getDateAndTime() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => DateTime.now().toIso8601String(),
    ).then((value) {
      dateAndTime = value;
      return value;
    });
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
