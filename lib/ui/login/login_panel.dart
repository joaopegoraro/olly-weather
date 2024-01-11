import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olly_weather/ui/login/login_text_field.dart';
import 'package:olly_weather/ui/theme/spacing.dart';
import 'package:olly_weather/ui/theme/text.dart';
import 'package:olly_weather/ui/theme/theme.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

class LoginPanel extends StatelessWidget {
  const LoginPanel({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.isLoading,
    required this.onSubmit,
    this.width,
    this.decoration,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool isLoading;
  final Function onSubmit;
  final double? width;
  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final isWebDesign = deviceWidth > OllyWeatherTheme.mobileWidth;

    return Container(
      padding: const EdgeInsets.all(OllyWeatherSpacing.largePadding),
      width: width,
      decoration: decoration,
      // annoyingly, center aligning in web negates ListView.shrinkWrap, so
      // this check is necessary
      alignment: isWebDesign ? null : Alignment.center,
      child: ListView(
        shrinkWrap: true,
        children: [
          const SvgPicture(
            AssetBytesLoader('assets/vectors/logo.svg.vec'),
          ),
          OllyWeatherSpacing.verticalSpaceLarge,
          LoginTextField(
            controller: usernameController,
            label: 'Username',
            isPassword: false,
          ),
          OllyWeatherSpacing.verticalSpaceSmall,
          LoginTextField(
            controller: passwordController,
            label: 'Password',
            isPassword: true,
          ),
          OllyWeatherSpacing.verticalSpaceRegular,
          ElevatedButton(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(OllyWeatherSpacing.mediumPadding),
              alignment: Alignment.center,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text(
                      "SIGN IN",
                      style: OllyWeatherText.titleStyle,
                    ),
            ),
            onPressed: () {
              if (isLoading) {
                return;
              }

              FocusScope.of(context).unfocus();
              onSubmit();
            },
          ),
        ],
      ),
    );
  }
}
