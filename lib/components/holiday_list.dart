import 'package:flutter/material.dart';

class HolidayList extends StatelessWidget {
  final Future<List<Map<String, dynamic>>> holidaysFuture;

  const HolidayList({required this.holidaysFuture, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: holidaysFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final holidays = snapshot.data!;
          return ListView.builder(
            itemCount: holidays.length,
            itemBuilder: (context, index) {
              final String title =
                  holidays[index]['title']?.toString() ?? 'No Title';
              final String date =
                  holidays[index]['date']?.toString() ?? 'No Date';
              final String notes =
                  holidays[index]['notes']?.toString() ?? 'No Notes';

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
        return const Center(child: Text('No holidays available'));
      },
    );
  }
}
