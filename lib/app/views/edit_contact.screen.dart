import 'package:flutter/material.dart';

class EditContactScreen extends StatefulWidget {
  const EditContactScreen({
    super.key,
    required this.contact,
    required this.contactIndex,
    required this.onEditContact,
    required this.onDeleteContact,
  });

  final Map<String, String> contact;
  final int contactIndex;
  final Function(int, Map<String, String>) onEditContact;
  final Function(int) onDeleteContact;

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController imageURLController;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    imageURLController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.contact['name']);
    phoneController = TextEditingController(text: widget.contact['phone']);
    imageURLController = TextEditingController(
      text: widget.contact['imageUrl'],
    );
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      final contactData = {
        'name': nameController.text,
        'phone': phoneController.text,
        'imageUrl': imageURLController.text,
      };

      widget.onEditContact(widget.contactIndex, contactData);
      viewSnackBar(
        '${widget.contact['name']} updated successfully!',
        Colors.greenAccent,
      );

      nameController.clear();
      phoneController.clear();
      imageURLController.clear();

      Navigator.pop(context);
    }
  }

  void showDeleteConfirm() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Contact'),
        content: Text(
          'Are you sure you want to delete ${widget.contact['name']}?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              deleteContact();
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void deleteContact() {
    // Add callback for onDeleteContact
    widget.onDeleteContact(widget.contactIndex);
    // Show success message
    viewSnackBar('${widget.contact['name']} deleted successfully!', Colors.red);
    Navigator.pop(context); // Close the dialog
    Navigator.pop(context); // Go back to previous screen
  }

  void viewSnackBar(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Contact',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a phone number';
                  }
                  if (!RegExp(r'^\d{7,15}$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter an image URL';
                  }
                  try {
                    Uri.parse(value);
                  } catch (e) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
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
                  submitForm();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.edit), Text('Save Changes')],
                ),
              ),
              const SizedBox(height: 32),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 32,
                  ),
                  foregroundColor: Colors.red,
                ),
                onPressed: () {
                  showDeleteConfirm();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.delete), Text('Delete Contact')],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
