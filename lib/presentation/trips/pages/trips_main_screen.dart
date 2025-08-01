import 'package:flutter/material.dart';
import '../../../utils/constants/color constants/colors.dart';

class TripsMainPage extends StatefulWidget {
  TripsMainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TripsMainPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<TripsMainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
