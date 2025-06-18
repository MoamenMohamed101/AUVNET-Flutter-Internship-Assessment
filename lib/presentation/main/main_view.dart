import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nawel/presentation/main/bloc/main_bloc.dart';
import 'package:nawel/presentation/main/cart/cart_page.dart';
import 'package:nawel/presentation/main/categories/categories.dart';
import 'package:nawel/presentation/main/deliver/deliver_page.dart';
import 'package:nawel/presentation/main/home/view/home_page.dart';
import 'package:nawel/presentation/main/profile/provile_page.dart';
import 'package:nawel/presentation/resources/assets_manager.dart';
import 'package:nawel/presentation/resources/color_manager.dart';
import 'package:nawel/presentation/resources/styles_manager.dart';
import 'package:nawel/presentation/resources/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  var currentIndex = 0;

  final List<Widget> _pages = [
     HomePage(),
    const CategoriesPage(),
    const DeliverPage(),
    const CartPage(),
    const ProfilePage(),
  ];

  final List<String> _titles = [
    "Home",
    "Categories",
    "Deliver",
    "Cart",
    "Profile",
  ];

  final List<String> _images = [
    ImageAssets.home,
    ImageAssets.categories,
    ImageAssets.deliver,
    ImageAssets.cart,
    ImageAssets.profile,
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => MainBloc(),
      child: Scaffold(
        backgroundColor: ColorManager.whiteColor,
        body: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            return _pages[state.currentIndex];
          },
        ),
        bottomNavigationBar: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            return Container(
              height: 65,
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.15),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ListView.builder(
                itemCount: _pages.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => InkWell(
                  onTap: () => context
                      .read<MainBloc>()
                      .add(ChangePageEvent(index)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        margin: EdgeInsets.only(
                          bottom: index == state.currentIndex ? 0 : size.width * .029,
                          right: size.width * .0250,
                          left: size.width * .0422,
                        ),
                        width: size.width * .128,
                        height: index == state.currentIndex ? size.width * .014 : 0,
                        decoration: BoxDecoration(
                          color: ColorManager.purpleColor,
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(10),
                          ),
                        ),
                      ),
                      SvgPicture.asset(_images[index]),
                      Text(
                        _titles[index],
                        style: getRegularTextStyle(
                          color: index == state.currentIndex
                              ? ColorManager.purpleColor
                              : ColorManager.greyColor,
                          fontSize: AppSize.s12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
