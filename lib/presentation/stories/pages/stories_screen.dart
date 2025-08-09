import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toastification/toastification.dart';
import 'package:trotrolive_mobile_new/utils/constants/color%20constants/colors.dart';
import '../../../helpers/text_widgets.dart';
import '../bloc/stories_bloc.dart';
import '../repository/model/stories_model.dart';

class StoriesPage extends StatelessWidget {
  StoriesPage({super.key});

  List<StoryResponse>? response = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoriesBloc, StoriesState>(builder: (context, state) {
      if (state is StoriesLoading) {
        Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is StoriesFailureState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          toastification.show(
            showProgressBar: false,
            description: Column(
              children: [
                headingTextMedium(
                  context,
                  state.error,
                  FontWeight.w500,
                  12,
                  whiteColor,
                ),
              ],
            ),
            autoCloseDuration: const Duration(seconds: 7),
            style: ToastificationStyle.fillColored,
            type: ToastificationType.error,
          );
        });
      } else if (state is StoriesFetchedState) {
        return Scaffold(
          backgroundColor: whiteColor,
          extendBody: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(130),
            child: Container(
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
                  // SizedBox(height: 15),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     headingTextMedium(
                  //       context,
                  //       'New stories',
                  //       FontWeight.w600,
                  //       14,
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: state.stories.stories.length,
                      itemBuilder: (BuildContext context, int index) {
                        final res = state.stories.stories[index];
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(8.0),
                                      bottom: Radius.circular(8),
                                    ),
                                  ),
                                  title: Center(
                                    child: headingTextMedium(
                                      context,
                                      res.headline,
                                      FontWeight.bold,
                                      16,
                                    ),
                                  ),
                                  content: Column(
                                    children: [
                                      headingTextMedium(
                                        context,
                                        res.brief,
                                        FontWeight.w500,
                                        12,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              border: Border.all(
                                  width: 2.5, color: primaryContainerShade),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      headingTextMedium(context, res.headline,
                                          FontWeight.w600, 14, blackColor, 2),
                                      SizedBox(height: 8),
                                      subheadingTextMedium(
                                        context,
                                        res.brief,
                                        12.5,
                                        Colors.black87,
                                        5,
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: -5,
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(13),
                                    decoration: BoxDecoration(
                                        // color: iconGrey,
                                        ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: subtitleColor,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.source_outlined,
                                                color: secondaryColor,
                                                size: 15,
                                              ),
                                              SizedBox(width: 3),
                                              subheadingTextMedium(
                                                context,
                                                res.source,
                                                12,
                                                whiteColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        Container(
                                          height: 30,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: subtitleColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                MingCute.calendar_2_line,
                                                color: Colors.red,
                                                size: 15,
                                              ),
                                              SizedBox(width: 3),
                                              subheadingTextMedium(
                                                  context,
                                                  '${res.publishedAt.day.toString()} / ',
                                                  10,
                                                  Colors.black87),
                                              subheadingTextMedium(
                                                context,
                                                '${res.publishedAt.month.toString()} / ',
                                                10,
                                                Colors.black87,
                                              ),
                                              subheadingTextMedium(
                                                context,
                                                res.publishedAt.year.toString(),
                                                10,
                                                Colors.black87,
                                              ),
                                            ],
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
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      }
      return Scaffold(
        backgroundColor: secondaryBg,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Container(
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
            child: Stack(
              children: [
                Positioned(
                  bottom: 5,
                  top: -180,
                  right: -50,
                  child: Icon(
                    Icons.phone_android_rounded,
                    size: 200,
                    color: Color.fromRGBO(255, 255, 255, 0.05),
                  ),
                ),
                Positioned(
                  bottom: -190,
                  top: 5,
                  left: -50,
                  child: Icon(
                    Icons.luggage_rounded,
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        extendBody: true,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (_, __) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 12,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 12,
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
