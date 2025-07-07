import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:trotrolive_mobile_new/helpers/animation/showup_animation.dart';
import 'package:trotrolive_mobile_new/helpers/widgets/cedi_widget.dart';
import '../../../helpers/text_widgets.dart';
import '../../../utils/constants/color constants/colors.dart';

class TripsPage extends StatelessWidget {
  const TripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        shadowColor: primaryContainerShade,
        elevation: 0.1,
        surfaceTintColor: whiteColor,
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: headingTextMedium(
          context,
          "Available Trips",
          FontWeight.w600,
          16,
          blackColor,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/notification');
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Center(
                child: Badge(
                  child: Icon(
                    MingCute.notification_line,
                    size: 21,
                    color: iconGrey,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                ShowUpAnimation(
                  delay: 200,
                  child: Container(
                    height: 107,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: primarySucessShade,
                      border: Border.all(
                        width: 1,
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headingTextMedium(
                              context, 'Disclaimer!!', FontWeight.w600, 14),
                          SizedBox(height: 8),
                          subheadingTextMedium(
                            context,
                            'Fares for certain routes may change periodically due to changes from our database.',
                            12,
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 30,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      headingTextMedium(
                        context,
                        'Found 10 Trips',
                        FontWeight.w600,
                        12,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 13),
                Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(
                      color: primaryContainerShade,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 110,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 150,
                              width: 210,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 90,
                                      width: 40,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 18,
                                            width: 18,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.arrow_drop_up_sharp,
                                                color: whiteColor,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Icon(
                                            Icons.circle,
                                            color: outlineGrey,
                                            size: 6,
                                          ),
                                          SizedBox(height: 3),
                                          Icon(
                                            Icons.circle,
                                            color: outlineGrey,
                                            size: 6,
                                          ),
                                          SizedBox(height: 3),
                                          Icon(
                                            Icons.circle,
                                            color: outlineGrey,
                                            size: 6,
                                          ),
                                          SizedBox(height: 3),
                                          Icon(
                                            Icons.circle,
                                            color: outlineGrey,
                                            size: 6,
                                          ),
                                          SizedBox(height: 3),
                                          Icon(
                                            Icons.circle,
                                            color: outlineGrey,
                                            size: 6,
                                          ),
                                          SizedBox(height: 3),
                                          Container(
                                            height: 18,
                                            width: 18,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.arrow_drop_down_sharp,
                                                color: whiteColor,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        headingTextMedium(
                                          context,
                                          'Abuakwa',
                                          FontWeight.w600,
                                          14,
                                        ),
                                        subheadingText(
                                          context,
                                          'April 5, 11:00',
                                          TextAlign.start,
                                          10,
                                        ),
                                        SizedBox(height: 23),
                                        headingTextMedium(
                                          context,
                                          'Kejetia Market',
                                          FontWeight.w600,
                                          14,
                                        ),
                                        Row(
                                          children: [
                                            subheadingText(
                                              context,
                                              'Transport Type: ',
                                              TextAlign.start,
                                              10,
                                            ),
                                            subheadingText(
                                              context,
                                              'Trotro',
                                              TextAlign.start,
                                              10,
                                              2,
                                              Colors.green,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 110,
                              width: 1,
                              color: outlineGrey,
                            ),
                            SizedBox(width: 8),
                            Container(
                              height: 120,
                              width: 100,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5),
                                  subheadingText(
                                    context,
                                    'TRIP AMOUNT',
                                    TextAlign.start,
                                    11,
                                  ),
                                  SizedBox(height: 3),
                                  Row(
                                    children: [
                                      CediSign(
                                        size: 21,
                                        weight: FontWeight.bold,
                                      ),
                                      SizedBox(width: 1),
                                      headingTextMedium(
                                        context,
                                        '9.50p',
                                        FontWeight.w600,
                                        21,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1),
                                  subheadingText(
                                    context,
                                    'TAKE NOTE!!',
                                    TextAlign.start,
                                    11,
                                  ),
                                  SizedBox(height: 2),
                                  subheadingText(
                                    context,
                                    'ALL FARES ARE ENDORSED BY THE GPRTU.',
                                    TextAlign.start,
                                    10,
                                    3,
                                    Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: primaryContainerShade,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                MingCute.heart_line,
                                color: outlineGrey,
                                size: 17,
                              ),
                              subheadingText(
                                context,
                                'Favorite',
                                TextAlign.start,
                                11,
                              ),
                            ],
                          ),
                          SizedBox(width: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.ios_share_outlined,
                                color: outlineGrey,
                                size: 17,
                              ),
                              subheadingText(
                                context,
                                'Share',
                                TextAlign.start,
                                11,
                              ),
                            ],
                          ),
                          SizedBox(width: 50),
                          Row(
                            children: [
                              Icon(
                                MingCute.eye_2_line,
                                color: outlineGrey,
                                size: 17,
                              ),
                              subheadingText(
                                context,
                                '1.2k visits',
                                TextAlign.start,
                                11,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 13),
                Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(
                      color: primaryContainerShade,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 110,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 150,
                              width: 210,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 90,
                                      width: 40,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 18,
                                            width: 18,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.arrow_drop_up_sharp,
                                                color: whiteColor,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Icon(
                                            Icons.circle,
                                            color: outlineGrey,
                                            size: 6,
                                          ),
                                          SizedBox(height: 3),
                                          Icon(
                                            Icons.circle,
                                            color: outlineGrey,
                                            size: 6,
                                          ),
                                          SizedBox(height: 3),
                                          Icon(
                                            Icons.circle,
                                            color: outlineGrey,
                                            size: 6,
                                          ),
                                          SizedBox(height: 3),
                                          Icon(
                                            Icons.circle,
                                            color: outlineGrey,
                                            size: 6,
                                          ),
                                          SizedBox(height: 3),
                                          Icon(
                                            Icons.circle,
                                            color: outlineGrey,
                                            size: 6,
                                          ),
                                          SizedBox(height: 3),
                                          Container(
                                            height: 18,
                                            width: 18,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.arrow_drop_down_sharp,
                                                color: whiteColor,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        headingTextMedium(
                                          context,
                                          'Abuakwa',
                                          FontWeight.w600,
                                          14,
                                        ),
                                        subheadingText(
                                          context,
                                          'April 5, 11:00',
                                          TextAlign.start,
                                          10,
                                        ),
                                        SizedBox(height: 23),
                                        headingTextMedium(
                                          context,
                                          'Kejetia Market',
                                          FontWeight.w600,
                                          14,
                                        ),
                                        Row(
                                          children: [
                                            subheadingText(
                                              context,
                                              'Transport Type: ',
                                              TextAlign.start,
                                              10,
                                            ),
                                            subheadingText(
                                              context,
                                              'Trotro',
                                              TextAlign.start,
                                              10,
                                              2,
                                              Colors.green,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 110,
                              width: 1,
                              color: outlineGrey,
                            ),
                            SizedBox(width: 8),
                            Container(
                              height: 120,
                              width: 100,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5),
                                  subheadingText(
                                    context,
                                    'TRIP AMOUNT',
                                    TextAlign.start,
                                    11,
                                  ),
                                  SizedBox(height: 3),
                                  Row(
                                    children: [
                                      CediSign(
                                        size: 21,
                                        weight: FontWeight.bold,
                                      ),
                                      SizedBox(width: 1),
                                      headingTextMedium(
                                        context,
                                        '9.50p',
                                        FontWeight.w600,
                                        21,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1),
                                  subheadingText(
                                    context,
                                    'TAKE NOTE!!',
                                    TextAlign.start,
                                    11,
                                  ),
                                  SizedBox(height: 2),
                                  subheadingText(
                                    context,
                                    'ALL FARES ARE ENDORSED BY THE GPRTU.',
                                    TextAlign.start,
                                    10,
                                    3,
                                    Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: primaryContainerShade,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                MingCute.heart_line,
                                color: outlineGrey,
                                size: 17,
                              ),
                              subheadingText(
                                context,
                                'Favorite',
                                TextAlign.start,
                                11,
                              ),
                            ],
                          ),
                          SizedBox(width: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.ios_share_outlined,
                                color: outlineGrey,
                                size: 17,
                              ),
                              subheadingText(
                                context,
                                'Share',
                                TextAlign.start,
                                11,
                              ),
                            ],
                          ),
                          SizedBox(width: 50),
                          Row(
                            children: [
                              Icon(
                                MingCute.eye_2_line,
                                color: outlineGrey,
                                size: 17,
                              ),
                              subheadingText(
                                context,
                                '1.2k visits',
                                TextAlign.start,
                                11,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 13),
                Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(
                      color: primaryContainerShade,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 110,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 150,
                              width: 210,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 90,
                                      width: 40,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 18,
                                            width: 18,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.arrow_drop_up_sharp,
                                                color: whiteColor,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Icon(
                                            Icons.circle,
                                            color: outlineGrey,
                                            size: 6,
                                          ),
                                          SizedBox(height: 3),
                                          Icon(
                                            Icons.circle,
                                            color: outlineGrey,
                                            size: 6,
                                          ),
                                          SizedBox(height: 3),
                                          Icon(
                                            Icons.circle,
                                            color: outlineGrey,
                                            size: 6,
                                          ),
                                          SizedBox(height: 3),
                                          Icon(
                                            Icons.circle,
                                            color: outlineGrey,
                                            size: 6,
                                          ),
                                          SizedBox(height: 3),
                                          Icon(
                                            Icons.circle,
                                            color: outlineGrey,
                                            size: 6,
                                          ),
                                          SizedBox(height: 3),
                                          Container(
                                            height: 18,
                                            width: 18,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.arrow_drop_down_sharp,
                                                color: whiteColor,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        headingTextMedium(
                                          context,
                                          'Abuakwa',
                                          FontWeight.w600,
                                          14,
                                        ),
                                        subheadingText(
                                          context,
                                          'April 5, 11:00',
                                          TextAlign.start,
                                          10,
                                        ),
                                        SizedBox(height: 23),
                                        headingTextMedium(
                                          context,
                                          'Kejetia Market',
                                          FontWeight.w600,
                                          14,
                                        ),
                                        Row(
                                          children: [
                                            subheadingText(
                                              context,
                                              'Transport Type: ',
                                              TextAlign.start,
                                              10,
                                            ),
                                            subheadingText(
                                              context,
                                              'Trotro',
                                              TextAlign.start,
                                              10,
                                              2,
                                              Colors.green,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 110,
                              width: 1,
                              color: outlineGrey,
                            ),
                            SizedBox(width: 8),
                            Container(
                              height: 120,
                              width: 100,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5),
                                  subheadingText(
                                    context,
                                    'TRIP AMOUNT',
                                    TextAlign.start,
                                    11,
                                  ),
                                  SizedBox(height: 3),
                                  Row(
                                    children: [
                                      CediSign(
                                        size: 21,
                                        weight: FontWeight.bold,
                                      ),
                                      SizedBox(width: 1),
                                      headingTextMedium(
                                        context,
                                        '9.50p',
                                        FontWeight.w600,
                                        21,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1),
                                  subheadingText(
                                    context,
                                    'TAKE NOTE!!',
                                    TextAlign.start,
                                    11,
                                  ),
                                  SizedBox(height: 2),
                                  subheadingText(
                                    context,
                                    'ALL FARES ARE ENDORSED BY THE GPRTU.',
                                    TextAlign.start,
                                    10,
                                    3,
                                    Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: primaryContainerShade,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                MingCute.heart_line,
                                color: outlineGrey,
                                size: 17,
                              ),
                              subheadingText(
                                context,
                                'Favorite',
                                TextAlign.start,
                                11,
                              ),
                            ],
                          ),
                          SizedBox(width: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.ios_share_outlined,
                                color: outlineGrey,
                                size: 17,
                              ),
                              subheadingText(
                                context,
                                'Share',
                                TextAlign.start,
                                11,
                              ),
                            ],
                          ),
                          SizedBox(width: 50),
                          Row(
                            children: [
                              Icon(
                                MingCute.eye_2_line,
                                color: outlineGrey,
                                size: 17,
                              ),
                              subheadingText(
                                context,
                                '1.2k visits',
                                TextAlign.start,
                                11,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 13),
                Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(
                      color: primaryContainerShade,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 110,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 150,
                              width: 210,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 90,
                                      width: 40,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 18,
                                            width: 18,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.arrow_drop_up_sharp,
                                                color: whiteColor,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Icon(
                                            Icons.circle,
                                            color: outlineGrey,
                                            size: 6,
                                          ),
                                          SizedBox(height: 3),
                                          Icon(
                                            Icons.circle,
                                            color: outlineGrey,
                                            size: 6,
                                          ),
                                          SizedBox(height: 3),
                                          Icon(
                                            Icons.circle,
                                            color: outlineGrey,
                                            size: 6,
                                          ),
                                          SizedBox(height: 3),
                                          Icon(
                                            Icons.circle,
                                            color: outlineGrey,
                                            size: 6,
                                          ),
                                          SizedBox(height: 3),
                                          Icon(
                                            Icons.circle,
                                            color: outlineGrey,
                                            size: 6,
                                          ),
                                          SizedBox(height: 3),
                                          Container(
                                            height: 18,
                                            width: 18,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.arrow_drop_down_sharp,
                                                color: whiteColor,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        headingTextMedium(
                                          context,
                                          'Abuakwa',
                                          FontWeight.w600,
                                          14,
                                        ),
                                        subheadingText(
                                          context,
                                          'April 5, 11:00',
                                          TextAlign.start,
                                          10,
                                        ),
                                        SizedBox(height: 23),
                                        headingTextMedium(
                                          context,
                                          'Kejetia Market',
                                          FontWeight.w600,
                                          14,
                                        ),
                                        Row(
                                          children: [
                                            subheadingText(
                                              context,
                                              'Transport Type: ',
                                              TextAlign.start,
                                              10,
                                            ),
                                            subheadingText(
                                              context,
                                              'Trotro',
                                              TextAlign.start,
                                              10,
                                              2,
                                              Colors.green,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 110,
                              width: 1,
                              color: outlineGrey,
                            ),
                            SizedBox(width: 8),
                            Container(
                              height: 120,
                              width: 100,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5),
                                  subheadingText(
                                    context,
                                    'TRIP AMOUNT',
                                    TextAlign.start,
                                    11,
                                  ),
                                  SizedBox(height: 3),
                                  Row(
                                    children: [
                                      CediSign(
                                        size: 21,
                                        weight: FontWeight.bold,
                                      ),
                                      SizedBox(width: 1),
                                      headingTextMedium(
                                        context,
                                        '9.50p',
                                        FontWeight.w600,
                                        21,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1),
                                  subheadingText(
                                    context,
                                    'TAKE NOTE!!',
                                    TextAlign.start,
                                    11,
                                  ),
                                  SizedBox(height: 2),
                                  subheadingText(
                                    context,
                                    'ALL FARES ARE ENDORSED BY THE GPRTU.',
                                    TextAlign.start,
                                    10,
                                    3,
                                    Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: primaryContainerShade,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                MingCute.heart_line,
                                color: outlineGrey,
                                size: 17,
                              ),
                              subheadingText(
                                context,
                                'Favorite',
                                TextAlign.start,
                                11,
                              ),
                            ],
                          ),
                          SizedBox(width: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.ios_share_outlined,
                                color: outlineGrey,
                                size: 17,
                              ),
                              subheadingText(
                                context,
                                'Share',
                                TextAlign.start,
                                11,
                              ),
                            ],
                          ),
                          SizedBox(width: 50),
                          Row(
                            children: [
                              Icon(
                                MingCute.eye_2_line,
                                color: outlineGrey,
                                size: 17,
                              ),
                              subheadingText(
                                context,
                                '1.2k visits',
                                TextAlign.start,
                                11,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
