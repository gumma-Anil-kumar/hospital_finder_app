import 'package:flutter/material.dart';
import '../services/hospital_service.dart';
import '../widgets/hospital_card.dart';

class HospitalsScreen extends StatefulWidget {
  const HospitalsScreen({Key? key}) : super(key: key);

  @override
  State<HospitalsScreen> createState() => _HospitalsScreenState();
}

class _HospitalsScreenState extends State<HospitalsScreen> {
  late Future<List<Map<String, dynamic>>> _hospitalsFuture;
  final HospitalService _service = HospitalService();

  @override
  void initState() {
    super.initState();
    _hospitalsFuture = _service.getMockHospitals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Hospitals')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _hospitalsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final hospitals = snapshot.data ?? [];
          
          if (hospitals.isEmpty) {
            return const Center(child: Text('No hospitals found'));
          }

          return ListView.builder(
            itemCount: hospitals.length,
            itemBuilder: (context, index) {
              return HospitalCard(
                hospitalData: hospitals[index],
                googleApiKey: 'mock_key',
              );
            },
          );
        },
      ),
    );
  }
}