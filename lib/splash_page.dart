import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jogodamemoria/homepage.dart';

bool repet = true;

/// This is the stateful widget that the main application instantiates.
class SplashPage extends StatefulWidget {
  // const LogoFade2({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController controller;
  late final AnimationController controller1;
  late final Animation<double> patofogo;
  late final Animation<Alignment> wandering1CubeAlignmentAnimation;
  late final Animation<double> profileOpacityAnimation;
  late final Animation<double> profileHeightAnimation;
  late final Animation<double> profileWidthAnimation;
  late final Animation<double> profileTextOpacityAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        new AnimationController(duration: Duration(seconds: 6), vsync: this)
          ..addListener(() => setState(() {}));

    patofogo = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.05, 1.0, curve: Curves.ease)));

    profileOpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.2, 0.5)));
    // profileHeightAnimation = Tween(begin: 400.0, end: 200.0).animate(
    //     CurvedAnimation(parent: controller, curve: Interval(0.0, 1.0)));

    profileHeightAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 400.0, end: 200.0)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 40.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 200.0, end: 400.0)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 40.0,
        ),
      ],

      //   [
      //   TweenSequenceItem<List>(
      //       Tween(begin: 400.0, end: 200.0).animate(
      //     CurvedAnimation(parent: controller, curve: Interval(0.0, 1.0)));),
      //   TweenSequenceItem<Alignment>(
      //       tween: AlignmentTween(
      //           begin: Alignment.topCenter, end: Alignment.bottomCenter),
      //       weight: 2),
      // ]
    ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));

    wandering1CubeAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem<Alignment>(
          tween: AlignmentTween(
              begin: Alignment.bottomCenter, end: Alignment.topCenter),
          weight: 2),
      TweenSequenceItem<Alignment>(
          tween: AlignmentTween(
              begin: Alignment.topCenter, end: Alignment.bottomCenter),
          weight: 2),
    ]).animate(CurvedAnimation(parent: controller, curve: Curves.linear));

    controller.forward();
    // Future.delayed(const Duration(milliseconds: 5000), () {
    print(repet);
    if (repet) {
      controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
          repet = false;
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
      controller.reverse();
    } else {
      controller.reverse();
    }
    // });

    Future.delayed(const Duration(milliseconds: 5000), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            // since this triggers when the animation is done, no duration is needed
            builder: (context) => HomePage()),
      );
    });
  }

  Widget _buildWanderingCubesWidget(BuildContext context, Widget? child) {
    return Padding(
      padding: const EdgeInsets.all(42.0),
      child: Align(
        alignment: wandering1CubeAlignmentAnimation.value,
        child: Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/cerebro.png",
              ),
              // fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }

  Widget _sombra(BuildContext context, Widget? child) {
    return Padding(
      padding: const EdgeInsets.all(42.0),
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/sombra.png",
            ),
            // fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF52A5FF),
      body: Stack(
        children: <Widget>[
          // Opacity(
          //   opacity: explosaoBomba.value,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //         image: AssetImage(
          //           "images/brain-terry.gif",
          //         ),
          //         fit: BoxFit.scaleDown,
          //       ),
          //     ),
          //   ),
          // ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 2,
                ),
                Container(
                    width: 550,
                    height: profileHeightAnimation.value,
                    child: AnimatedBuilder(
                        animation: controller, builder: _sombra)),
              ],
            ),
          ),

          Center(
            child: Container(
                width: 550,
                height: 550,
                child: AnimatedBuilder(
                    animation: controller,
                    builder: _buildWanderingCubesWidget)),
          ),
          Center(
            child: Opacity(
              opacity: profileOpacityAnimation.value,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/patomemo1.png",
                    ),
                    // fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
