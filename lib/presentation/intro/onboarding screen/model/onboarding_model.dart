import 'package:flutter/material.dart';
import 'package:trotrolive_mobile_new/utils/constants/color%20constants/colors.dart';
import 'package:trotrolive_mobile_new/utils/constants/image%20constants/image_constants.dart';

class OnboardingContent {
  String image;
  String title;
  String description;
  Color backgroundColor;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
    required this.backgroundColor,
  });
}

List<OnboardingContent> contentList = [
  OnboardingContent(
    image: trotroImg,
    title: 'Smart Routes & Fare Estimates',
    description:
        'Discover the fastest routes to your destination with accurate fare estimates before you board, so you travel smarter and spend less.',
    backgroundColor: primaryColor,
  ),
  OnboardingContent(
    image: transportImg,
    title: 'Stay Informed with Live Updates',
    description:
        'Get real-time notifications on traffic, delays, and bus availability to help you plan your journey with total confidence.',
    backgroundColor: secondaryColor2,
  ),
  OnboardingContent(
    image: trotroImg2,
    title: 'Rate, Review & Improve the Ride',
    description:
        'Share feedback on your trips, rate drivers, and help improve the quality of every ride for the entire Trotrolive community.',
    backgroundColor: secondaryColor2,
  ),
];
