import 'dart:io';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../helpers/animation/showup_animation.dart';
import '../../../helpers/text_widgets.dart';
import '../../../utils/constants/color constants/colors.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 295,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    primaryColor.withOpacity(0.95),
                    primaryColorDeep,
                  ],
                ),
              ),
              child: Stack(children: [
                Positioned(
                  bottom: 5,
                  top: -180,
                  right: -50,
                  child: Icon(
                    Icons.circle_outlined,
                    size: 200,
                    color: whiteColor.withOpacity(0.05),
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
                  child: ShowUpAnimation(
                    delay: 200,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              child: Stack(
                                children: [
                                  Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: image != null
                                            ? Image.file(image!).image
                                            : Image.asset(
                                                    fit: BoxFit.fitHeight,
                                                    height: 120,
                                                    width: 120,
                                                    "assets/images/pdep-2.png")
                                                .image,
                                      ),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(200),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 2,
                                    left: 80,
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: secondaryColor4,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          MingCute.camera_line,
                                          color: primaryColor,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 18),
                        headingTextMedium(
                          context,
                          "Patrick Boat",
                          FontWeight.w600,
                          23,
                          whiteColor,
                        ),
                        subheadingText(
                          context,
                          'Member since 2022',
                          size: 12,
                          color: secondaryColor3,
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 30,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: subheadingText(
                              context,
                              'Edit Profile',
                              size: 12.5,
                              color: whiteColor,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            Divider(color: primaryContainerShade),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headingTextMedium(
                    context,
                    "Contact Information",
                    FontWeight.w600,
                    15,
                    blackColor,
                  ),
                  SizedBox(height: 13),
                  ListTile(
                    dense: true,
                    horizontalTitleGap: 12,
                    minVerticalPadding: 2,
                    minTileHeight: 5,
                    contentPadding: EdgeInsets.symmetric(),
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Icon(
                          MingCute.phone_line,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                    title: headingTextMedium(
                      context,
                      "Phone Number",
                      FontWeight.w500,
                      13,
                      blackColor,
                    ),
                    subtitle: subheadingTextMedium(
                      context,
                      '+233245513607',
                      11.5,
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    dense: true,
                    horizontalTitleGap: 12,
                    minVerticalPadding: 2,
                    minTileHeight: 5,
                    contentPadding: EdgeInsets.symmetric(),
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Icon(
                          MingCute.mail_line,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                    title: headingTextMedium(
                      context,
                      "Email Address",
                      FontWeight.w500,
                      13,
                      blackColor,
                    ),
                    subtitle: subheadingTextMedium(
                      context,
                      'kofi.boat@gmail.com',
                      11.5,
                    ),
                  ),
                  SizedBox(height: 30),
                  headingTextMedium(
                    context,
                    "Travel History",
                    FontWeight.w600,
                    15,
                    blackColor,
                  ),
                  SizedBox(height: 13),
                  ListTile(
                    dense: true,
                    horizontalTitleGap: 12,
                    minVerticalPadding: 2,
                    minTileHeight: 5,
                    contentPadding: EdgeInsets.symmetric(),
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Icon(
                          MingCute.location_line,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                    title: headingTextMedium(
                      context,
                      "Last Trip",
                      FontWeight.w500,
                      13,
                      blackColor,
                    ),
                    subtitle: subheadingTextMedium(
                      context,
                      'Achimota to Madina',
                      11.5,
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    dense: true,
                    horizontalTitleGap: 12,
                    minVerticalPadding: 2,
                    minTileHeight: 5,
                    contentPadding: EdgeInsets.symmetric(),
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Icon(
                          MingCute.bus_line,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                    title: headingTextMedium(
                      context,
                      "Total Trips",
                      FontWeight.w500,
                      13,
                      blackColor,
                    ),
                    subtitle: subheadingTextMedium(
                      context,
                      '15 trips',
                      11.5,
                    ),
                  ),
                  SizedBox(height: 30),
                  headingTextMedium(
                    context,
                    "Preferences",
                    FontWeight.w600,
                    15,
                    blackColor,
                  ),
                  SizedBox(height: 13),
                  ListTile(
                    dense: true,
                    horizontalTitleGap: 12,
                    minVerticalPadding: 2,
                    minTileHeight: 5,
                    contentPadding: EdgeInsets.symmetric(),
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Icon(
                          MingCute.notification_line,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                    title: headingTextMedium(
                      context,
                      "Notifications",
                      FontWeight.w500,
                      13,
                      blackColor,
                    ),
                    subtitle: subheadingTextMedium(
                      context,
                      'Notifications enabled',
                      11.5,
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    dense: true,
                    horizontalTitleGap: 12,
                    minVerticalPadding: 2,
                    minTileHeight: 5,
                    contentPadding: EdgeInsets.symmetric(),
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Icon(
                          MingCute.moon_line,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                    title: headingTextMedium(
                      context,
                      "Themes",
                      FontWeight.w500,
                      13,
                      blackColor,
                    ),
                    subtitle: subheadingTextMedium(
                      context,
                      'Light theme',
                      11.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
