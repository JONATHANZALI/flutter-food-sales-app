import 'package:flutter/material.dart';
import '../const/colors.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput(
      {required this.hintText,
      this.padding = const EdgeInsets.only(left: 40),
      this.keyboardType = TextInputType.multiline,
      this.obscureText = false,
      this.controller,
      this.validator,
      super.key});

  final String hintText;
  final EdgeInsets padding;
  final TextInputType? keyboardType;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: ShapeDecoration(
        color: AppColor.placeholderBg,
        shape: StadiumBorder(),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColor.placeholder,
          ),
          contentPadding: padding,
        ),
      ),
    );
  }
}
