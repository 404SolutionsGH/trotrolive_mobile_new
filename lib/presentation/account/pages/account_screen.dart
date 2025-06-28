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
      appBar: AppBar(
        shadowColor: primaryContainerShade,
        elevation: 0.1,
        surfaceTintColor: whiteColor,
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: headingTextMedium(
            context, "Profile", FontWeight.w600, 16, blackColor),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 230,
                  width: MediaQuery.of(context).size.width,
                  child: ShowUpAnimation(
                    delay: 200,
                    child: Column(
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {},
                            //  context.read<AuthBloc>().add(PickImageEvent()),
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
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        MingCute.camera_line,
                                        color: whiteColor,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        headingTextMedium(context, "Akua Mensah",
                            FontWeight.w600, 18, blackColor),
                        subheadingTextMedium(
                          context,
                          'Member since 2022',
                          13,
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: 30,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: outlineGrey),
                          ),
                          child: Center(
                            child: subheadingTextMedium(
                              context,
                              'Edit Profile',
                              12.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: primaryContainerShade),
                SizedBox(height: 25),
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
                    'akua.mensah@gmail.com',
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
        ),
      ),
    );
  }
}
