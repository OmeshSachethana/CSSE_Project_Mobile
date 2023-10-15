import '../../../core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductprofileItemWidget extends StatelessWidget {
  const ProductprofileItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.v),
        decoration: AppDecoration.outlineBlack.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgProduct,
              height: 80.v,
              width: 100.h,
              radius: BorderRadius.circular(
                10.h,
              ),
              margin: EdgeInsets.only(bottom: 2.v),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10.v,
                bottom: 8.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "msg_birkin_faubourg".tr,
                    style: CustomTextStyles.bodyMediumMontaga,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 3.h,
                      top: 2.v,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "lbl_1".tr,
                          style: CustomTextStyles.bodyMediumMontaga13,
                        ),
                        CustomImageView(
                          svgPath: ImageConstant.imgSend,
                          height: 8.adaptSize,
                          width: 8.adaptSize,
                          margin: EdgeInsets.only(
                            left: 4.h,
                            top: 5.v,
                            bottom: 4.v,
                          ),
                        ),
                        CustomImageView(
                          svgPath: ImageConstant.imgTelevision,
                          height: 13.v,
                          width: 11.h,
                          margin: EdgeInsets.only(top: 4.v),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6.v),
                  Text(
                    "lbl_82_755".tr,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
