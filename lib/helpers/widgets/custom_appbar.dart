import 'package:flutter/material.dart';
import '../../utils/constants/color constants/colors.dart';
import '../text_widgets.dart';

class CustomAppBar extends StatefulWidget {
  final String title;
  final List<Widget>? actions;
  final bool? isLeading;
  final Color? bgColor;
  final Color? textColor;
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.isLeading,
    this.bgColor,
    this.textColor,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.bgColor ?? secondaryBg,
      shadowColor: outlineGrey,
      scrolledUnderElevation: 0.0,
      elevation: 0.2,
      centerTitle: true,
      automaticallyImplyLeading: widget.isLeading ?? true,
      title: appbarText(context, widget.title, widget.textColor),
      actions: widget.actions,
      iconTheme: IconThemeData(color: widget.textColor ?? blackColor),
    );
  }
}
