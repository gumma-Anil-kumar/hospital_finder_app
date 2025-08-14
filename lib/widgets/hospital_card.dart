import 'package:flutter/material.dart';

class HospitalCard extends StatelessWidget {
  final Map<String, dynamic> hospitalData;
  final String googleApiKey;

  const HospitalCard({
    required this.hospitalData,
    required this.googleApiKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(hospitalData['name'] ?? 'Unknown Hospital'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(hospitalData['vicinity'] ?? 'No address available'),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                Text(' ${hospitalData['rating']?.toStringAsFixed(1) ?? 'N/A'}'),
                if (hospitalData['user_ratings_total'] != null)
                  Text(' (${hospitalData['user_ratings_total']})'),
              ],
            ),
          ],
        ),
        leading: const Icon(Icons.local_hospital, color: Colors.red),
      ),
    );
  }
}