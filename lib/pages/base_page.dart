import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticketing_ui/main.dart';
import 'package:ticketing_ui/pages/my_tickets_page.dart';
import 'package:ticketing_ui/widgets/custom_nav_item.dart';
import 'package:uicons/uicons.dart';

import '../constants.dart';
import '../widgets/fade_transition.dart';
import 'home_page.dart';

// ValueNotifier<bool> navigating = ValueNotifier(true);

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> with TickerProviderStateMixin {
  late AnimationController _fadeOutTransition;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();

    _fadeOutTransition = AnimationController(
      vsync: this,
      duration: kDefaultAnimationDuration,
      reverseDuration: kDefaultAnimationDuration,
    );

    pages = [
      HomePage(
        fadeOutTransition: _fadeOutTransition,
      ),
      MyTicketsPage(
        fadeOutTransition: _fadeOutTransition,
      ),
      Container(),
      Container(),
      Container(),
    ];
    super.initState();
  }

  int _selectedIndex = 0;

  void _switchNavPage(index) async {
    if (index == 0 && _fadeOutTransition.status == AnimationStatus.completed) {
      _fadeOutTransition.reverse();
    }
    if (index == 1) {
      await _fadeOutTransition.forward();
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[_selectedIndex],
      // body: IndexedStack(
      //   index: _selectedIndex,
      //   children: pages,
      // ),
      bottomNavigationBar: CustomSlideYAnimation(
        begin: 1,
        delayDuration: kDefaultAnimationDuration * 4,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 35),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsets.fromLTRB(45, 20, 45, 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomNavItem(
                    selectedIcon: UIcons.solidRounded.home,
                    icon: UIcons.regularRounded.home,
                    index: 0,
                    selectedIndex: _selectedIndex,
                    onTap: _switchNavPage,
                  ),
                  Transform.translate(
                    offset: const Offset(5, 4),
                    child: Transform.rotate(
                      angle: pi / 2,
                      child: CustomNavItem(
                        icon: UIcons.regularRounded.ticket,
                        selectedIcon: UIcons.solidRounded.ticket,
                        index: 1,
                        selectedIndex: _selectedIndex,
                        onTap: _switchNavPage,
                      ),
                    ),
                  ),
                  CustomNavItem(
                    selectedIcon: UIcons.solidRounded.heart,
                    icon: UIcons.regularRounded.heart,
                    index: 2,
                    selectedIndex: _selectedIndex,
                    onTap: _switchNavPage,
                  ),
                  CustomNavItem(
                    selectedIcon: UIcons.solidRounded.comment_alt,
                    icon: UIcons.regularRounded.comment_alt,
                    index: 3,
                    selectedIndex: _selectedIndex,
                    onTap: _switchNavPage,
                  ),
                  CustomNavItem(
                    selectedIcon: UIcons.solidRounded.settings,
                    icon: UIcons.regularRounded.settings,
                    index: 4,
                    selectedIndex: _selectedIndex,
                    onTap: _switchNavPage,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSlideYAnimation extends StatefulWidget {
  const CustomSlideYAnimation({
    super.key,
    this.curve,
    required this.child,
    this.delayDuration,
    this.animationDuration,
    this.begin,
  });

  final Widget child;
  final Duration? delayDuration;
  final Duration? animationDuration;
  final Curve? curve;
  final double? begin;

  @override
  State<CustomSlideYAnimation> createState() => _CustomSlideYAnimationState();
}

class _CustomSlideYAnimationState extends State<CustomSlideYAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _slide;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: widget.animationDuration ?? kDefaultAnimationDuration);

    _slide =
        Tween(begin: Offset(0, widget.begin ?? -1), end: const Offset(0, 0))
            .animate(
      widget.curve == null
          ? _animationController
          : CurvedAnimation(
              parent: _animationController,
              curve: widget.curve!,
            ),
    );

    Future.delayed(widget.delayDuration ?? Duration.zero, () {
      _animationController.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _slide, child: widget.child);
  }
}

class CenterNavButton extends StatefulWidget {
  const CenterNavButton({
    super.key,
  });

  @override
  State<CenterNavButton> createState() => _CenterNavButtonState();
}

class _CenterNavButtonState extends State<CenterNavButton>
    with SingleTickerProviderStateMixin {
  late Animation<double> _scaleTransition;

  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _scaleTransition = Tween(
      begin: 0.1,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const ElasticOutCurve(1),
      ),
    );

    Future.delayed(kDefaultAnimationDuration * 5, () {
      _animationController.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleTransition,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Icon(
          UIcons.regularStraight.plus,
          color: Theme.of(context).primaryColor,
          size: 16,
        ),
      ),
    );
  }
}

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

class FadePage extends StatelessWidget {
  final Widget child;

  const FadePage({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: ModalRoute.of(context)?.animation as Animation<double>,
      child: child,
    );
  }
}
