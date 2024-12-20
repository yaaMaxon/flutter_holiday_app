import 'package:flutter/material.dart';

class HolidayList extends StatelessWidget {
  final List<Map<String, dynamic>> holidays;

  const HolidayList({Key? key, required this.holidays}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: holidays.length,
      itemBuilder: (context, index) {
        final String title = holidays[index]['title']?.toString() ?? 'No Title';
        final String date = holidays[index]['date']?.toString() ?? 'No Date';
        final String notes = holidays[index]['notes']?.toString() ?? 'No Notes';

        return Card(
          margin: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 5.0,
          ),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[900],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Date: $date',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
                if (notes.isNotEmpty)
                  Text(
                    'Notes: $notes',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
