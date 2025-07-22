import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../utils/constants/color constants/colors.dart';
import 'model/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  double percentage = 0.25;
  PageController? _controller;
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.white.withOpacity(0.5),
              child: Image.asset(
                contentList[currentIndex].image,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    blackColorShade2.withOpacity(0.5),
                    primaryColor.withOpacity(0.95),
                    primaryColor,
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  flex: 5,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: contentList.length,
                    onPageChanged: (int index) {
                      if (index >= currentIndex) {
                        setState(() {
                          currentIndex = index;
                          percentage += 0.25;
                        });
                      } else {
                        setState(() {
                          currentIndex = index;
                          percentage -= 0.25;
                        });
                      }
                    },
                    itemBuilder: (context, index) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    contentList[index].title,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 28,
                                      letterSpacing: 0.24,
                                      color: secondaryColor3,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    contentList[index].description,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(contentList.length,
                                  (index) => buildOvals(index, context)),
                            ),
                            const SizedBox(height: 5),
                            CupertinoButton(
                              child: const Text(
                                "Skip",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: secondaryColor3,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/welcome');
                              },
                            ),
                          ],
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 55,
                                width: 55,
                                child: CircularProgressIndicator(
                                  value: percentage,
                                  backgroundColor: Colors.white38,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    secondaryColor3,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: whiteColor,
                                child: Icon(
                                  MingCute.arrow_right_fill,
                                  color: primaryColor,
                                ),
                              )
                            ],
                          ),
                          onPressed: () {
                            if (currentIndex == contentList.length - 1) {
                              Navigator.pushNamed(context, '/welcome');
                            }
                            _controller!.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildOvals(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
      height: 8,
      margin: const EdgeInsets.only(right: 8),
      width: currentIndex == index ? 24 : 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? secondaryColor3 : whiteColor,
      ),
    );
  }
}
