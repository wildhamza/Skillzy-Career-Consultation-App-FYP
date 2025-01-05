import 'package:basics/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingMenuButton extends StatelessWidget {
  final String title;
  final Function onTap;

  final dynamic color;
  const SettingMenuButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap(),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: isDarkMode ? AppTheme.blackPalette[600] ?? Colors.white : AppTheme.whitePalette[600] ?? Colors.black,
            )
          )
        ),
        child: Card(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w500, color: color)),
                SvgPicture.asset(
                  'assets/svg/chevron-right.svg',
                  height: 20,
                  width: 20,
                  fit: BoxFit.contain,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
