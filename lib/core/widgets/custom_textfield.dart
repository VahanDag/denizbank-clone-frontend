// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:denizbank_clone/core/constants/paddings_borders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.margin,
    required this.hintText,
    required this.isPassword,
    this.suffix,
    this.keyboardType,
    this.inputFormatters,
    required this.controller,
  });
  final EdgeInsetsGeometry? margin;
  final String hintText;
  final bool isPassword;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController controller;

  @override
  State<CustomTextField> createState() {
    print("state");
    return _CustomTextFieldState();
  }
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: PaddingConstant.paddingAllLow.copyWith(left: 15, top: 0, bottom: 0),
      decoration:
          BoxDecoration(borderRadius: BorderRadiusConstant.borderRadius, border: Border.all(width: 2, color: Colors.grey)),
      child: TextFormField(
        controller: widget.controller,
        inputFormatters: widget.inputFormatters,
        obscureText: _isObsecure,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
            contentPadding: PaddingConstant.paddingOnlyTop,
            hintText: widget.hintText,
            suffixIcon: widget.isPassword
                ? _PasswordVisibility(
                    visibleCallback: (visibility) => setState(() {
                      _isObsecure = visibility;
                    }),
                  )
                : widget.suffix,
            border: InputBorder.none),
      ),
    );
  }
}

class _PasswordVisibility extends StatefulWidget {
  const _PasswordVisibility({
    required this.visibleCallback,
  });

  final Function(bool visibility) visibleCallback;

  @override
  State<_PasswordVisibility> createState() => __PasswordVisibilityState();
}

class __PasswordVisibilityState extends State<_PasswordVisibility> {
  bool _isVisible = false;

  void _changeVisibility() {
    setState(() {
      _isVisible = !_isVisible;
      widget.visibleCallback.call(_isVisible);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _changeVisibility,
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints.loose(Size.zero),
        child: AnimatedCrossFade(
            firstChild: const Icon(Icons.visibility_off_rounded),
            secondChild: const Icon(Icons.visibility_rounded),
            crossFadeState: _isVisible ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300)),
      ),
    );
  }
}
