import 'package:evently/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DefaultTextFormField extends StatefulWidget {
  String hintText;
  TextEditingController? controller;
  void Function(String)? onChanged;
  String? prefixIconImageName;

  String? Function(String?)? validator;
  bool isPassword;

  DefaultTextFormField({
    this.hintText = "",
    this.controller,
    this.onChanged,
    this.prefixIconImageName,
    this.validator,
    this.isPassword = false,
  });

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  late bool isObscure = widget.isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,

      decoration: InputDecoration(
        hintText: widget.hintText,

        prefixIcon: widget.prefixIconImageName == null
            ? null
            : SvgPicture.asset(
                "assets/icons/${widget.prefixIconImageName}.svg",
                width: 24,
                height: 24,
                fit: BoxFit.scaleDown,
              ),

        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  isObscure = !isObscure;
                  setState(() {});
                },
                icon: Icon(
                  isObscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppTheme.grey,
                ),
              )
            : null,
      ),

      validator: widget.validator,

      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),

      obscureText: isObscure,
    );
  }
}
