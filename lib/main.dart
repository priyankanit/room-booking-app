import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_booking_app/providers/auth_provider.dart';
import 'package:room_booking_app/providers/booking_provider.dart';
import 'package:room_booking_app/providers/room_provider.dart';
import 'package:room_booking_app/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RoomProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Room Booking App',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: const AppBarTheme(
            elevation: 0,
          )
        ),
        home: LoginScreen(),
      ),
    );
  }
}

