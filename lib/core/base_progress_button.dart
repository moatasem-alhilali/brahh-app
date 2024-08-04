import 'package:active_ecommerce_flutter/core/failure/request_state.dart';
import 'package:active_ecommerce_flutter/core/my_extensions.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:flutter/material.dart';
import '/core/themes/light_theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///---------------------------------------My progress button------------------------------------------

class MyProgressButton extends StatelessWidget {
  MyProgressButton({
    super.key,
    this.state = RState.defaults,
    this.text = "add",
    this.onPressed,
    this.border,
    this.width,
    this.height,
    this.borderRadius,
    this.defaultColor,
    this.marginVertical,
    this.colorText,
    this.isBorderColor = false,
  });
  RState state;
  String? text;
  double? width;
  double? height;
  double? borderRadius;
  Color? defaultColor;
  Color? colorText;
  Border? border;
  double? marginVertical;
  void Function()? onPressed;
  bool isBorderColor;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: getWidth(state, width, context),
      margin: EdgeInsets.symmetric(vertical: marginVertical ?? 5),
      curve: Curves.easeInOutBack,
      height: height ?? context.getHight(7),
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
        border: isBorderColor
            ? border ?? Border.all(color: defaultColor ?? LightColors.blue)
            : null,
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
        color: isBorderColor ? null : getBackColor(state, defaultColor),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: getWidget(state, text, context, colorText),
      ),
    );
  }
}

//color
Color? getBackColor(RState state, Color? defaultColor) {
  switch (state) {
    case RState.defaults:
      return defaultColor ?? MyTheme.accent_color;
    case RState.loading:
      return LightColors.black;

    case RState.success:
      return Colors.green;

    case RState.error:
      return Colors.red;
  }
}

//Widget
Widget getWidget(RState state, String? text, context, Color? colorText) {
  switch (state) {
    case RState.defaults:
      return Text(
        text ?? "Add",
        style: TextStyle(
          color: colorText ?? Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    case RState.loading:
      return FittedBox(
        child: myLoading(),
      );

    case RState.success:
      return CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.check,
          color: Colors.black,
        ),
      );

    case RState.error:
      return const CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.cancel,
          color: Colors.white,
        ),
      );
  }
}

//width
double? getWidth(RState state, double? width, BuildContext context) {
  switch (state) {
    case RState.defaults:
      return width ?? context.getWidth(60);

    case RState.loading:
      return width ?? context.getWidth(60);

    case RState.success:
      return width ?? context.getWidth(60);

    case RState.error:
      return width ?? context.getWidth(60);
  }
}

myLoading({double size = 50, Color color = Colors.white}) {
  return Center(
    child: SpinKitFadingFour(
      color: color,
      size: size,
    ),
  );
}
