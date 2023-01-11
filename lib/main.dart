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

class Contact {
  final String name;
  final String id;

  Contact({required this.name}) : id = const Uuid().v4();
}

class ContactBook extends ValueNotifier<List<Contact>> {
  ContactBook._sharedInstance() : super([Contact(name: 'Hello')]);

  static final ContactBook _shared = ContactBook._sharedInstance();

  factory ContactBook() => _shared;
  final List<Contact> _contacts = [];

  int get length => value.length;

  void add({required Contact contact}) {
    final contacts = value;

    contacts.add(contact);
    notifyListeners();
  }

  void remove({required Contact contact}) {
    final contacts = value;
    if (contacts.contains(contact)) {
      contacts.remove(contact);
      notifyListeners();
    }
  }

  Contact? contact({required int atIndex}) =>
      value.length > atIndex ? value[atIndex] : null;
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactBook = ContactBook();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Page'),
      ),
      body: ValueListenableBuilder(
        valueListenable: ContactBook(),
        builder: (contact, value, child) {
          final contacts = value as List<Contact>;
          return ListView.builder(
            itemCount: contactBook.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return Dismissible(
                onDismissed: (direction) {
                  ContactBook().remove(contact: contact);
                },
                key: ValueKey(contact.id),
                child: Material(
                  color: Colors.white,
                  elevation: 6.0,
                  child: ListTile(
                    title: Text(contact.name),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewContactView()));
        },
      ),
    );
  }
}

class NewContactView extends StatefulWidget {
  const NewContactView({Key? key}) : super(key: key);

  @override
  State<NewContactView> createState() => _NewContactViewState();
}

class _NewContactViewState extends State<NewContactView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new contact'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
                hintText: 'Enter a new contact name here...'),
          ),
          TextButton(
            onPressed: () {
              final contact = Contact(name: _controller.text);
              ContactBook().add(contact: contact);
              Navigator.pop(context);
            },
            child: const Text('Add contact'),
          ),
        ],
      ),
    );
  }
}
