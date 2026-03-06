import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:room_booking_app/providers/auth_provider.dart';
import 'package:room_booking_app/utils/helpers.dart';
import 'package:room_booking_app/widgets/primary_button.dart';

import '../models/booking_model.dart';
import '../models/room_model.dart';
import '../providers/booking_provider.dart';

class RoomDetailScreen extends StatefulWidget {
  final RoomModel room;

  const RoomDetailScreen({super.key, required this.room});

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  DateTime? startDate;
  DateTime? endDate;

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  Future pickStartDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() {
        startDate = date;
      });
    }
  }

  Future pickEndDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() {
        endDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen:false);
    final currentUserEmail = authProvider.userEmail;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text(widget.room.name)),

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: screenWidth > 600 ? 500 : double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.room.image,
                    width: double.infinity,
                    height: screenWidth * 0.4,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 180,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  widget.room.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  widget.room.description,
                  style: TextStyle(color: Colors.grey[700], height: 1.5),
                ),

                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: pickStartDate,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo.shade100,
                        ),
                        child: Text(
                          startDate == null
                              ? "Start Date"
                              : formatDate(startDate!),
                          style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: pickEndDate,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo.shade100,
                        ),
                        child: Text(
                          endDate == null ? "End Date" : formatDate(endDate!),
                          style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Center(
                  child: SizedBox(
                    width: screenWidth > 600 ? 350 : double.infinity,
                    child: PrimaryButton(
                      title: "Book Room",
                      onPressed: () {
                        if (startDate == null || endDate == null) {
                          showMessage(context, "Please select Date");
                    
                          return;
                        }
                    
                        if (!bookingProvider.isRoomAvailable(
                          widget.room.id,
                          startDate!,
                          endDate!,
                        )) {
                          showMessage(context, "Rooms not available");
                    
                          return;
                        }
                    
                        bookingProvider.addBookings(
                          BookingModel(
                            userEmail: currentUserEmail ?? "",
                            roomId: widget.room.id,
                            roomName: widget.room.name,
                            roomImage: widget.room.image,
                            startDate: startDate!,
                            endDate: endDate!,
                          ),
                        );
                    
                        showMessage(context, "Booking Sucessful");
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
