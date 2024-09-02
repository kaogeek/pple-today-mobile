import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class AnimatedSplash extends StatefulWidget {
  AnimatedSplash({
    Key? key,
    this.backgroundColor,
    required this.logoPath,
    required this.subtitle,
    required this.home,
    this.onInit,
    this.duration = 2000,
  }) : super(key: key) {
    assert(logoPath != null);
    assert(logoPath != '');
    assert(subtitle != null);
  }

  final Color? backgroundColor;
  final String? logoPath;
  final String? subtitle;
  final String home;
  final Function()? onInit;
  late final int duration;

  @override
  _AnimatedSplashState createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<AnimatedSplash> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    if (widget.duration < 1000) widget.duration = 2000;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInCirc,
      ),
    );
    _animationController?.forward();
    pageRoute();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController?.reset();
  }

  Future<void> pageRoute() async {
    int duration = widget.duration;

    if (widget.onInit == null) {
      duration.milliseconds.delay(() {
        Get.offAndToNamed(widget.home);
      });
      return;
    }

    final stopwatch = Stopwatch();

    stopwatch.start();
    await widget.onInit!.call();
    stopwatch.stop();

    if (stopwatch.elapsedMilliseconds < widget.duration) {
      duration = widget.duration - stopwatch.elapsedMilliseconds;
    } else {
      duration = 0;
    }

    duration.milliseconds.delay(() {
      Get.offAndToNamed(widget.home);
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: widget.backgroundColor,
        body: FadeTransition(
          opacity: _animation!,
          child: Align(
            alignment: FractionalOffset.center,
            child: Image.asset(
              widget.logoPath!,
              width: 230,
              height: 80,
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              SizedBox(
                height: kToolbarHeight,
                child: Center(
                  child: Text(
                    widget.subtitle!,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
