library flutter_swipping_button;

import 'package:flutter/material.dart';

class SwipableButton extends StatefulWidget {
  final Widget child;

  /// The Height of the widget that will be drawn, required.
  final double height;

  /// The `VoidCallback` that will be called once a swipe with certain percentage is detected.
  final VoidCallback onSwipeCallback;

  /// The decimal percentage of swiping in order for the callbacks to get called, defaults to 0.75 (75%) of the total width of the children.
  final double swipePercentageNeeded;

  final bool returnToInitialPosition;

  final Duration? delay;

  const SwipableButton({
    required this.child,
    required this.height,
    required this.onSwipeCallback,
    this.returnToInitialPosition = false,
    this.delay,
    this.swipePercentageNeeded = 0.75,
  })  : assert(
          swipePercentageNeeded <= 1.0,
          'Swipe percentage must be less than or equal to 1.0',
        ),
        assert(
          !returnToInitialPosition || delay != null,
          'Delay must be provided when returnToInitialPosition is true',
        );

  @override
  State<SwipableButton> createState() => _SwipableButtonState();
}

class _SwipableButtonState extends State<SwipableButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  double _dxStartPosition = 0.0;
  double _dxEndsPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        setState(() {});
      });

    _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        setState(() {
          _dxStartPosition = details.localPosition.dx;
        });
      },
      onPanUpdate: (details) {
        final widgetSize = context.size?.width ?? 0;
        final minimumXToStartSwiping = widgetSize * 0.25;
        if (_dxStartPosition <= minimumXToStartSwiping) {
          setState(() {
            _dxEndsPosition = details.localPosition.dx;
          });

          _controller.value = 1 - ((details.localPosition.dx) / widgetSize);
        }
      },
      onPanEnd: (details) async {
        final delta = _dxEndsPosition - _dxStartPosition;
        final widgetSize = context.size?.width ?? 0;
        final deltaNeededToBeSwiped = widgetSize * widget.swipePercentageNeeded;

        if (delta > deltaNeededToBeSwiped) {
          await _controller.animateTo(
            0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
          );
          widget.onSwipeCallback();

          if (widget.returnToInitialPosition && widget.delay != null) {
            Future.delayed(
              widget.delay!,
              () => _controller.animateTo(
                1.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
              ),
            );
          }
        } else {
          await _controller.animateTo(
            1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
          );
        }
      },
      child: SizedBox(
        height: widget.height,
        child: Align(
          alignment: Alignment.centerRight,
          child: FractionallySizedBox(
            widthFactor: _controller.value,
            heightFactor: 1.0,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
