import 'package:flutter/material.dart';

class EditEmailDialog extends StatelessWidget {
  final String currentEmail;
  final Function(String) onEmailSaved;

  const EditEmailDialog({
    required this.currentEmail,
    required this.onEmailSaved,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController =
        TextEditingController(text: currentEmail);

    return AlertDialog(
      title: Text(
        'Edit Email',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.teal[800], // Title color
        ),
      ),
      content: TextField(
        controller: emailController,
        decoration: InputDecoration(
          hintText: 'Enter new email',
          hintStyle: TextStyle(color: Colors.grey), // Hint text color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.teal), // Border color
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.teal, width: 2),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.teal[800], // Text color
          ),
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final newEmail = emailController.text.trim();
            if (newEmail.isNotEmpty && newEmail.contains('@')) {
              onEmailSaved(newEmail);
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Invalid email address!'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal, // Background color
            foregroundColor: Colors.white, // Text color
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Save',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
