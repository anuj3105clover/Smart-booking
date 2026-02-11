import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const SmartBookingApp());
}

class SmartBookingApp extends StatelessWidget {
  const SmartBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Booking NCR',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      home: const DashboardScreen(),
    );
  }
}

/* ----------------------------- DASHBOARD ----------------------------- */

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  final List<Map<String, dynamic>> services = const [
    {"title": "Restaurants", "icon": Icons.restaurant},
    {"title": "Pubs & Bars", "icon": Icons.local_bar},
    {"title": "Wine Shops", "icon": Icons.wine_bar},
    {"title": "Medical Shops", "icon": Icons.local_pharmacy},
    {"title": "Hospitals (Gov & Pvt)", "icon": Icons.local_hospital},
    {"title": "Ration Shops", "icon": Icons.store},
    {"title": "Grocery Stores", "icon": Icons.shopping_cart},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Booking - Delhi NCR"),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: services.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          final service = services[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookingScreen(
                    serviceName: service["title"],
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black12,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    service["icon"],
                    size: 40,
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    service["title"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/* ----------------------------- BOOKING SCREEN ----------------------------- */

class BookingScreen extends StatefulWidget {
  final String serviceName;

  const BookingScreen({super.key, required this.serviceName});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int timeLeft = 900; // 15 min timer
  Timer? timer;
  bool bookingActive = false;
  double bookingAmount = 500; // example price
  double founderCommission = 0;

  void startBooking() {
    founderCommission = bookingAmount * 0.10;

    setState(() {
      bookingActive = true;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return "$minutes:${secs.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void simulatePayment() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Payment Successful"),
        content: Text(
          "Booking Confirmed!\n\n"
          "Booking Amount: ₹$bookingAmount\n"
          "Founder Commission (10%): ₹$founderCommission",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.serviceName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              "Book Seat / Takeaway / Appointment",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
              ),
              onPressed: startBooking,
              child: const Text("Book Now"),
            ),
            const SizedBox(height: 30),
            if (bookingActive)
              Column(
                children: [
                  const Text("Time Remaining"),
                  const SizedBox(height: 10),
                  Text(
                    formatTime(timeLeft),
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: simulatePayment,
                    child: const Text("Proceed to Payment"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
