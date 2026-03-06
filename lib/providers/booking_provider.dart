import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:room_booking_app/models/booking_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingProvider with ChangeNotifier {
  List<BookingModel> _bookings = [];
  List<BookingModel> get bookings => _bookings;

  void addBookings(BookingModel booking){
    _bookings.insert(0, booking);
    saveBookings();
    notifyListeners();
  }

  bool isRoomAvailable(String roomId, DateTime start, DateTime end){
    for (var booking in _bookings){

      if(booking.roomId == roomId){

        if(start.isBefore(booking.endDate) && end.isAfter(booking.startDate)){
          return false;
        }
      }
    }
    return true;
  }

  Future saveBookings() async {

  final prefs = await SharedPreferences.getInstance();

  List<String> bookingList = _bookings.map((booking) {
    return jsonEncode({
      "userEmail": booking.userEmail,
      "roomId": booking.roomId,
      "roomName": booking.roomName,
      "roomImage": booking.roomImage,
      "startDate": booking.startDate.toIso8601String(),
      "endDate": booking.endDate.toIso8601String(),
    });
  }).toList();

  prefs.setStringList("bookings", bookingList);
}

Future loadBookings() async {

  final prefs = await SharedPreferences.getInstance();

  final bookingList = prefs.getStringList("bookings");

  if(bookingList != null){

    _bookings = bookingList.map((item){

      final decoded = jsonDecode(item);

      return BookingModel(
        userEmail: decoded["userEmail"] ?? "",
        roomId: decoded["roomId"],
        roomName: decoded["roomName"],
        roomImage: decoded["roomImage"] ?? "",
        startDate: DateTime.parse(decoded["startDate"]),
        endDate: DateTime.parse(decoded["endDate"]),
      );

    }).toList();
    _bookings.sort((a, b) => b.startDate.compareTo(a.startDate));

    notifyListeners();
  }
}
}