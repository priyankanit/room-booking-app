import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_booking_app/providers/booking_provider.dart';
import 'package:room_booking_app/providers/room_provider.dart';
import 'package:room_booking_app/screens/my_bookings_screen.dart';
import 'package:room_booking_app/widgets/room_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void initState() {
    Future.microtask(() =>
    Provider.of<RoomProvider>(context, listen:false).loadRooms());
    Provider.of<BookingProvider>(context, listen:false).loadBookings();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final roomProvider = Provider.of<RoomProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Rooms",
        style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=> MyBookingsScreen()));
          }, 
          icon: Icon(Icons.book_rounded),
          tooltip: "My Bookings",
          color: Colors.indigo,)
        ],
      ),
      body: roomProvider.rooms.isEmpty
    ? const Center(
        child: CircularProgressIndicator(),
      )
      : ListView.builder(
        itemCount: roomProvider.rooms.length,
        itemBuilder: (context, index){
        final room = roomProvider.rooms[index];
        return RoomCard(room:room);
      }),
    );
  }
}