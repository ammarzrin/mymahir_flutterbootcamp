import 'package:flutter/material.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key, required this.onAddContact});
  final Function(Map<String, String>) onAddContact;

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final formKey = GlobalKey();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final imageURLController = TextEditingController(
    text: // adding a default image URL
        'https://a0.anyrgb.com/pngimg/1600/696/user-login-linux-kernel-answer-user-profile-chen-account-login-github-thumbnail-avatar.png',
  );

  @override
  // whenever leave the screen, clean up the controllers, clear the memory
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    imageURLController.dispose();
    super.dispose();
  }

  void submitForm() {
    final contactData = {
      'name': nameController.text,
      'phone': phoneController.text,
      'imageUrl': imageURLController.text,
      // 'imageUrl':
      //     'https://a0.anyrgb.com/pngimg/1600/696/user-login-linux-kernel-answer-user-profile-chen-account-login-github-thumbnail-avatar.png',
    };

    widget.onAddContact(contactData);

    nameController.clear();
    phoneController.clear();
    imageURLController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Contact',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter contact name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter phone number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.call),
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: imageURLController,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                  hintText: 'Enter image URL',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.add_link),
                ),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 32,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // Logic to save the new contact can be added here
                  submitForm();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.edit), Text('Save Contact')],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
