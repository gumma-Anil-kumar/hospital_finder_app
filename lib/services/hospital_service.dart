class HospitalService {
  // Guaranteed working mock data
  Future<List<Map<String, dynamic>>> getMockHospitals() async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulate network delay
    
    return [
      {
        'name': 'Numbur Multispeciality Hospital (DEMO)',
        'vicinity': '123 Main Road, Demo City',
        'rating': 4.5,
        'user_ratings_total': 128,
        'geometry': {'location': {'lat': 0, 'lng': 0}},
      },
      {
        'name': 'City General Hospital (DEMO)',
        'vicinity': '456 Health Street, Testville',
        'rating': 4.2,
        'user_ratings_total': 95,
        'geometry': {'location': {'lat': 0, 'lng': 0}},
      },
      // Add more hospitals if needed
    ];
  }

  Future<List<Map<String, dynamic>>> getRecommendedHospitals(String healthIssue) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // This is mock logic - in a real app you would:
    // 1. Query a medical database
    // 2. Filter by specialty
    // 3. Sort by relevance to the health issue
    
    final allHospitals = await getMockHospitals();
    
    // Mock recommendation logic based on health issue
    return allHospitals.where((hospital) {
      final name = hospital['name'].toString().toLowerCase();
      final issue = healthIssue.toLowerCase();
      
      // Simple mock filtering - real app would use proper medical specialties
      if (issue.contains('heart') || issue.contains('chest')) {
        return name.contains('heart') || name.contains('cardiac');
      } else if (issue.contains('fracture')) {
        return name.contains('ortho') || name.contains('bone');
      } else if (issue.contains('diabetes')) {
        return name.contains('diabetes') || name.contains('endocrine');
      }
      return true; // Return all if no specific match
    }).toList();
  }
}