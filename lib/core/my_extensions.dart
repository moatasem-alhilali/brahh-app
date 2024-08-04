import 'package:active_ecommerce_flutter/core/themes/navigator_manager.dart';
import 'package:flutter/material.dart';


extension MyNavigator on BuildContext {
  void push(Widget page) {
    fadeNavigation(page: page, context: this);
  }

  void pop() => Navigator.pop(this);
  void pushAndRemoveUntil(Widget page) {
    fadeNavigationWithRemove(page: page, context: this);
  }
}


//================================= double Helper===============================
extension SizeHelper on BuildContext {
  double getHight(double value) => (MediaQuery.of(this).size.height / 100) * value;
  double getWidth(double value) => (MediaQuery.of(this).size.width / 100) * value;
  double screenWidth() => MediaQuery.of(this).size.width;
  double screenHeight() => MediaQuery.of(this).size.height;
}


