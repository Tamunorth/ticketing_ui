import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:ticketing_ui/constants.dart';
import 'package:ticketing_ui/pages/base_page.dart';
import 'package:ticketing_ui/pages/ticket_page.dart';
import 'package:ticketing_ui/widgets/fade_transition.dart';
import 'package:uicons/uicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.fadeOutTransition});

  final AnimationController fadeOutTransition;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _fadeOutTransition;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: kDefaultAnimationDuration);
    _fadeOutTransition = widget.fadeOutTransition;

    _slide = Tween(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.decelerate,
      ),
    );

    _fade = Tween(begin: -0.2, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
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
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: CustomSlideFadeAnimation(
          controller: _fadeOutTransition,
          child: SlideTransition(
            position: _slide,
            child: FadeTransition(
              opacity: _fade,
              child: Text(
                'Discover',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        ),
        actions: [
          CustomSlideFadeAnimation(
            controller: _fadeOutTransition,
            child: IconContainer(
              icon: UIcons.regularRounded.search,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomSlideFadeAnimation(
                begin: -2,
                controller: _fadeOutTransition,
                child: const HomePageView(),
              ),
              const SizedBox(height: 24),
              CustomSlideFadeAnimation(
                begin: -1.5,
                controller: _fadeOutTransition,
                child: const HomeSubHeader(),
              ),
              const SizedBox(height: 16),
              CustomSlideFadeAnimation(
                begin: -1,
                controller: _fadeOutTransition,
                child: Stack(
                  children: [
                    const MapItem(),
                    Positioned(
                      left: 40,
                      top: 50,
                      child: AvatarCircle(
                        link:
                            'https://images.pexels.com/photos/8141168/pexels-photo-8141168.jpeg?auto=compress&cs=tinysrgb&w=200',
                        onTap: () {
                          _fadeOutTransition.forward().then(
                                (value) => Navigator.of(context).push(
                                  PageRouteBuilder(
                                    transitionDuration:
                                        kDefaultAnimationDuration,
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return TicketPage(
                                        fadeOutTransition: _fadeOutTransition,
                                      );
                                    },
                                  ),
                                ),
                              );
                        },
                      ),
                    ),
                    const Positioned(
                      right: 40,
                      top: 20,
                      child: AvatarCircle(
                        link:
                            'https://images.pexels.com/photos/8141165/pexels-photo-8141165.jpeg?auto=compress&cs=tinysrgb&w=200',
                      ),
                    ),
                    const Positioned(
                      right: 110,
                      bottom: 10,
                      child: AvatarCircle(
                        link:
                            'https://images.pexels.com/photos/7290718/pexels-photo-7290718.jpeg?auto=compress&cs=tinysrgb&w=200',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MapItem extends StatefulWidget {
  const MapItem({
    super.key,
  });

  @override
  State<MapItem> createState() => _MapItemState();
}

class _MapItemState extends State<MapItem> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: kDefaultAnimationDuration);

    _fade = Tween(begin: -0.2, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    Future.delayed(kDefaultAnimationDuration * 2.5, () {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SizedBox(
        child: Container(
          height: 150,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(30),
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/map.png'),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeSubHeader extends StatefulWidget {
  const HomeSubHeader({
    super.key,
  });

  @override
  State<HomeSubHeader> createState() => _HomeSubHeaderState();
}

class _HomeSubHeaderState extends State<HomeSubHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scale;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: kDefaultAnimationDuration);

    _scale = Tween(begin: -0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _fade = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    Future.delayed(kDefaultAnimationDuration * 2, () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FadeTransition(
            opacity: _fade,
            child: ScaleTransition(
              scale: _scale,
              alignment: Alignment.bottomLeft,
              child: Text(
                'Online queues',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
          FadeTransition(
            opacity: _fade,
            child: ScaleTransition(
              scale: _scale,
              alignment: Alignment.bottomRight,
              child: Text(
                'View all',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AvatarCircle extends StatefulWidget {
  const AvatarCircle({
    super.key,
    required this.link,
    this.onTap,
  });

  final String link;
  final VoidCallback? onTap;

  @override
  State<AvatarCircle> createState() => _AvatarCircleState();
}

class _AvatarCircleState extends State<AvatarCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: kDefaultAnimationDuration);

    _scale = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    Future.delayed(kDefaultAnimationDuration * 3, () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scale,
        child: SizedBox(
          width: 50,
          height: 50,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.link),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class IconContainer extends StatefulWidget {
  const IconContainer({
    super.key,
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final VoidCallback? onTap;

  @override
  State<IconContainer> createState() => _IconContainerState();
}

class _IconContainerState extends State<IconContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scale;
  late Animation<double> _containerScale;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: kDefaultAnimationDuration);

    _scale = Tween(begin: -0.2, end: 1.0).animate(_animationController);
    _containerScale = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _containerScale,
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xff2c2c2c),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ScaleTransition(
            scale: _scale,
            alignment: Alignment.bottomRight,
            child: Icon(
              widget.icon,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with SingleTickerProviderStateMixin {
  late PageController _pageCtrl;
  late AnimationController _animationController;
  late Animation<Offset> _slide;

  int value = 300;
  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: kDefaultAnimationDuration);

    _slide = Tween(begin: const Offset(4, 0), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.decelerate,
      ),
    );
    _pageCtrl = PageController(
      initialPage: 1,
      viewportFraction: 0.8,
    );

    _pageCtrl.addListener(() {
      Future.delayed(Duration.zero, () {
        setState(() {});
      });
    });

    Future.delayed(kDefaultAnimationDuration * 1.2, () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();

    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slide,
      child: SizedBox(
        height: 375,
        child: PageView.builder(
            controller: _pageCtrl,
            clipBehavior: Clip.none,
            itemCount: usersList.length,
            itemBuilder: (context, index) {
              final singleItem = usersList[index];

              double scale = 1.0;
              if (_pageCtrl.position.haveDimensions) {
                double page = _pageCtrl.page!;
                scale = (1 - (page - index).abs()).clamp(0.9, 1.0);
              } else {
                scale = (1 - (index.toDouble() - _pageCtrl.initialPage).abs())
                    .clamp(0.9, 1.0);
              }

              return AnimatedScale(
                scale: scale,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        singleItem.imageUrl,
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
