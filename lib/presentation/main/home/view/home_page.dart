import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:nawel/data/repository/repository.dart';
import 'package:nawel/domain/models/restaurants_model.dart';
import 'package:nawel/domain/models/service_model.dart';
import 'package:nawel/domain/models/shortcut_model.dart';
import 'package:nawel/domain/usecase/get_restaurants_usecase.dart';
import 'package:nawel/domain/usecase/get_services_usecase.dart';
import 'package:nawel/presentation/main/home/bloc/home_bloc.dart';
import 'package:nawel/presentation/main/home/widgets/restaurant_item.dart';
import 'package:nawel/presentation/main/home/widgets/service_item.dart';
import 'package:nawel/presentation/main/home/widgets/short_item.dart';
import 'package:nawel/presentation/resources/assets_manager.dart';
import 'package:nawel/presentation/resources/color_manager.dart';
import 'package:nawel/presentation/resources/strings_manager.dart';
import 'package:nawel/presentation/resources/styles_manager.dart';
import 'package:nawel/presentation/resources/values_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<ShortcutModel> shortCuts = [
    ShortcutModel(ImageAssets.order, AppStrings.pastOrder),
    ShortcutModel(ImageAssets.securityVault, AppStrings.superSaver),
    ShortcutModel(ImageAssets.securityVaultShape, AppStrings.mustTries),
    ShortcutModel(ImageAssets.heart, AppStrings.giveBack),
    ShortcutModel(ImageAssets.star, AppStrings.bestSellers),
  ];

  final List<String> banners = [
    ImageAssets.photo,
    ImageAssets.photo,
    ImageAssets.photo,
    ImageAssets.photo,
    ImageAssets.photo,
    ImageAssets.photo,
  ];

  final CarouselSliderController controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(
              GetServicesUseCase(RepositoryImpl(FirebaseAuth.instance)),
              GetRestaurantsUseCase(RepositoryImpl(FirebaseAuth.instance)),
            )
            ..add(LoadServicesEvent())
            ..add(LoadRestaurantsEvent()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userInfoBanner(),
                Gap(AppSize.s20.h),
                sectionName(AppStrings.services),
                Gap(AppSize.s20.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppSize.s114.h,
                      child: servicesItems(state),
                    ),
                    Gap(AppSize.s20.h),
                    gotCodeWidget(),
                    Gap(AppSize.s20.h),
                    sectionName(AppStrings.shortcuts),
                    Gap(AppSize.s10.h),
                    shortCutsItems(),
                    Gap(AppSize.s20.h),
                    homeBanners(),
                    Gap(AppSize.s10.h),
                    sectionName(AppStrings.popularRestaurants),
                    Gap(AppSize.s10.h),
                    SizedBox(
                      height: AppSize.s140.h,
                      child: restaurantItems(state),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  homeBanners() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            CarouselSlider(
              items: banners
                  .map(
                    (toElement) => SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: AppSize.s1_5,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(AppSize.s12),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(AppSize.s12),
                          ),
                          child: Image.asset(
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            toElement,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: AppSize.s200.h,
                autoPlay: true,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  context.read<HomeBloc>().add(ChangeBannerIndexEvent(index));
                },
              ),
              carouselController: controller,
            ),
            Gap(AppSize.s20.h),
            AnimatedSmoothIndicator(
              activeIndex: state.currentBannerIndex,
              count: banners.length,
              effect: WormEffect(), // optional styling
            ),
          ],
        );
      },
    );
  }

  SizedBox shortCutsItems() {
    return SizedBox(
      height: AppSize.s70.h,
      width: AppSize.s375.w,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsetsDirectional.only(
          start: AppSize.s30.r,
          end: AppSize.s30.r,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => ShortItem(shortCuts[index]),
        itemCount: shortCuts.length,
        separatorBuilder: (BuildContext context, int index) =>
            Gap(AppSize.s20.w),
      ),
    );
  }

  Center gotCodeWidget() {
    return Center(
      child: Card(
        elevation: AppSize.s8,
        shadowColor: ColorManager.blackColor,
        child: Container(
          height: AppSize.s100,
          width: AppSize.s342.w,
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.circular(AppSize.s10.r),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: AppSize.s14.r),
            child: Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.asset(ImageAssets.securityVault),
                    Image.asset(ImageAssets.securityVaultShape),
                  ],
                ),
                Gap(AppSize.s20.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.code,
                      style: getMediumTextStyle(
                        color: ColorManager.blackColor,
                        fontSize: AppSize.s14.sp,
                      ),
                    ),
                    Text(
                      AppStrings.addCode,
                      style: getRegularTextStyle(
                        color: ColorManager.greyColor,
                        fontSize: AppSize.s10.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget servicesItems(HomeState state) {
    if (state.isLoadingServices) {
      return Center(child: CircularProgressIndicator());
    } else if (state.servicesError != null) {
      return Center(child: Text(state.servicesError!));
    }
    return servicesList(state.services);
  }

  Container servicesList(List<ServiceModel> services) {
    return Container(
      height: AppSize.s114.h,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsetsDirectional.only(
          start: AppSize.s30.r,
          end: AppSize.s30.r,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => ServiceItem(services[index]),
        itemCount: services.length,
        separatorBuilder: (BuildContext context, int index) =>
            Gap(AppSize.s20.w),
      ),
    );
  }

  Padding sectionName(String name) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: AppSize.s30.r),
      child: Text(
        name,
        style: getMediumTextStyle(
          color: ColorManager.blackColor,
          fontSize: AppSize.s20.sp,
        ),
      ),
    );
  }

  Stack userInfoBanner() {
    return Stack(
      children: [
        SvgPicture.asset(
          ImageAssets.rectangle,
          width: AppSize.s375.w,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(
            top: AppSize.s35,
            start: AppSize.s30,
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.deliveringTo,
                    style: getMediumTextStyle(
                      color: ColorManager.blackColor,
                      fontSize: AppSize.s14.sp,
                    ),
                  ),
                  Text(
                    AppStrings.address,
                    style: getMediumTextStyle(
                      color: ColorManager.blackColor,
                      fontSize: AppSize.s16.sp,
                    ),
                  ),
                  Gap(AppSize.s14.h),
                  Text(
                    "Hi hepa!",
                    style: getMediumTextStyle(
                      color: ColorManager.whiteColor,
                      fontSize: AppSize.s30.sp,
                    ),
                  ),
                ],
              ),
              Gap(AppSize.s50.w),
              Container(
                height: AppSize.s60.h,
                width: AppSize.s140.w,
                decoration: BoxDecoration(
                  color: ColorManager.whiteColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget restaurantItems(HomeState state) {
    if (state.isLoadingRestaurants) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.restaurantsError != null) {
      return Center(child: Text(state.restaurantsError!));
    }
    return restaurantsList(state.restaurants);
  }

  ListView restaurantsList(List<RestaurantsModel> restaurants) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsetsDirectional.only(
        start: AppSize.s30.r,
        end: AppSize.s30.r,
      ),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => RestaurantItem(restaurants[index]),
      itemCount: restaurants.length,
      separatorBuilder: (BuildContext context, int index) => Gap(AppSize.s20.w),
    );
  }
}
