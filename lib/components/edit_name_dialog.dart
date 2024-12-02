// import 'package:flutter/material.dart';

// class EditNameDialog extends StatelessWidget {
//   final String currentName;
//   final Function(String) onNameSaved;

//   const EditNameDialog({
//     required this.currentName,
//     required this.onNameSaved,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController nameController =
//         TextEditingController(text: currentName);

//     return AlertDialog(
//       title: const Text('Edit Name'),
//       content: TextField(
//         controller: nameController,
//         decoration: InputDecoration(
//           hintText: 'Enter new name',
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             final newName = nameController.text.trim();
//             if (newName.isNotEmpty) {
//               onNameSaved(newName);
//               Navigator.pop(context);
//             }
//           },
//           child: const Text('Save'),
//         ),
//       ],
//     );
//   }
// }

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
      title: Text(
        'Edit Name',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.teal[800], // Title color
        ),
      ),
      content: TextField(
        controller: nameController,
        decoration: InputDecoration(
          hintText: 'Enter new name',
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
            final newName = nameController.text.trim();
            if (newName.isNotEmpty) {
              onNameSaved(newName);
              Navigator.pop(context);
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
