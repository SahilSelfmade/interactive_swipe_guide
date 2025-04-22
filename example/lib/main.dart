import 'package:flutter/material.dart';
import 'package:interactive_swipe_guide/interactive_swipe_guide.dart';

void main() {
  runApp(MaterialApp(home: MyHomePage()));
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Swipe Tutorial Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Trigger the swipe tutorial overlay
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return InteractiveSwipeGuide(
                  directions: ['left', 'right', 'up', 'down'],
                  directionText: {
                    'left': 'Swipe left to dislike',
                    'right': 'Swipe right to like',
                    'up': 'Swipe up to boost',
                    'down': 'Swipe down to skip',
                  },
                  directionAsset: {
                    'left': 'assets/animations/left.json', // Lottie
                    'right': 'assets/animations/right.json', // GIF
                    'up': 'assets/animations/right.json', // SVG
                    'down': 'assets/animations/left.json', // GIF
                  },
                  iconWidth: 150, // Custom icon width
                  iconHeight: 150, // Custom icon height
                  showText: true,
                  showButtons: true,
                );
              },
            );
          },
          child: Text('Start Tutorial'),
        ),
      ),
    );
  }
}
