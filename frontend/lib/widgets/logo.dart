import 'package:flutter/material.dart';
import 'package:frontend/constants/color_constant.dart';
import '../models/string_constants.dart';

class LogoAvatar extends StatelessWidget {
  const LogoAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 80.0,
      backgroundColor: const Color.fromARGB(255, 253, 247, 254),
      child: Text(
        AppStrings.appName,
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: ColorConstant.buttonColor,
              fontSize: 120.0,
              fontWeight: FontWeight.w900,
            ),
      ),
    );
  }
}
