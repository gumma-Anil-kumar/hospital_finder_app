import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RatingWidget extends StatefulWidget {
  final String hospitalId;
  final double? initialRating;
  
  const RatingWidget({
    super.key,
    required this.hospitalId,
    this.initialRating,
  });

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  double? _userRating;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _loadUserRating();
  }

  Future<void> _loadUserRating() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('hospital_ratings')
        .doc('${widget.hospitalId}_${user.uid}')
        .get();

    if (snapshot.exists) {
      setState(() {
        _userRating = snapshot.data()?['rating']?.toDouble();
      });
    }
  }

  Future<void> _submitRating(double rating) async {
    setState(() => _submitting = true);
    
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please login to rate')),
        );
        return;
      }

      final batch = FirebaseFirestore.instance.batch();

      // Update user's rating
      batch.set(
        FirebaseFirestore.instance
            .collection('hospital_ratings')
            .doc('${widget.hospitalId}_${user.uid}'),
        {'rating': rating},
      );

      // Update hospital's aggregate rating
      final hospitalRef = FirebaseFirestore.instance
          .collection('hospitals')
          .doc(widget.hospitalId);

      batch.update(hospitalRef, {
        'rating': FieldValue.increment((rating - (_userRating ?? 0))),
        'ratingCount': FieldValue.increment(_userRating == null ? 1 : 0),
      });

      await batch.commit();

      setState(() {
        _userRating = rating;
        _submitting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rating submitted!')),
      );
    } catch (e) {
      setState(() => _submitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rate this hospital:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [1, 2, 3, 4, 5].map((star) {
            return IconButton(
              icon: Icon(
                (_userRating ?? 0) >= star ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: _submitting
                  ? null
                  : () => _submitRating(star.toDouble()),
            );
          }).toList(),
        ),
        if (_userRating != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'You rated this ${_userRating!.toStringAsFixed(1)} stars',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
      ],
    );
  }
}