import 'package:flutter/material.dart';

void main() {
  runApp(SmartBookingApp());
}

class SmartBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> categories = [
    "Restaurants",
    "Pubs",
    "Medical Shops",
    "Wine Shops",
    "Ration Stores",
    "Groceries"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Booking - Delhi NCR"),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(12),
            child: ListTile(
              title: Text(categories[index]),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // placeholder for future navigation
              },
            ),
          );
        },
      ),
    );
  }
}
