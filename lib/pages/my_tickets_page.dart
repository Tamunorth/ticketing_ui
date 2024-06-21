import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticketing_ui/constants.dart';
import 'package:ticketing_ui/pages/home_page.dart';
import 'package:ticketing_ui/widgets/scale_fade_transition.dart';
import 'package:uicons/uicons.dart';

import '../widgets/ticket_widget.dart';

class MyTicketsPage extends StatefulWidget {
  const MyTicketsPage({
    super.key,
    required this.fadeOutTransition,
  });
  final AnimationController fadeOutTransition;

  @override
  State<MyTicketsPage> createState() => _MyTicketsPageState();
}

class _MyTicketsPageState extends State<MyTicketsPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _fadeOutTransition;
  late Animation<Offset> _slide;
  late Animation<Offset> _containerSlide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: kDefaultAnimationDuration * 2);

    _slide = Tween(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.decelerate),
      ),
    );
    _fade = Tween(begin: -0.2, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _containerSlide =
        Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.decelerate,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() async {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: SlideTransition(
          position: _slide,
          child: FadeTransition(
            opacity: _fade,
            child: Text(
              'My tickets',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
        actions: [
          IconContainer(
            icon: UIcons.regularRounded.plus,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const TicketListView(),
            TicketsBottomContainer(containerSlide: _containerSlide),
          ],
        ),
      ),
    );
  }
}

class TicketsBottomContainer extends StatefulWidget {
  const TicketsBottomContainer({
    super.key,
    required Animation<Offset> containerSlide,
  }) : _containerSlide = containerSlide;

  final Animation<Offset> _containerSlide;

  @override
  State<TicketsBottomContainer> createState() => _TicketsBottomContainerState();
}

class _TicketsBottomContainerState extends State<TicketsBottomContainer>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slide;

  late Animation<double> _size;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: kDefaultAnimationDuration * 4);

    _slide = Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.4, curve: Curves.decelerate),
      ),
    );

    _size = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 0.7, curve: Curves.fastEaseInToSlowEaseOut),
      ),
    );

    Future.delayed(kDefaultAnimationDuration * 3, () {
      _animationController.forward();
    });
  }

  @override
  void dispose() async {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slide,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xff2c2c2c),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizeTransition(
              sizeFactor: _size,
              axisAlignment: -1,
              child: Text(
                'Autographs queue',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: 24),
            ...List.generate(
              4,
              (index) => QueueItem(index: index),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class TicketListView extends StatefulWidget {
  const TicketListView({
    super.key,
  });

  @override
  State<TicketListView> createState() => _TicketListViewState();
}

class _TicketListViewState extends State<TicketListView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<Offset> _slide;
  late Animation<double> _size;
  late ScrollController _listCtrl;

  @override
  void initState() {
    _listCtrl = ScrollController();

    _animationController = AnimationController(
        vsync: this, duration: kDefaultAnimationDuration * 4);

    _slide = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
        .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.fastEaseInToSlowEaseOut),
      ),
    );
    _size = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 0.6, curve: Curves.fastEaseInToSlowEaseOut),
      ),
    );

    Future.delayed(kDefaultAnimationDuration, () {
      _animationController.forward();
      _listCtrl.animateTo(
        150,
        duration: const Duration(milliseconds: 1),
        curve: Curves.decelerate,
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SlideTransition(
        position: _slide,
        child: SingleChildScrollView(
          controller: _listCtrl,
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Row(
            children: List.generate(
              3,
              (index) => TicketWidget(
                sizeAnimation: _size,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QueueItem extends StatefulWidget {
  const QueueItem({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<QueueItem> createState() => _QueueItemState();
}

class _QueueItemState extends State<QueueItem> with TickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _fade;
  late Animation<double> _size;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: kDefaultAnimationDuration * 4);

    _size = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.4, curve: Curves.fastEaseInToSlowEaseOut),
      ),
    );

    _fade = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeIn),
      ),
    );

    Future.delayed(kDefaultAnimationDuration * 5, () {
      _animationController.forward();
    });
  }

  @override
  void dispose() async {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizeTransition(
                sizeFactor: _size,
                child: const CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      'https://images.pexels.com/photos/8141168/pexels-photo-8141168.jpeg?auto=compress&cs=tinysrgb&w=200',
                    )),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SlideFadeTransition(
                    animation: _fade,
                    child: Text(
                      'Margaret Baker',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  SlideFadeTransition(
                    animation: _fade,
                    child: Text(
                      '115 place in the queue',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              )
            ],
          ),
          SlideFadeTransition(
            animation: _fade,
            child: Text(
              '\$125',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
