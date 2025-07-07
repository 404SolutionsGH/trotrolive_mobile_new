import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
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
                primaryColor.withOpacity(0.93),
                primaryColorDeep,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/notification');
                    },
                    child: CircleAvatar(
                      backgroundColor: blackColorShade,
                      child: Center(
                        child: Badge(
                          child: Icon(
                            MingCute.notification_line,
                            size: 21,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                ],
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: blackColorShade,
                      child: Center(
                        child: Icon(
                          MingCute.location_line,
                          color: whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        subheadingText(
                          context,
                          'Location',
                          TextAlign.start,
                          12,
                          2,
                          secondaryColor,
                        ),
                        appbarText(
                            context, 'Weija-Gbawe Accra', whiteColor, 12),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      headingTextMedium(
                          context,
                          "Where are you going this weekend?",
                          FontWeight.w500,
                          18,
                          whiteColor),
                      SizedBox(height: 15),
                      TextFormField(
                        //controller: searchController,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 15,
                              color: whiteColor,
                              fontWeight: FontWeight.w500,
                            ),
                        onChanged: (value) => (),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Type something';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Search here....",
                          hintStyle: const TextStyle(
                              color: secondaryColor, fontSize: 13),
                          prefixIcon: const Icon(
                            MingCute.search_2_line,
                            color: secondaryColor,
                            size: 23,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              // scrollBottomSheet(context);
                            },
                            child: Container(
                              width: 65,
                              decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.circular(60),
                              ),
                              child: Icon(
                                MingCute.list_search_fill,
                                color: blackColor,
                                size: 19,
                              ),
                            ),
                          ),
                          filled: true,
                          isDense: true,
                          fillColor: blackColorShade,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
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
