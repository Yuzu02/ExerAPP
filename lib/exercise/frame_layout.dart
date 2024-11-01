import 'package:flutter/material.dart';

class FrameLayoutExample extends StatefulWidget {
  const FrameLayoutExample({super.key});

  @override
  FrameLayoutExampleState createState() => FrameLayoutExampleState();
}

class FrameLayoutExampleState extends State<FrameLayoutExample> {
  bool _isButtonVisible = true;

  void _toggleVisibility() {
    setState(() {
      _isButtonVisible = !_isButtonVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Frame Layout Example")),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (!_isButtonVisible)
              Image(
                image: AssetImage('assets/images/flutter_logo.png'),
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            if (_isButtonVisible)
              ElevatedButton(
                onPressed: _toggleVisibility,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
                child: const Text(
                  'Ocultar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
