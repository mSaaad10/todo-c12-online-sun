import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_c12_online_sun/core/utils/app_styles.dart';
import 'package:todo_app_c12_online_sun/core/utils/colors_manager.dart';

typedef Validator = String? Function(String?);

class CustomField extends StatelessWidget {
  CustomField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.isSecure = false,
    this.keyBoardType = TextInputType.text,
  });

  String hintText;
  TextEditingController controller;
  Validator validator;
  bool isSecure;
  TextInputType keyBoardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isSecure,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppLightStyles.hint,
        fillColor: ColorsManager.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r)),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(15.r)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: Colors.red, width: 2)),
      ),
    );
  }
}
