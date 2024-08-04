// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:active_ecommerce_flutter/core/base_progress_button.dart';
import 'package:active_ecommerce_flutter/core/my_extensions.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';

class BottomButtonNav extends StatelessWidget {
  const BottomButtonNav({
    Key? key,
    required this.onPressBuyNow,
    required this.onPressAddToCart,
    this.onPressChat,
    this.onPressStar,
    this.onPressStore,
    this.isStar = false,
  }) : super(key: key);
  final bool isStar;
  final void Function()? onPressBuyNow;
  final void Function()? onPressAddToCart;
  final void Function()? onPressChat;
  final void Function()? onPressStar;
  final void Function()? onPressStore;
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: MyProgressButton(
                    borderRadius: 4,
                    height: context.getHight(5),
                    text: 'الى السله',
                    onPressed: onPressAddToCart,
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: MyProgressButton(
                    borderRadius: 4,
                    text: 'اشتري الان',
                    height: context.getHight(5),
                    defaultColor: Color(0xffffa800),
                    onPressed: onPressBuyNow,
                  ),
                ),
                IconButton(
                  onPressed: onPressChat,
                  icon: Icon(
                    size: 20,
                    Icons.chat,
                    color: MyTheme.accent_color,
                  ),
                ),
                IconButton(
                  onPressed: onPressStar,
                  icon: Icon(
                    size: 25,
                    isStar ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: MyTheme.accent_color,
                  ),
                ),
                IconButton(
                  onPressed: onPressStore,
                  icon: Icon(
                    size: 25,
                    Icons.store_outlined,
                    color: MyTheme.accent_color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
