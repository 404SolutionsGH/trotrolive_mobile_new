import 'package:flutter/material.dart';
import 'package:trotrolive_mobile_new/utils/constants/color%20constants/colors.dart';

import '../../../helpers/text_widgets.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(190),
        child: Container(
          decoration: BoxDecoration(
            //color: primaryColor,
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                primaryColor.withOpacity(0.95),
                primaryColorDeep,
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 5,
                top: -180,
                right: -50,
                child: Icon(
                  Icons.circle_outlined,
                  size: 200,
                  color: Color.fromRGBO(255, 255, 255, 0.05),
                ),
              ),
              Positioned(
                bottom: -190,
                top: 5,
                left: -50,
                child: Icon(
                  Icons.circle_outlined,
                  size: 280,
                  color: whiteColor.withOpacity(0.05),
                ),
              ),
              Positioned(
                bottom: 20,
                top: 20,
                right: 20,
                left: 20,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      headingTextMedium(
                        context,
                        "Trotro Stories",
                        FontWeight.bold,
                        20,
                        whiteColor,
                      ),
                      SizedBox(height: 2),
                      subheadingText(
                        context,
                        'Just have fun with it!!',
                        size: 10,
                        color: secondaryColor4,
                      ),
                    ],
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
