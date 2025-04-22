import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // SVG asset support
import 'package:lottie/lottie.dart'; // Lottie animations

/// A customizable, swipe-driven onboarding or tutorial overlay.
///
/// Supports different directions (`left`, `right`, `up`, `down`) and can
/// display assets (e.g., Lottie, GIFs, SVG) with contextual instructions.
class InteractiveSwipeGuide extends StatefulWidget {
  const InteractiveSwipeGuide({
    super.key,
    required this.directions,

    // Optional: Disable specific directions
    this.disabledDirections,

    // Optional: Which direction should show first
    this.initialDirection,

    // Swipe Callbacks
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onSwipeUp,
    this.onSwipeDown,
    this.onDismiss,

    // Optional: Override texts and assets for each direction
    this.directionText,
    this.directionAsset,

    // UI Toggles
    this.showText = true,
    this.showButtons = true,

    // Button customization
    this.nextButtonText = 'NEXT',
    this.skipButtonText = 'SKIP',
    this.customNextButton,
    this.customSkipButton,

    // Icon size
    this.iconWidth = 200,
    this.iconHeight = 200,
  });

  /// List of swipe directions to walk through
  final List<String> directions;

  /// Set of directions to skip from the tutorial
  final Set<String>? disabledDirections;

  /// The first direction to display
  final String? initialDirection;

  /// Callbacks for swipe actions
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final VoidCallback? onSwipeUp;
  final VoidCallback? onSwipeDown;
  final VoidCallback? onDismiss;

  /// Optional: Text instructions for each swipe direction
  final Map<String, String>? directionText;

  /// Optional: Asset (Lottie, GIF, SVG) for each direction
  final Map<String, String>? directionAsset;

  /// Whether to show instruction text below the icon
  final bool showText;

  /// Whether to show skip and next buttons
  final bool showButtons;

  /// Text on the "Next" button
  final String nextButtonText;

  /// Text on the "Skip"/"Done" button
  final String skipButtonText;

  /// Optional: Replace the "Next" button with a custom widget
  final Widget? customNextButton;

  /// Optional: Replace the "Skip" button with a custom widget
  final Widget? customSkipButton;

  /// Width and height of the direction icon
  final double iconWidth;
  final double iconHeight;

  @override
  State<InteractiveSwipeGuide> createState() => _InteractiveSwipeGuideState();
}

class _InteractiveSwipeGuideState extends State<InteractiveSwipeGuide> {
  late List<String> filteredDirections;
  late int currentStepIndex;

  // Tracking drag distance
  double _dragOffsetX = 0;
  double _dragOffsetY = 0;

  // Minimum drag threshold to trigger swipe
  final double _dragThreshold = 100;

  @override
  void initState() {
    super.initState();

    // Remove disabled directions
    filteredDirections =
        widget.directions.where((dir) => !(widget.disabledDirections ?? {}).contains(dir)).toList();

    // Start from initialDirection if specified
    currentStepIndex =
        widget.initialDirection != null ? filteredDirections.indexOf(widget.initialDirection!) : 0;

    // Fallback to 0 if initial direction isn't found
    if (currentStepIndex == -1) currentStepIndex = 0;
  }

  /// Current direction being displayed
  String get currentDirection => filteredDirections[currentStepIndex];

  /// Determine if the swipe direction is horizontal
  bool get isHorizontal => currentDirection == 'left' || currentDirection == 'right';

  /// Determine if the swipe direction is vertical
  bool get isVertical => currentDirection == 'up' || currentDirection == 'down';

  /// Reset offsets after swipe gesture ends
  void resetOffsets() {
    _dragOffsetX = 0;
    _dragOffsetY = 0;
  }

  /// Handle swipe and move to next step
  void handleSwipeComplete() {
    // Trigger callback based on swipe direction
    switch (currentDirection) {
      case 'left':
        widget.onSwipeLeft?.call();
        break;
      case 'right':
        widget.onSwipeRight?.call();
        break;
      case 'up':
        widget.onSwipeUp?.call();
        break;
      case 'down':
        widget.onSwipeDown?.call();
        break;
    }

    // Move to next step or close overlay
    if (currentStepIndex < filteredDirections.length - 1) {
      setState(() {
        currentStepIndex++;
        resetOffsets();
      });
    } else {
      Navigator.of(context).pop(); // Close overlay
    }
  }

  /// Load and render asset by extension (Lottie, SVG, GIF, etc.)
  Widget _buildDirectionAsset(String direction) {
    final assetPath = widget.directionAsset?[direction];
    if (assetPath == null) return const SizedBox.shrink();

    if (assetPath.endsWith('.json')) {
      return Lottie.asset(assetPath, width: widget.iconWidth, height: widget.iconHeight);
    } else if (assetPath.endsWith('.gif')) {
      return Image.asset(assetPath, width: widget.iconWidth, height: widget.iconHeight);
    } else if (assetPath.endsWith('.svg')) {
      return SvgPicture.asset(assetPath, width: widget.iconWidth, height: widget.iconHeight);
    } else {
      return const SizedBox.shrink(); // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> directionText = widget.directionText ??
        {
          'left': 'Swipe left to dislike',
          'right': 'Swipe right to like',
          'up': 'Swipe up to boost',
          'down': 'Swipe down to skip',
        };

    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _dragOffsetX += details.delta.dx;
          _dragOffsetY += details.delta.dy;
        });
      },
      onPanEnd: (_) {
        bool swiped = false;

        // Validate swipe
        if (isHorizontal && _dragOffsetX.abs() > _dragThreshold) {
          if (_dragOffsetX < 0 && currentDirection == 'left') swiped = true;
          if (_dragOffsetX > 0 && currentDirection == 'right') swiped = true;
        } else if (isVertical && _dragOffsetY.abs() > _dragThreshold) {
          if (_dragOffsetY < 0 && currentDirection == 'up') swiped = true;
          if (_dragOffsetY > 0 && currentDirection == 'down') swiped = true;
        }

        if (swiped) {
          handleSwipeComplete();
        }

        setState(resetOffsets);
      },
      child: Container(
        // width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height,
        color: Colors.white.withOpacity(0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: 1.0,
              child: Center(
                child: Transform.translate(
                  offset: Offset(_dragOffsetX, _dragOffsetY),
                  child: Transform.rotate(
                    angle: isHorizontal ? _dragOffsetX * 0.0012 : _dragOffsetY * 0.0012,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildDirectionAsset(currentDirection),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            if (widget.showText) ...[
              Text(
                directionText[currentDirection] ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
            const SizedBox(height: 20),
            if (widget.showButtons)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (widget.customNextButton != null)
                    widget.customNextButton!
                  else if (currentStepIndex < filteredDirections.length - 1)
                    ElevatedButton(
                      onPressed: handleSwipeComplete,
                      child: Text(widget.nextButtonText),
                    ),
                  if (widget.customSkipButton != null)
                    widget.customSkipButton!
                  else
                    ElevatedButton(
                      onPressed: widget.onDismiss ?? () => Navigator.of(context).pop(),
                      child: Text(
                        currentStepIndex < filteredDirections.length - 1
                            ? widget.skipButtonText
                            : 'DONE',
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
