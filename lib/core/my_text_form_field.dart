import 'package:active_ecommerce_flutter/core/resources/assets_fonts.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  MyTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.textAlign = TextAlign.start,
    this.keyboardType,
    this.suffixIcon,
    this.height,
    this.onChanged,
    this.readOnly,
    this.controller,
    this.messageValidate,
    this.validator,
    this.prefixIcon,
    this.maxLines,
    this.focusNode,
    this.obscureText = false,
    this.errorText,
    this.outlinefocusedBorderColor,
    this.inputFormatters,
    //foramtter
    this.numberFormatter = false,
    this.noSpaceFormatter = false,
    this.arabicFormatter = false,
    this.englishFormatter = false,
    this.oneLengthnumberFormatter = false,
    this.phoneFormatter = false,
    this.numberWithEnglishFormatter = false,
  });
  String? hintText;
  String? Function(String?)? validator;
  String? labelText;
  String? messageValidate;
  double? height;
  TextEditingController? controller;
  TextAlign? textAlign;
  Widget? suffixIcon;
  Widget? prefixIcon;
  bool? readOnly;
  int? maxLines;
  bool obscureText;
  TextInputType? keyboardType;
  FocusNode? focusNode;
  Color? outlinefocusedBorderColor;
  final Function(String text)? onChanged;
  String? errorText;
  List<TextInputFormatter>? inputFormatters;
  final bool noSpaceFormatter;
  final bool numberFormatter;
  final bool arabicFormatter;
  final bool englishFormatter;
  final bool oneLengthnumberFormatter;
  final bool phoneFormatter;
  final bool numberWithEnglishFormatter;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: height,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
        child: TextFormField(
          inputFormatters: [
            if (numberFormatter)
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            if (oneLengthnumberFormatter) LengthLimitingTextInputFormatter(1),
            if (noSpaceFormatter) NoSpaceFormatter(),
            if (arabicFormatter)
              FilteringTextInputFormatter.allow(RegExp(r'[\u0600-\u06FF\s]')),
            if (englishFormatter)
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
            if (phoneFormatter)
              FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
            if (numberWithEnglishFormatter)
              FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z]')),
            // if (emailFormatter)
            // FilteringTextInputFormatter.allow(
            //     RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')),
          ],
          // style: getTitleMediumTheme(context).copyWith(fontSize: 14),
          readOnly: readOnly ?? false,

          validator: validator ??
              (value) {
                if (value!.isEmpty) {
                  return messageValidate ?? "هذا الحقل مطلوب";
                }
                return null;
              },
          controller: controller,
          keyboardType: keyboardType,
          textAlign: textAlign!,
          maxLines: maxLines,
          obscureText: obscureText,
          decoration: InputDecoration(
            errorText: errorText,
            suffixStyle: const TextStyle(
              color: Color(0xff393939),
            ),
            prefixStyle: const TextStyle(
              color: Color(0xff393939),
            ),
            suffixIconColor: Theme.of(context).primaryColorLight,
            prefixIconColor: Theme.of(context).primaryColorLight,
            labelText: labelText,
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            labelStyle: TextStyle(
              fontFamily: app_mobile_language.$ == 'ar'
                  ? AssetsArFonts.medium
                  : "Public Sans",
            ),
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(20),
            //   borderSide: BorderSide(
            //     color: outlinefocusedBorderColor ?? Colors.grey,
            //     width: 2,
            //   ),
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(20),
            //   borderSide: BorderSide(
            //     color: outlinefocusedBorderColor ?? Colors.grey,
            //     width: 2,
            //   ),
            // ),
            helperStyle: Theme.of(context).textTheme.headlineSmall,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class NoSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.replaceAll(' ', ''),
      selection: newValue.selection,
    );
  }
}

// extension extString on String {
//   bool get isValidEmail {
//     final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
//     return emailRegExp.hasMatch(this);
//   }

//   bool get isValidName {
//     final nameRegExp =
//         RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
//     return nameRegExp.hasMatch(this);
//   }

//   bool get isValidPassword {
//     final passwordRegExp = RegExp(
//         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
//     return passwordRegExp.hasMatch(this);
//   }

//   bool get isNotNull {
//     return this != null;
//   }

//   bool get isValidPhone {
//     final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
//     return phoneRegExp.hasMatch(this);
//   }
// }
