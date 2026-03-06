import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_booking_app/providers/auth_provider.dart';
import 'package:room_booking_app/screens/dashboard_screen.dart';
import 'package:room_booking_app/widgets/primary_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
  child: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const Icon(
                Icons.hotel,
                size: 60,
                color: Colors.indigo,
              ),

              const SizedBox(height: 10),

              const Text(
                "Room Booking",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email,
                  color: Colors.indigo,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock,
                  color: Colors.indigo,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              PrimaryButton(
                title: "Login",
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false)
                      .login(emailController.text, passwordController.text);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DashboardScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ),
  ),
),
    );
  }
}
