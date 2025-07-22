import 'package:flutter/material.dart';
import '../../utils/constants/color constants/colors.dart';

class CustomButton extends StatelessWidget {
  String text;
  final void Function() onpressed;
  Color color;
  Color? outlineColor;
  Color? textColor;
  IconData? icon;
  Color? offset;
  CustomButton({
    super.key,
    required this.text,
    required this.onpressed,
    required this.color,
    this.outlineColor,
    this.textColor,
    this.icon,
    this.offset,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: outlineColor ?? Colors.transparent),
          color: color,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color:
                  offset?.withOpacity(0.25) ?? secondaryColor.withOpacity(0.25),
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: textColor ?? whiteColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
