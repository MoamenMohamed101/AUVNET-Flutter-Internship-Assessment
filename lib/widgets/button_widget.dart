import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nawel/presentation/resources/color_manager.dart';
import 'package:nawel/presentation/resources/styles_manager.dart';
import 'package:nawel/presentation/resources/values_manager.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;

  const ButtonWidget({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: AppSize.s54.h,
        width: AppSize.s295.w,
        decoration: BoxDecoration(
          color: ColorManager.purpleColor,
          borderRadius: BorderRadius.circular(AppSize.s10.r),
        ),
        child: Center(
          child: Text(
            text,
            style: getMediumTextStyle(
              color: ColorManager.whiteColor,
              fontSize: AppSize.s18.sp,
            ),
          ),
        ),
      ),
    );
  }
}
