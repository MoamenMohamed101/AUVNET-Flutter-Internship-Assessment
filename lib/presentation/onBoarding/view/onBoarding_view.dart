import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawel/presentation/onBoarding/bloc/on_boarding_bloc.dart';
import 'package:nawel/presentation/onBoarding/view/onboarding_content.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: const OnboardingContent(),
    );
  }
}
