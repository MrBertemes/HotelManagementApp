import 'dart:async';
import 'package:flutter/material.dart';
import '../services/db.dart';

class SplashScreen extends StatefulWidget {
  final String route;
  const SplashScreen({super.key, required this.route});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 2500),
    vsync: this,
  )..forward();

  

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(2.0, 0.0),
    end: const Offset(0.0, 0.0),
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationDelay();
  }

  animationDelay() async {
    return Timer(
      const Duration(seconds: 3),
      () {
        Navigator.popAndPushNamed(context, widget.route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            radius: 2.0,
            colors: [
              Colors.grey,
            ],
          ),
        ),
        child: Center(
          child: SlideTransition(
            position: _offsetAnimation,
            child: Image.asset(
              'assets/images/bk.png',
              scale: 10.0,
            ),
          ),
        ),
      ),
    );
  }
}
