import 'package:flutter/material.dart';
import '../services/hospital_service.dart';
import '../widgets/hospital_card.dart';

class RecommendedHospitalsScreen extends StatefulWidget {
  final String healthIssue;

  const RecommendedHospitalsScreen({super.key, required this.healthIssue});

  @override
  State<RecommendedHospitalsScreen> createState() => _RecommendedHospitalsScreenState();
}

class _RecommendedHospitalsScreenState extends State<RecommendedHospitalsScreen> {
  late List<Map<String, dynamic>> _hospitals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHospitals();
  }

  Future<void> _loadHospitals() async {
    try {
      // Get hardcoded hospitals immediately
      final hospitals = await _getHardcodedHospitals();
      setState(() {
        _hospitals = hospitals;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<List<Map<String, dynamic>>> _getHardcodedHospitals() async {
    // Guaranteed working dummy data
    return [
      {
        'name': 'City Neurology Center',
        'vicinity': '123 Brain Avenue, Headache Town',
        'rating': 4.6,
        'user_ratings_total': 85,
        'geometry': {'location': {'lat': 12.9716, 'lng': 77.5946}},
      },
      {
        'name': 'Headache Relief Hospital',
        'vicinity': '456 Pain Free Road',
        'rating': 4.3,
        'user_ratings_total': 120,
        'geometry': {'location': {'lat': 12.9720, 'lng': 77.5950}},
      },
      {
        'name': 'Neuro Care Specialists',
        'vicinity': '789 Migraine Lane',
        'rating': 4.8,
        'user_ratings_total': 64,
        'geometry': {'location': {'lat': 12.9700, 'lng': 77.5930}},
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospitals for: ${widget.healthIssue}'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hospitals.isEmpty
              ? const Center(child: Text('No hospitals found'))
              : ListView.builder(
                  itemCount: _hospitals.length,
                  itemBuilder: (context, index) {
                    return HospitalCard(
                      hospitalData: _hospitals[index],
                      googleApiKey: 'mock_key',
                    );
                  },
                ),
    );
  }
}