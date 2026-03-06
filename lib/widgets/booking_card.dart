import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/booking_model.dart';

class BookingCard extends StatelessWidget {
  final BookingModel booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final days = booking.endDate.difference(booking.startDate).inDays;

    return Card(
      color: Colors.indigo.shade50,

      margin: const EdgeInsets.symmetric(vertical: 8),

      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),

      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Room name
                  Text(
                    booking.roomName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// Dates
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 6),

                      Text(
                        "${DateFormat('dd MMM yyyy').format(booking.startDate)} "
                        "- ${DateFormat('dd MMM yyyy').format(booking.endDate)}",
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  /// Duration
                  Row(
                    children: [
                      const Icon(Icons.nightlight_round, size: 16),
                      const SizedBox(width: 6),
                      Text("$days night(s) stay"),
                    ],
                  ),

                  const SizedBox(height: 6),

                  /// Status
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        "Confirmed",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),

            /// Room Image
            SizedBox(
              height: 70,
              width: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  booking.roomImage.isNotEmpty
                      ? booking.roomImage
                      : "https://picsum.photos/200",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
