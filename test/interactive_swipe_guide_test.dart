// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:interactive_swipe_guide/interactive_swipe_guide.dart';

// void main() {
//   group('SwipeableTutorial Widget', () {
//     testWidgets('renders with initial state', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           home: InteractiveSwipeGuide(
//             texts: {
//               'left': 'Left Swipe',
//               'right': 'Right Swipe',
//               'up': 'Up Swipe',
//               'down': 'Down Swipe',
//             },
//             media: {
//               'left': 'assets/lottie/left.json',
//               'right': 'assets/lottie/right.png',
//               'up': 'assets/lottie/left.png',
//               'down': 'assets/images/image.png',
//             },
//           ),
//         ),
//       );

//       expect(find.textContaining('Swipe'), findsOneWidget);
//     });

//     testWidgets('swipe right triggers onSwipeRight', (WidgetTester tester) async {
//       bool rightSwiped = false;

//       await tester.pumpWidget(
//         MaterialApp(
//           home: SwipeableTutorial(
//             texts: {'right': 'Right Swipe'},
//             media: {'right': 'assets/lottie/right.json'},
//             onSwipeRight: () {
//               rightSwiped = true;
//             },
//           ),
//         ),
//       );

//       final gesture = await tester.startGesture(const Offset(100, 300));
//       await gesture.moveBy(const Offset(200, 0)); // Swipe right
//       await gesture.up();
//       await tester.pumpAndSettle();

//       expect(rightSwiped, isTrue);
//     });

//     testWidgets('swipe left triggers onSwipeLeft', (WidgetTester tester) async {
//       bool leftSwiped = false;

//       await tester.pumpWidget(
//         MaterialApp(
//           home: SwipeableTutorial(
//             texts: {'left': 'Left Swipe'},
//             media: {'left': 'assets/lottie/left.json'},
//             onSwipeLeft: () {
//               leftSwiped = true;
//             },
//           ),
//         ),
//       );

//       final gesture = await tester.startGesture(const Offset(300, 300));
//       await gesture.moveBy(const Offset(-200, 0)); // Swipe left
//       await gesture.up();
//       await tester.pumpAndSettle();

//       expect(leftSwiped, isTrue);
//     });

//     testWidgets('swipe up triggers onSwipeUp', (WidgetTester tester) async {
//       bool upSwiped = false;

//       await tester.pumpWidget(
//         MaterialApp(
//           home: SwipeableTutorial(
//             texts: {'up': 'Up Swipe'},
//             media: {'up': 'assets/lottie/left.json'},
//             onSwipeUp: () {
//               upSwiped = true;
//             },
//           ),
//         ),
//       );

//       final gesture = await tester.startGesture(const Offset(200, 300));
//       await gesture.moveBy(const Offset(0, -200)); // Swipe up
//       await gesture.up();
//       await tester.pumpAndSettle();

//       expect(upSwiped, isTrue);
//     });

//     testWidgets('swipe down triggers onSwipeDown', (WidgetTester tester) async {
//       bool downSwiped = false;

//       await tester.pumpWidget(
//         MaterialApp(
//           home: SwipeableTutorial(
//             texts: {'down': 'Down Swipe'},
//             media: {'down': 'assets/images/image.png'},
//             onSwipeDown: () {
//               downSwiped = true;
//             },
//           ),
//         ),
//       );

//       final gesture = await tester.startGesture(const Offset(200, 300));
//       await gesture.moveBy(const Offset(0, 200)); // Swipe down
//       await gesture.up();
//       await tester.pumpAndSettle();

//       expect(downSwiped, isTrue);
//     });
//   });
// }
