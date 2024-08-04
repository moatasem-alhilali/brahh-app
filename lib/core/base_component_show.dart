import 'dart:async';

import 'package:active_ecommerce_flutter/core/my_extensions.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '/core/resources/size_config.dart';

Future<void> showMyBottomSheetFunction({
  required BuildContext context,
  required Widget child,
  bool isScroll = true,
  bool isDismissible = true,
  Color? barrierColor,
  String? title,
  FutureOr<void> Function()? action,
}) async {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    // barrierColor: barrierColor,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: true,
    elevation: 0,
    useSafeArea: true,
    builder: (context) {
      return AnimatedPadding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const HeaderStyle(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title ?? '',
                          // style: context.styleMedium(),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            context.pop();
                            if (action != null) {
                              action();
                            }
                          },
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: MyTheme.accent_color,
                            child: FittedBox(
                              child: Text(
                                "X",
                                style: TextStyle(
                                  color: Colors.white,
                                  // fontSize: 12.sp,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  if (isScroll)
                    SingleChildScrollView(
                      child: child.animate().fade(duration: 1.seconds),
                    ),
                  if (!isScroll) child
                ],
              ),
            ],
          ),
        ),
      );
    },
  ).whenComplete(action ?? () {});
}

class HeaderStyle extends StatelessWidget {
  const HeaderStyle({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: context.getHight(.5),
            width: context.getWidth(18),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showMyDialogFunction({
  required BuildContext context,
  required Widget child,
  bool animate = true,
  bool back = true,
}) async {
  showGeneralDialog(
    context: context,
    useRootNavigator: true,
    transitionDuration: Duration(seconds: 1),
    transitionBuilder: animate
        ? (context, animation, secondaryAnimation, child) {
            Tween<Offset> tween;
            tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
            return SlideTransition(
              position: tween.animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ),
              ),
              child: WillPopScope(
                onWillPop: () async {
                  return back;
                },
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SafeArea(
                    child: Center(child: child),
                  ),
                ),
              ),
            );
          }
        : null,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(child: child),
        ),
      );
    },
  );
}

Future<void> showMyActionSheetsFunction({
  required BuildContext context,
  required List<Widget> actions,
}) async {
  showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return CupertinoActionSheet(
        actions: actions,
      );
    },
  );
}

class BaseLoader extends StatelessWidget {
  const BaseLoader({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return const CupertinoActivityIndicator(
      radius: 20,
    );
  }
}

void showMyAlert({
  required BuildContext context,
  required void Function() onPressedYes,
  String? title,
  String? subTitle,
}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(
        title ?? "",
        // style: getTitleMediumTheme(context)
        //     .copyWith(fontSize: 20, color: Colors.red),
      ),
      content: Text(
        subTitle ?? "",
        // style: getTitleMediumTheme(context).copyWith(fontSize: 14),
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: onPressedYes,
          child: Text(
            'حسنا',
            // style: getTitleSmallTheme(context),
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'رجوع',
            // style: getTitleSmallTheme(context),
          ),
        ),
      ],
    ),
  );
}

class BaseContextMenu extends StatelessWidget {
  const BaseContextMenu({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu(
      actions: <Widget>[
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.pop(context);
          },
          trailingIcon: CupertinoIcons.doc_on_clipboard_fill,
          child: const Text('Copy'),
        ),
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.pop(context);
          },
          trailingIcon: CupertinoIcons.share,
          child: const Text('Share'),
        ),
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.pop(context);
          },
          trailingIcon: CupertinoIcons.heart,
          child: const Text('Favorite'),
        ),
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.pop(context);
          },
          isDestructiveAction: true,
          trailingIcon: CupertinoIcons.delete,
          child: const Text('Delete'),
        ),
      ],
      child: child,
    );
  }
}

///When the null safety throw an error customize the ui
void customErrorBuild() {
  ErrorWidget.builder = (FlutterErrorDetails detail) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.yellow,
      ),
      child: Text(
        detail.exception.toString(),
      ),
    );
  };
}

extension MyNavigator on BuildContext {
//show bottomsheet
  showBottomSheet({
    required Widget child,
    bool isDismissible = true,
    FutureOr<void> Function()? whenCompleted,
    Color? barrierColor,
    String? title,
  }) {
    showMyBottomSheetFunction(
      context: this,
      child: child,
      title: title,
      barrierColor: barrierColor,
      isDismissible: isDismissible,
      action: whenCompleted,
    );
  }
}
