import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:nawel/presentation/onBoarding/bloc/on_boarding_event.dart';
import 'package:nawel/presentation/onBoarding/bloc/on_boarding_state.dart';
import 'package:nawel/presentation/resources/assets_manager.dart';
import 'package:nawel/presentation/resources/color_manager.dart';
import 'package:nawel/presentation/resources/routes_manager.dart';
import 'package:nawel/presentation/resources/strings_manager.dart';
import 'package:nawel/presentation/resources/styles_manager.dart';
import 'package:nawel/presentation/resources/values_manager.dart';
import 'package:nawel/widgets/button_widget.dart';
import 'package:nawel/widgets/text_button_widget.dart';

import '../bloc/on_boarding_bloc.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({super.key});

  final List<String> titles = const [
    AppStrings.onBoardingTitle1,
    AppStrings.onBoardingTitle2,
    AppStrings.onBoardingTitle3,
  ];

  final List<String> subTitles = const [
    AppStrings.onSubTitleBoardingTitle1,
    AppStrings.onSubTitleBoardingTitle2,
    AppStrings.onSubTitleBoardingTitle3,
  ];

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          final int currentIndex = state.currentPage;
          final bool isLastPage = currentIndex == titles.length - 1;
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: titles.length,
                  onPageChanged: (index) {
                    context.read<OnboardingBloc>().add(
                      OnPageChangedEvent(index),
                    );
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        onBoardingImage(),
                        Gap(AppSize.s60.h),
                        titlesBar(index),
                        Gap(AppSize.s50.h),
                        Stack(
                          children: [
                            glowingShadow(),
                            getStartedButton(context),
                          ],
                        ),
                        !isLastPage
                            ? nextButton(pageController)
                            : const Spacer(),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget nextButton(PageController controller) {
    return TextButtonWidget(
      text: AppStrings.next,
      onPressed: () => controller.nextPage(
        duration: Duration(milliseconds: AppSize.s300),
        curve: Curves.easeIn,
      ),
      textStyle: getRegularTextStyle(
        color: ColorManager.greyColor,
        fontSize: AppSize.s14.sp,
      ),
    );
  }

  Widget getStartedButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: AppSize.s40),
      child: ButtonWidget(
        text: AppStrings.getStarted,
        onTap: () async{
          context.read<OnboardingBloc>().add(CompleteOnboardingEvent());
          Navigator.pushReplacementNamed(context, Routes.loginRoute);
        }
      ),
    );
  }

  Widget glowingShadow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: AppSize.s40),
          child: Container(
            width: AppSize.s20.h,
            height: AppSize.s20.w,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.s200.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.gradientColor.withOpacity(0.7),
                  blurRadius: AppSize.s100,
                  spreadRadius: AppSize.s50,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget titlesBar(int index) {
    return SizedBox(
      height: AppSize.s140.h,
      width: AppSize.s289.w,
      child: Column(
        children: [
          Text(
            titles[index],
            style: getMediumTextStyle(
              color: ColorManager.liteBlackColor,
              fontSize: AppSize.s28.sp,
            ),
          ),
          Gap(AppSize.s12.h),
          Text(
            subTitles[index],
            style: getRegularTextStyle(
              color: ColorManager.greyColor,
              fontSize: AppSize.s16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget onBoardingImage() {
    return SizedBox(
      height: AppSize.s447.h,
      width: AppSize.s480.w,
      child: Stack(
        children: [
          SvgPicture.asset(
            width: AppSize.s342.h,
            height: AppSize.s342.w,
            ImageAssets.onboardingGradient,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(top: AppSize.s80.r),
            child: Image.asset(
              ImageAssets.appLogo,
              height: AppSize.s336.h,
              width: AppSize.s336.w,
            ),
          ),
        ],
      ),
    );
  }
}
