import 'package:flutter/material.dart';

class DividerComponent extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? thickness;

  const DividerComponent({Key? key, this.color, this.height = 0.0, this.thickness = 1.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: thickness,
      color: color ?? Colors.grey.shade200,
    );
  }
}
