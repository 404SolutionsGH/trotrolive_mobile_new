import 'package:flutter/material.dart';
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
            context, "Trips", FontWeight.w600, 16, blackColor),
      ),
      extendBody: true,
    );
  }
}
