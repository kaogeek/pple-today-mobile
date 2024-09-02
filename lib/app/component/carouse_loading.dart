// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CarouselLoading extends StatelessWidget {
  final double? width;
  final double? height;

  const CarouselLoading({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey[300]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Container(
          width: width,
          height: height,
          color: Colors.grey,
        ),
      ),
    );
  }
}
