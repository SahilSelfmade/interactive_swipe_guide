# 🌀 interactive_swipe_guide

`interactive_swipe_guide` is a simple and customizable Flutter widget to guide users with swipe gestures. It shows animated instructions (like Lottie, SVG, or GIF) and waits for the user to swipe in the correct direction. It's perfect for onboarding, tutorials, or guiding users through gesture-based navigation in your app.

## Features

- Display swipe instructions for different directions (left, right, up, down).
- Supports animation or image (Lottie, SVG, GIF) for each direction.
- Waits for the user to swipe in the correct direction.
- Customizable instructional text for each direction.
- Includes "Next" and "Skip/Done" buttons (optional).
- Callbacks triggered when the user swipes in the correct direction or completes the guide.
- Fully customizable and works on Android, iOS, and Web.

## Getting Started

To use this package, add `interactive_swipe_guide` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  interactive_swipe_guide: ^<latest_version>



Here is a simple usage example demonstrating how to use the InteractiveSwipeGuide widget:

```dart
class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: InteractiveSwipeGuide(
      directions: ['left', 'right', 'up', 'down'],
      initialDirection: 'right',
      directionText: {
        'left': 'Swipe left to go back',
        'right': 'Swipe right to continue',
        'up': 'Swipe up for more',
        'down': 'Swipe down to skip',
      },
      directionAsset: {
        'left': 'assets/swipe_left.json',
        'right': 'assets/swipe_right.json',
        'up': 'assets/swipe_up.svg',
        'down': 'assets/swipe_down.gif',
      },
      onSwipeLeft: () => print('Left swipe complete'),
      onSwipeRight: () => print('Right swipe complete'),
      onSwipeUp: () => print('Up swipe complete'),
      onSwipeDown: () => print('Down swipe complete'),
      onDismiss: () => print('Tutorial finished'),
    )));
  }
}
```