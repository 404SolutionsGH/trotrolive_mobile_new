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

  @override
  void initState() {
    super.initState();
    splashController();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void splashController() async {
    await Future.delayed(Duration(seconds: 7));
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/onboarding', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              bgwhiteImg,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Positioned(
              child: Center(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    height: 230,
                    width: 230,
                    decoration: BoxDecoration(
                        color: secondaryBg,
                        borderRadius: BorderRadius.circular(250)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          logo,
                          height: 130,
                          width: 130,
                        ),
                        Text(
                          "Trotrolive",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                color: primaryColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          "Woyalo..woyalo!!",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: secondaryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
