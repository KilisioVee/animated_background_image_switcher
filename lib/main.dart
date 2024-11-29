import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormWithChangingBackground(),
    );
  }
}

class FormWithChangingBackground extends StatefulWidget {
  @override
  _FormWithChangingBackgroundState createState() =>
      _FormWithChangingBackgroundState();
}

class _FormWithChangingBackgroundState
    extends State<FormWithChangingBackground> {
  final List<String> _images = [
    'assets/sliderone.png',
    'assets/slidertwo.png',
    'assets/sliderthree.png',
  ];

  int _currentImageIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Set a timer to periodically change the background image
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _currentImageIndex =
            (_currentImageIndex + 1) % _images.length; // Cycle through images
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          fit: StackFit.expand,
          children: [
      // Background images with fade transition
      AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: Container(
        key: ValueKey<int>(_currentImageIndex),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_images[_currentImageIndex]),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
    // Overlay to dim the background (optional)
    Container(
    color: Colors.black.withOpacity(0.4), // Add a dim effect
    ),
    // Form content
    Positioned(
      bottom:100,
    left:20,right:20,
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32.0),
    child: Card(
    color: const Color(0xff1E3E62),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
    ),
    elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                color:Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              style: const TextStyle(
                color:Colors.white,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  color:Colors.white,
                  fontWeight: FontWeight.bold,
                ),

                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              style: const TextStyle(
                color:Colors.white,
                fontWeight: FontWeight.bold,
              ),
              obscureText: true,
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  color:Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle form submission
                 if (kDebugMode) {
                   print("Login Button Pressed");
                 }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFF6500),
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text('Login',style:TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    ),
    ),
    ),
          ],
      ),
    );
  }
}

