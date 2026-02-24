import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

Widget CustomCheckBox({required bool value, required Function(bool) onChanged,double width=20,double height=20,

Color?fillColor, Color?checkColor
}) {
  return      SizedBox(
    width: width,
    height: height,
    child: Checkbox(
      value: value,
      onChanged: (val)=>onChanged(val??false),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      side: WidgetStateBorderSide.resolveWith(
            (states) {
          return  BorderSide(
            color: value?checkColor??AppColors.pink:AppColors.textPrimary,
            width: 1.0,
          );
        },
      ),
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      fillColor:  WidgetStatePropertyAll(fillColor??AppColors.white),
      checkColor: AppColors.pink,
    ),
  );
}