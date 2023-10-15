import '../../core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppbarImage extends StatelessWidget {
  AppbarImage({
    Key? key,
    this.imagePath,
    this.svgPath,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String? imagePath;

  String? svgPath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: 22.h,
          top: 24.v, // Reduce this value
          bottom: 10.v, // And this value
        ),
        child: CustomImageView(
          svgPath: svgPath,
          imagePath: imagePath,
          height: 10.v,
          width: 23.h,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
