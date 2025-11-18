import 'package:flutter/material.dart';
import 'package:myflutter_nov2025/app/views/add_contact.screen.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  // This places all data pulling and functions related to this screen

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final List<Map<String, String>> contacts = [
    {
      'name': 'Scarlett Johansson',
      'phone': '+60 19-123-4567',
      'imageUrl':
          'https://i.pinimg.com/474x/00/0e/74/000e7471853c3e154589cb5f1e644bd9.jpg',
    },
    {
      'name': 'Robert Downey Jr.',
      'phone': '+60 17-987-6543',
      'imageUrl':
          'https://i.pinimg.com/736x/74/e7/cb/74e7cb1383beef93f7d4392edc8a80bc.jpg',
    },
    {
      'name': 'Chris Evans',
      'phone': '+60 12-345-6789',
      'imageUrl':
          'https://www.pngplay.com/wp-content/uploads/6/Chris-Evans-Actor-Transparent-Free-PNG.png',
    },
  ];

  void addNewContact(Map<String, String> contactData) {
    setState(() {
      contacts.add(contactData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'My Contacts',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ContactItem(contact: contact);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action to add a new contact
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddContactScreen(onAddContact: addNewContact),
            ),
          );
        },
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  const ContactItem({super.key, required this.contact});

  final Map<String, String> contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        contact['name']!,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(contact['phone']!),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.network(
          contact['imageUrl']!,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
