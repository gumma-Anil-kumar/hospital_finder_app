import 'package:flutter/material.dart';

class HealthIssuePage extends StatefulWidget {
  const HealthIssuePage({super.key});

  @override
  State<HealthIssuePage> createState() => _HealthIssuePageState();
}

class _HealthIssuePageState extends State<HealthIssuePage> {
  final TextEditingController _controller = TextEditingController();
  String? _selectedIssue;

  final List<String> commonIssues = [
    'Fever',
    'Cough',
    'Headache',
    'Chest pain',
    'Stomach ache',
    'Fracture',
    'Heart problems',
    'Diabetes',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Describe Your Health Issue'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Common health issues:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: commonIssues.map((issue) {
                return FilterChip(
                  label: Text(issue),
                  selected: _selectedIssue == issue,
                  onSelected: (selected) {
                    setState(() {
                      _selectedIssue = selected ? issue : null;
                      _controller.text = issue;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Or describe your health issue',
                border: OutlineInputBorder(),
                hintText: 'e.g., persistent headache, chest pain, etc.',
              ),
              maxLines: 3,
              onChanged: (value) {
                setState(() {
                  if (!commonIssues.contains(value)) {
                    _selectedIssue = null;
                  }
                });
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _controller.text.trim().isEmpty
                    ? null
                    : () {
                        // Navigate to results page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NearbyHospitalsPage(
                              healthIssue: _controller.text.trim(),
                            ),
                          ),
                        );
                      },
                child: const Text('Find Recommended Hospitals'),
              ),
            ),
            const Spacer(),
            const Align(
              alignment: Alignment.bottomRight,
              child: Text('Sunset 6:38 pm'),
            ),
          ],
        ),
      ),
    );
  }
}

// Temporary placeholder for the results page
class NearbyHospitalsPage extends StatelessWidget {
  final String healthIssue;

  const NearbyHospitalsPage({super.key, required this.healthIssue});

  // Hardcoded hospital data based on health issues
  List<Map<String, dynamic>> _getHospitalsForIssue(String issue) {
    issue = issue.toLowerCase();
    
    final allHospitals = [
      {
        'name': 'City Neurology Center',
        'address': '123 Brain Avenue, Headache Town',
        'rating': 4.6,
        'specialty': 'headache',
        'distance': '1.2 km',
      },
      {
        'name': 'General Medical Hospital',
        'address': '456 Health Street',
        'rating': 4.2,
        'specialty': 'general',
        'distance': '2.5 km',
      },
      {
        'name': 'Cardiac Care Center',
        'address': '789 Heart Lane',
        'rating': 4.8,
        'specialty': 'chest pain',
        'distance': '3.1 km',
      },
      {
        'name': 'Gastro Health Clinic',
        'address': '321 Stomach Road',
        'rating': 4.3,
        'specialty': 'stomach ache',
        'distance': '1.8 km',
      },
      {
        'name': 'Ortho Specialists',
        'address': '654 Bone Boulevard',
        'rating': 4.5,
        'specialty': 'fracture',
        'distance': '2.2 km',
      },
    ];

    // Filter hospitals based on the health issue
    return allHospitals.where((hospital) {
      if (issue.contains('headache') || issue.contains('migraine')) {
        return hospital['specialty'] == 'headache';
      } else if (issue.contains('chest') || issue.contains('heart')) {
        return hospital['specialty'] == 'chest pain';
      } else if (issue.contains('stomach')) {
        return hospital['specialty'] == 'stomach ache';
      } else if (issue.contains('fracture') || issue.contains('bone')) {
        return hospital['specialty'] == 'fracture';
      }
      return true; // Show all hospitals if no specific match
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final hospitals = _getHospitalsForIssue(healthIssue);

    return Scaffold(
      appBar: AppBar(title: Text('Hospitals for: $healthIssue')),
      body: hospitals.isEmpty
          ? const Center(child: Text('No hospitals found for this issue'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: hospitals.length,
              itemBuilder: (context, index) {
                final hospital = hospitals[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hospital['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(hospital['address']),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            Text(' ${hospital['rating']}'),
                            const Spacer(),
                            Text(hospital['distance']),
                            const Icon(Icons.directions, color: Colors.blue),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}