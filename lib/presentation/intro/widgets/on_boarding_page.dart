import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:silver_heart/bloc/auth_bloc/auth_bloc.dart';
import 'package:silver_heart/presentation/intro/widgets/description_page.dart';
import 'package:silver_heart/presentation/intro/widgets/sign_in_page.dart';

class OnBoardingPage extends HookWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  // Se recomienda usar otro texto para produccion
  final String exampleText =
      "Lorem ipsum dolor sit amet, consecrated advising elit.";

  @override
  Widget build(BuildContext context) {
    final isSigninIn = context.watch<AuthCubit>().state is AuthStateSigninIn;

    return AbsorbPointer(
      absorbing: isSigninIn,
      child: PageIndicatorContainer(
        align: IndicatorAlign.bottom,
        length: 4,
        indicatorSpace: 12,
        indicatorColor: Colors.grey,
        indicatorSelectorColor: Colors.black38,
        child: PageView(
          controller: usePageController(),
          children: [
            DescriptionPage(
              text: exampleText,
              imagePath: 'assets/cat-sleep.png',
            ),
            DescriptionPage(
              text: exampleText,
              imagePath: 'assets/graphics.png',
            ),
            DescriptionPage(
              text: exampleText,
              imagePath: 'assets/settings.png',
            ),
            const SignInPage(),
          ],
        ),
      ),
    );
  }
}
