import 'package:flutter/material.dart';

class EditNameDialog extends StatelessWidget {
  final String currentName;
  final Function(String) onNameSaved;

  const EditNameDialog({
    required this.currentName,
    required this.onNameSaved,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: currentName);

    return AlertDialog(
      title: const Text('Edit Name'),
      content: TextField(
        controller: nameController,
        decoration: InputDecoration(
          hintText: 'Enter new name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final newName = nameController.text.trim();
            if (newName.isNotEmpty) {
              onNameSaved(newName);
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
