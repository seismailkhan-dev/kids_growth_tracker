import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

Widget customLoader(){
  return  Center(child: CircularProgressIndicator(
    color: AppColors.blue,
  ),);
}