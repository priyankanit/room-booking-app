import 'package:flutter/material.dart';
import 'package:room_booking_app/data/mock_rooms.dart';
import 'package:room_booking_app/models/room_model.dart';

class RoomProvider with ChangeNotifier{

List<RoomModel> _rooms = [];

  List<RoomModel> get rooms => _rooms;

  void loadRooms(){
    _rooms = mockRooms;
    notifyListeners();
  }
}