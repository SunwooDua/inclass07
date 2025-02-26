import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: FadingTextAnimation(
        isDarkMode: isDarkMode,
        toggleDarkMode: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
      ),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  final bool isDarkMode;
  final Function toggleDarkMode;

  FadingTextAnimation({required this.isDarkMode, required this.toggleDarkMode});

  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  Color textColor = Colors.black;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  // show simple color picker
  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pick a color', style: TextStyle(fontSize: 22)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _colorOption(Colors.red),
                  _colorOption(Colors.blue),
                  _colorOption(Colors.green),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _colorOption(Colors.yellow),
                  _colorOption(Colors.purple),
                  _colorOption(Colors.orange),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(fontSize: 18)),
            ),
          ],
        );
      },
    );
  }

  // helper for color selection
  Widget _colorOption(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          textColor = color;
        });
        Navigator.of(context).pop();
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey, width: 2), // Added border
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
        actions: [
          // color picker button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.color_lens, size: 30),
              onPressed: _showColorPicker,
              tooltip: 'Change text color',
              iconSize: 36,
            ),
          ),
          // dark mode toggle
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                size: 30,
              ),
              onPressed: () {
                widget.toggleDarkMode();
              },
              tooltip: widget.isDarkMode ? 'Light Mode' : 'Dark Mode',
              iconSize: 36,
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: GestureDetector(
          //clicking text changes opacity too
          onTap: toggleVisibility,
          child: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: Duration(seconds: 2), //changed duration
            curve: Curves.easeInOut, //added curve
            child: Text(
              'This will disappear!', //changed text
              style: TextStyle(
                fontSize: 24,
                color: textColor, // use the selected color
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
