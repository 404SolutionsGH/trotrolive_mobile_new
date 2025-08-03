import 'package:flutter/material.dart';
import 'package:trotrolive_mobile_new/presentation/stories/repository/model/stories_model.dart';

import '../../../helpers/text_widgets.dart';
import '../../../utils/constants/color constants/colors.dart';
import '../../stories/repository/data/stories_service.dart';

class StoriesHomeContainer extends StatelessWidget {
  const StoriesHomeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StoryResponse>(
      future: StoryService.fetchHomepageStories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: stories.length,
                itemBuilder: (context, index) {
                  return storyWidget(context, stories[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget storyWidget(BuildContext context, Story? story) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/stories');
      },
      child: Container(
        height: 170,
        width: 200,
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(width: 2.5, color: primaryContainerShade),
          borderRadius: BorderRadius.circular(17),
        ),
        child: SizedBox(
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headingTextMedium(
                  context,
                  story!.headline,
                  FontWeight.w600,
                  13,
                  blackColor,
                  2,
                ),
                SizedBox(height: 8),
                subheadingTextMedium(
                  context,
                  story.brief,
                  12,
                  Colors.black87,
                  4,
                ),
                SizedBox(height: 10),
                Container(
                  height: 30,
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
      ),
    );
  }
}
