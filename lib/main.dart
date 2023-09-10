import 'package:flutter/material.dart';
import 'package:app/screens/hotel_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'HotelApp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'SFProDisplay',
            useMaterial3: true,
            colorScheme: const ColorScheme.light(),
            dividerColor: Colors.transparent),
        home: const HotelScreen());
  }
}
