import 'package:flutter/material.dart';
import 'package:hackapp/constants.dart';

class IconContainer extends StatelessWidget {
  final IconData iconData;
  final Color iconColor, backgroundColor;
  IconContainer(
      {@required this.iconData,
      @required this.backgroundColor,
      @required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: Icon(
        iconData,
        size: 30,
        color: iconColor,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(80),
        border: Border.all(
          color: kConstantBlueColor,
          width: 3,
        ),
      ),
    );
  }
}
