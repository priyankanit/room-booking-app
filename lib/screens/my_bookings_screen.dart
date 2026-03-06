import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_booking_app/providers/auth_provider.dart';

import '../providers/booking_provider.dart';
import '../widgets/booking_card.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final currentUserEmail = authProvider.userEmail;

    final userBookings = bookingProvider.bookings
    .where((booking) => booking.userEmail == currentUserEmail)
    .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Bookings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          // Booking summary
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.indigo.withOpacity(0.1),
            child: Text(
              "Total Bookings: ${userBookings.length}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 10),

          // Booking List
          Expanded(
            child:
                userBookings.isEmpty
                    ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.hotel_outlined,
                            size: 60,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "No bookings yet",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: userBookings.length,

                      itemBuilder: (context, index) {
                        return BookingCard(
                          booking: userBookings[index],
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
