import 'package:flutter/material.dart';
import 'package:trotrolive_mobile_new/utils/constants/color%20constants/colors.dart';
import 'package:trotrolive_mobile_new/utils/constants/image%20constants/image_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late AnimationController _controller2;
  late Animation<Offset> _slideAnimation2;

  @override
  void initState() {
    super.initState();
    splashController();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _slideAnimation2 =
        Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
    _controller2.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void splashController() async {
    await Future.delayed(Duration(seconds: 5));
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/onboarding', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryBg,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SlideTransition(
                      position: _slideAnimation,
                      child: Image.asset(
                        appIcon,
                        height: 130,
                        width: 130,
                      ),
                    ),
                    SlideTransition(
                      position: _slideAnimation2,
                      child: Text(
                        "Trotrolive",
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: primaryColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                    Text(
                      "Woyalo..woyalo!!",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: secondaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
