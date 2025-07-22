import 'package:flutter/material.dart';
import '../../utils/constants/color constants/colors.dart';

class DialogBoxUtil extends StatelessWidget {
  const DialogBoxUtil(
    BuildContext context, {
    super.key,
    required this.onTap,
    required this.content,
    required this.leftText,
    required this.rightText,
    required this.oncancel,
    required this.icon,
  });
  final void Function() onTap;
  final String content;
  final String leftText;
  final String rightText;
  final void Function() oncancel;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(),
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8.0),
          bottom: Radius.circular(8),
        ),
      ),
      content: Container(
        height: 270,
        width: 90,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: iconGrey,
                  size: 70,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                color: primaryColorDeep,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      content,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: 13,
                            color: whiteColor,
                          ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: onTap,
                            child: Container(
                              height: 35,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                border: Border.all(color: whiteColor),
                              ),
                              child: Center(
                                child: Text(
                                  rightText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: secondaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
