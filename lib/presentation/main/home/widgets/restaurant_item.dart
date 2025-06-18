import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:nawel/domain/models/restaurants_model.dart';
import 'package:nawel/presentation/resources/color_manager.dart';
import 'package:nawel/presentation/resources/values_manager.dart';

class RestaurantItem extends StatelessWidget {
  final RestaurantsModel restaurantsModel;

  const RestaurantItem(this.restaurantsModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: AppSize.s80.h,
          padding: EdgeInsets.all(AppSize.s8.h),
          decoration: BoxDecoration(
            border:  Border.all(
              color: ColorManager.greyColor,
            ),
            borderRadius: BorderRadius.circular(AppSize.s12.r),
          ),
          child: Image.asset(
            restaurantsModel.image,
            fit: BoxFit.cover,
          ),
        ),
        Text(restaurantsModel.title),
        Row(
          children: [
            Icon(Icons.watch_later_outlined,size: AppSize.s14.sp,),
            Gap(6.w),
            Text("${restaurantsModel.minute} mins"),
          ],
        ),
      ],
    );
  }
}
