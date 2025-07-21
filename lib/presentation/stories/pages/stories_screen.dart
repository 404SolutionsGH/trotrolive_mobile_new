import 'package:flutter/material.dart';
import 'package:trotrolive_mobile_new/utils/constants/color%20constants/colors.dart';
import 'package:trotrolive_mobile_new/utils/constants/image%20constants/image_constants.dart';

import '../../../helpers/text_widgets.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
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
                  Icons.emoji_emotions_outlined,
                  size: 200,
                  color: Color.fromRGBO(255, 255, 255, 0.05),
                ),
              ),
              Positioned(
                bottom: -190,
                top: 5,
                left: -50,
                child: Icon(
                  Icons.emoji_transportation_rounded,
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
                        'Real moments from the streets of Ghana and beyond!!',
                        size: 12,
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  headingTextMedium(
                    context,
                    'New stories',
                    FontWeight.w600,
                    14,
                  ),
                ],
              ),
              SizedBox(height: 15),
              Container(
                height: 145,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(width: 2.5, color: primaryContainerShade),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 140,
                      width: 175,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headingTextMedium(context, 'Early morning ride',
                                FontWeight.w600, 14),
                            SizedBox(height: 8),
                            subheadingTextMedium(
                              context,
                              'A peaceful sunrise captured from the window of a trotro heading to circle.',
                              12.5,
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 145,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.asset(trotroImg).image,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 145,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(width: 2.5, color: primaryContainerShade),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 140,
                      width: 175,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headingTextMedium(context, 'The Trotro vibe',
                                FontWeight.w600, 14),
                            SizedBox(height: 8),
                            subheadingTextMedium(
                              context,
                              'Crowded but lively, the real Ghanaian transport experience.',
                              12.5,
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 145,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.asset(trotroStationImg).image,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 145,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(width: 2.5, color: primaryContainerShade),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 140,
                      width: 175,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headingTextMedium(
                                context, 'Mate in Action', FontWeight.w600, 14),
                            SizedBox(height: 8),
                            subheadingTextMedium(
                              context,
                              'Accra.. Accra the mates chant echo through the Kumasi traffic.',
                              12.5,
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 145,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.asset(transportImg).image,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
