import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBarIcon extends StatelessWidget {
  String imageName;
  NavBarIcon({required this.imageName});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icon/$imageName.eng',
      height: 24,
      width: 24,
      fit: BoxFit.scaleDown,
    );
  }
}
