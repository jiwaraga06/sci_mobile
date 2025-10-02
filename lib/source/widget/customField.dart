import 'package:flutter/material.dart';
import 'package:sci_mobile/source/env/env.dart';

class CustomField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText, labelText, messageError;
  final bool? readOnly, hidePassword;
  final Widget? preffixIcon, suffixIcon;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  FocusNode? focusNode;
  TextInputType? keyboardType;
  CustomField(
      {super.key,
      this.hintText,
      this.labelText,
      this.messageError,
      this.readOnly,
      this.hidePassword,
      this.preffixIcon,
      this.suffixIcon,
      this.controller,
      this.keyboardType,
      this.onChanged,
      this.focusNode,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: messageError!.isEmpty? 45 : 60,
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        readOnly: readOnly!,
        obscureText: hidePassword!,
        keyboardType: keyboardType,
        focusNode: focusNode,
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          // isDense: true,
          hintText: hintText,
          labelText: labelText,
          suffixIcon: suffixIcon,
          prefixIcon: preffixIcon,
          hintStyle: TextStyle(fontSize: 14),
          labelStyle: TextStyle(fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.8), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: readOnly == false ? colorBlueNavy : Colors.grey, strokeAlign: 20),
          ),
          contentPadding: const EdgeInsets.symmetric( horizontal: 6),
        ),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return messageError;
          }
          return null;
        },
      ),
    );
  }
}
