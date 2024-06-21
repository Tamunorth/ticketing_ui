import 'package:flutter/material.dart';

import '../constants.dart';

class FadePageRoute<T> extends PageRoute<T> {
  FadePageRoute({required this.builder});

  final WidgetBuilder builder;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: builder(context),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
      child: child,
    );
  }
}

class CustomSlideFadeAnimation extends StatefulWidget {
  const CustomSlideFadeAnimation({
    super.key,
    this.curve,
    required this.child,
    this.delayDuration,
    this.animationDuration,
    this.begin,
    required this.controller,
  });

  final Widget child;
  final Duration? delayDuration;
  final Duration? animationDuration;
  final Curve? curve;
  final double? begin;
  final AnimationController controller;

  @override
  State<CustomSlideFadeAnimation> createState() =>
      _CustomSlideFadeAnimationState();
}

class _CustomSlideFadeAnimationState extends State<CustomSlideFadeAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _slide;
  late Animation<double> _fade;
  // late AnimationController _animationController;

  @override
  void initState() {
    _slide =
        Tween(begin: const Offset(0, 0), end: Offset(widget.begin ?? -2, 0))
            .animate(
      widget.curve == null
          ? widget.controller
          : CurvedAnimation(
              parent: widget.controller,
              curve: widget.curve!,
            ),
    );
    _fade = Tween(begin: 1.0, end: 0.0).animate(
      widget.curve == null
          ? widget.controller
          : CurvedAnimation(
              parent: widget.controller,
              curve: widget.curve!,
            ),
    );

    // Future.delayed(widget.delayDuration ?? Duration.zero, () {
    //   _animationController.forward();
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _fade,
        child: SlideTransition(position: _slide, child: widget.child));
  }
}
