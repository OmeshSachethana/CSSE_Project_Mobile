import './widgets/productprofile_item_widget.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_image_1.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leadingWidth: 45.h,
          leading: AppbarImage(
            svgPath: ImageConstant.imgGoback,
            margin: EdgeInsets.only(
              left: 22.h,
              top: 30.v,
              bottom: 24.v,
            ),
          ),
          centerTitle: true,
          title: AppbarTitle(
            text: "lbl_shopping_cart".tr,
          ),
          actions: [
            AppbarImage1(
              svgPath: ImageConstant.imgCart,
              margin: EdgeInsets.symmetric(
                horizontal: 26.h,
                vertical: 10.v,
              ),
            ),
          ],
        ),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.v),
              CustomElevatedButton(
                width: 128.h,
                text: "msg_you_have_4_items".tr,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 14.h,
                      top: 34.v,
                      right: 17.h,
                    ),
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (
                        context,
                        index,
                      ) {
                        return SizedBox(
                          height: 21.v,
                        );
                      },
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return ProductprofileItemWidget();
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 68.v),
              SizedBox(
                height: 174.v,
                width: double.maxFinite,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: AppDecoration.fillPrimary.copyWith(
                          borderRadius: BorderRadiusStyle.customBorderTL20,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 72.v),
                            Container(
                              height: 43.v,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.onPrimary,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30.h),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomElevatedButton(
                      height: 60.v,
                      width: 330.h,
                      text: "lbl_checkout".tr,
                      rightIcon: Container(
                        margin: EdgeInsets.only(left: 7.h),
                        child: CustomImageView(
                          svgPath: ImageConstant.imgGoBackOnprimary,
                        ),
                      ),
                      buttonStyle: CustomButtonStyles.fillPrimaryTL10,
                      buttonTextStyle: theme.textTheme.titleMedium!,
                      alignment: Alignment.topCenter,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
