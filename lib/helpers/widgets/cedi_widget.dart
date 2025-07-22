import 'package:flutter/material.dart';

class CediSign extends StatelessWidget {
  final double? size;
  final FontWeight? weight;
  final Color? color;
  const CediSign({
    super.key,
    this.size,
    this.weight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "₵",
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: size,
        fontWeight: weight,
        color: color ?? Colors.black,
      ),
    );
  }
}
