import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:page_indicator/page_indicator.dart';

import 'package:silver_heart/bloc/app_bloc.dart';
import 'package:silver_heart/presentation/intro/widgets/intro_widgets.dart';
import 'package:silver_heart/theme/app_theme.dart';

class OnBoardingPage extends HookWidget {
  const OnBoardingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isSigninIn = context.watch<AuthCubit>().state is AuthStateSigninIn;

    return AbsorbPointer(
      absorbing: isSigninIn,
      child: PageIndicatorContainer(
        align: IndicatorAlign.bottom,
        length: 4,
        indicatorSpace: 12,
        indicatorColor: AppTheme.thirdColor,
        indicatorSelectorColor: AppTheme.secondaryColor,
        child: PageView(
          controller: usePageController(),
          children: const [
            DescriptionPage(
              text: "Bienvenido a Silver Heart el lugar perfecto para tus compras de plateria",
              imagePath: 'assets/love-ring.png',
              title: "Silver Heart",
            ),
            DescriptionPage(
              text: "Mantente al pendiente de grandes ofertas que te pueden beneficiar",
              imagePath: 'assets/brazalete.png',
              title: "Compra en línea",
            ),
            DescriptionPage(
              text: "Revisa de cada publicación sobre articulos nuevos de los vendedores",
              imagePath: 'assets/pulsera.png',
              title: "Infórmate",
            ),
            SignInPage(),
          ],
        ),
      ),
    );
  }
}
