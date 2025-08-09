import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trotrolive_mobile_new/presentation/stories/repository/model/stories_model.dart';
import '../../../helpers/text_widgets.dart';
import '../../../utils/constants/color constants/colors.dart';
import '../../../utils/constants/image constants/image_constants.dart';
import '../../stories/repository/data/stories_service.dart';

class StoriesHomeContainer extends StatelessWidget {
  StoriesHomeContainer({super.key});

  List<String> imgs = <String>[
    trotroImg2,
    trotroImg,
    trotroOther2Img,
    trotroStationImg,
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StoryResponse>(
      future: StoryService.fetchHomepageStories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: secondaryColor3,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return ErrorWidget(snapshot.error!);
        }

        final stories = snapshot.data!.stories;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 180,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: storyWidget(
                      context,
                      stories[index],
                      imgs[index],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget storyWidget(BuildContext context, Story? story, String img) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/stories');
      },
      child: Container(
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(img).image,
          ),
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withOpacity(0.93),
              primaryColorDeep,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: iconGrey.withOpacity(0.25),
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(17),
        ),
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              colors: [
                primaryColor.withOpacity(0.1),
                primaryColorDeep,
              ],
            ),
            borderRadius: BorderRadius.circular(17),
          ),
          child: Stack(
            children: [
              Positioned(
                right: 5,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(71, 0, 0, 0),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Center(
                    child: Icon(
                      size: 20,
                      MingCute.radio_line,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                child: SizedBox(
                  height: 140,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      storiesHeadingText(
                        context,
                        story!.headline,
                        FontWeight.bold,
                        13,
                        whiteColor,
                        2,
                      ),
                      SizedBox(height: 7),
                      storySubheadingText(
                        context,
                        story.brief,
                        12,
                        secondaryColor4,
                        4,
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 25,
                        width: 100,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: labelTextRegular(
                            context,
                            'View more',
                            blackColor,
                            11,
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

      // Container(
      //   height: 170,
      //   width: 200,
      //   padding: EdgeInsets.symmetric(horizontal: 5),
      //   decoration: BoxDecoration(
      //     color: whiteColor,
      //     border: Border.all(width: 2.5, color: primaryContainerShade),
      //     borderRadius: BorderRadius.circular(17),
      //   ),
      //   child: SizedBox(
      //     height: 150,
      //     width: MediaQuery.of(context).size.width,
      //     child: Padding(
      //       padding: const EdgeInsets.all(10.0),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           headingTextMedium(
      //             context,
      //             story!.headline,
      //             FontWeight.w600,
      //             13,
      //             blackColor,
      //             2,
      //           ),
      //           SizedBox(height: 8),
      //           subheadingTextMedium(
      //             context,
      //             story.brief,
      //             12,
      //             Colors.black87,
      //             4,
      //           ),
      //           SizedBox(height: 10),
      //           Container(
      //             height: 30,
      //             width: 100,
      //             decoration: BoxDecoration(
      //               color: primaryColor,
      //               borderRadius: BorderRadius.circular(40),
      //             ),
      //             child: Center(
      //               child: labelTextRegular(
      //                 context,
      //                 'View more',
      //                 whiteColor,
      //                 11.5,
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
