import 'package:app/utils/style.dart';
import 'package:flutter/material.dart';

class CustomIcons extends StatelessWidget {
  final Widget icon;
  const CustomIcons({super.key, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            colors: [primaryColor, secondaryColor],
          ),
          boxShadow: const [
            BoxShadow(
              offset: Offset(1, -1),
              color: AppColors.accentColor,
            ),
            BoxShadow(
              offset: Offset(-1, 1),
              color: AppColors.accentColor,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: icon,
      ),
    );
  }
}
