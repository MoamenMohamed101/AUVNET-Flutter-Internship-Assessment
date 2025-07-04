import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nawel/domain/models/shortcut_model.dart';
import 'package:nawel/presentation/resources/color_manager.dart';
import 'package:nawel/presentation/resources/values_manager.dart';

class ShortItem extends StatelessWidget {
  final ShortcutModel shortcut;

  const ShortItem(this.shortcut, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: AppSize.s70.h,
          width: AppSize.s70.w,
          decoration: BoxDecoration(
            color: ColorManager.purpleColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppSize.s10.r),
          ),
        ),
        Image.asset(shortcut.image,height: AppSize.s60,width:AppSize.s60),
      ],
    );
  }
}
