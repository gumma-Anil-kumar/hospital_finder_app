class Hospital {
  final String id;
  final String name;
  final String address;
  final double? rating;
  final int? userRatingsTotal;
  final double latitude;
  final double longitude;
  final String? placeId;
  final String? photoReference;
  final String? phoneNumber;

  Hospital({
    required this.id,
    required this.name,
    required this.address,
    this.rating,
    this.userRatingsTotal,
    required this.latitude,
    required this.longitude,
    this.placeId,
    this.photoReference,
    this.phoneNumber,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      id: json['place_id'] ?? json['id'] ?? '',
      name: json['name'] ?? 'Unknown Hospital',
      address: json['vicinity'] ?? json['formatted_address'] ?? 'Address not available',
      rating: json['rating']?.toDouble(),
      userRatingsTotal: json['user_ratings_total'],
      latitude: (json['geometry']?['location']?['lat'] ?? 0.0).toDouble(),
      longitude: (json['geometry']?['location']?['lng'] ?? 0.0).toDouble(),
      placeId: json['place_id'],
      photoReference: json['photos'] != null && json['photos'].isNotEmpty 
          ? json['photos'][0]['photo_reference'] 
          : null,
      phoneNumber: json['formatted_phone_number'],
    );
  }
}