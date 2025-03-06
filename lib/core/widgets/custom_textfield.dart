// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:denizbank_clone/core/constants/extensions.dart';
import 'package:denizbank_clone/core/constants/paddings_borders.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.margin,
    this.prefix,
    required this.hintText,
    this.isPassword = false,
    this.suffix,
    this.keyboardType,
    this.inputFormatters,
    required this.controller,
    this.title,
    this.borderRadius,
    this.validator,
  });
  final EdgeInsetsGeometry? margin;
  final String hintText;
  final bool isPassword;
  final Widget? suffix;
  final Widget? prefix;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController controller;
  final String? title;
  final BorderRadius? borderRadius;
  final String? Function(String? value)? validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObsecure;
  @override
  void initState() {
    _isObsecure = widget.isPassword ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Text(
              widget.title!,
              style: TextStyle(color: Colors.grey.shade700),
            ).margin(PaddingConstant.paddingOnlyLeftLow.copyWith(bottom: 5)),
          Container(
            padding: PaddingConstant.paddingAllLow.copyWith(left: 15, top: 0, bottom: 0),
            decoration: BoxDecoration(
                borderRadius: widget.borderRadius ?? BorderRadiusConstant.borderRadius,
                border: Border.all(width: 2, color: Colors.grey)),
            child: TextFormField(
              validator: widget.validator,
              controller: widget.controller,
              inputFormatters: widget.inputFormatters,
              obscureText: _isObsecure,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                  prefixIcon: widget.prefix,
                  contentPadding: PaddingConstant.paddingOnlyTop,
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: widget.isPassword
                      ? _PasswordVisibility(
                          visibleCallback: (visibility) => setState(() {
                            _isObsecure = visibility;
                          }),
                        )
                      : widget.suffix,
                  border: InputBorder.none),
            ),
          ),
        ],
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
