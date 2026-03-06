class BookingModel {
  final String userEmail;
  final String roomId;
  final String roomName;
  final String roomImage;
  final DateTime startDate;
  final DateTime endDate;

  BookingModel({
     required this.userEmail,
    required this.roomId,
    required this.roomName,
    required this.roomImage,
    required this.startDate,
    required this.endDate
  });
}