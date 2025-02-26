import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: swipeScreen());
  }
}

class swipeScreen extends StatefulWidget {
  const swipeScreen({super.key});

  @override
  State<swipeScreen> createState() => _swipeScreenState();
}

class _swipeScreenState extends State<swipeScreen> {
  final controller = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [FadingTextAnimation(), SecondFadingAnimation()],
      ),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: GestureDetector(
          //clicking text changes opacity too
          onTap: toggleVisibility,
          child: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: Duration(seconds: 1), //changed duration
            curve: Curves.easeInOut, //added curve
            child: const Text(
              'This will disappear!', //changed text
              style: TextStyle(fontSize: 24),
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

class SecondFadingAnimation extends StatefulWidget {
  const SecondFadingAnimation({super.key});

  @override
  State<SecondFadingAnimation> createState() => _SecondFadingAnimationState();
}

class _SecondFadingAnimationState extends State<SecondFadingAnimation> {
  bool _isVisible = true;
  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: GestureDetector(
          //clicking text changes opacity too
          onTap: toggleVisibility,
          child: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: Duration(seconds: 2), //changed duration
            curve: Curves.easeInOut, //added curve
            child: const Text(
              'Will I disappear too?', //changed text
              style: TextStyle(fontSize: 24),
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
