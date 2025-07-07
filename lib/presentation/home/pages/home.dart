import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../helpers/animation/showup_animation.dart';
import '../../../helpers/text_widgets.dart';
import '../../../helpers/widgets/cedi_widget.dart';
import '../../../utils/constants/color constants/colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: barBg2,
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  headingTextMedium(
                    context,
                    'Trotro Stories',
                    FontWeight.w600,
                    14,
                  ),
                  labelseeAllText(context, 'See All'),
                ],
              ),
              Container(
                height: 145,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: whiteColor,
                border: Border.all( 
                  width: 2.5,
                  color: primaryContainerShade),
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
                                context, 'Free offers', FontWeight.w600, 14),
                            SizedBox(height: 8),
                            subheadingTextMedium(
                              context,
                              'Enjoy exclusive discount on all routes today.',
                              12,
                            ),
                            SizedBox(height: 15),
                            Container(
                              height: 35,
                              width: 100,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Center(
                                child: labelTextRegular(
                                  context,
                                  'View more',
                                  whiteColor,
                                  11.5,
                                ),
                              ),
                            ),
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
                          image: Image.asset("assets/images/feedbackImage.png")
                              .image,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  headingTextMedium(
                    context,
                    'Recent Trips! ',
                    FontWeight.w600,
                    14,
                  ),
                  labelseeAllText(context, 'See All'),
                ],
              ),
              ShowUpAnimation(
                delay: 200,
                child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: whiteColor,
                                      border: Border.all( width: 2.5,color: primaryContainerShade),

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
                                          'Dansoman',
                                          FontWeight.w600,
                                          14,
                                        ),
                                        subheadingText(
                                          context,
                                          'June 23, 14:00',
                                          TextAlign.start,
                                          10,
                                        ),
                                        SizedBox(height: 23),
                                        headingTextMedium(
                                          context,
                                          'Kasoa',
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
                                  Row(
                                    children: [
                                      CediSign(
                                        size: 21,
                                        weight: FontWeight.bold,
                                      ),
                                      SizedBox(width: 1),
                                      headingTextMedium(
                                        context,
                                        '5.00p',
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
              ),
              SizedBox(height: 10),
              Container(
                height: 160,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(color: primaryContainerShade, width: 2.5,),
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
    );
  }
}
