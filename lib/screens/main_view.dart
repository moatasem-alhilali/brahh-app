import 'dart:io';

import 'package:active_ecommerce_flutter/core/resources/assets_fonts.dart';
import 'package:active_ecommerce_flutter/custom/aiz_route.dart';
import 'package:active_ecommerce_flutter/features/category/presentation/bloc/category_bloc.dart';
import 'package:active_ecommerce_flutter/features/category/presentation/view/pages/category_screen.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/presenter/bottom_appbar_index.dart';
import 'package:active_ecommerce_flutter/presenter/cart_counter.dart';
import 'package:active_ecommerce_flutter/features/cart/presentation/view/pages/cart.dart';
import 'package:active_ecommerce_flutter/features/home/presentation/view/pages/home_page_screen.dart';
import 'package:active_ecommerce_flutter/features/auth/presentation/view/pages/login.dart';
import 'package:active_ecommerce_flutter/screens/profile.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:one_context/one_context.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  MainView({Key? key, go_back = true}) : super(key: key);

  late bool go_back;

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;
  //int _cartCount = 0;

  BottomAppBarIndex bottomAppbarIndex = BottomAppBarIndex();

  CartCounter counter = CartCounter();

  var _children = [];

  fetchAll() {
    getCartCount();
  }

  void onTapped(int i) {
    fetchAll();
    if (!is_logged_in.$ && (i == 2)) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
      return;
    }

    if (i == 3) {
      is_logged_in.$
          ? AIZRoute.slideLeft(context, Cart())
          : AIZRoute.slideRight(context, Login());
      return;
    }

    setState(() {
      _currentIndex = i;
    });
    //print("i$i");
  }

  getCartCount() async {
    Provider.of<CartCounter>(context, listen: false).getCount();
  }

  void initState() {
    _children = [
      HomePageScreen(),
      HomePageScreen(),
      CategoryScreen(
        parentCategoryName: '',
        parentCategoryId: 0,
        isBaseCategory: true,
      ),
      Cart(
        has_bottomnav: true,
        from_navigation: true,
        counter: counter,
      ),
      Profile()
    ];
    fetchAll();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc()..add(GetTopCategories()),
      child: WillPopScope(
        onWillPop: () async {
          print(_currentIndex);
          if (_currentIndex != 0) {
            fetchAll();
            setState(() {
              _currentIndex = 0;
            });
          } else {
            // CommonFunctions(context).appExitDialog();
            final shouldPop = (await OneContext().showDialog<bool>(
              builder: (BuildContext context) {
                return Directionality(
                  textDirection: app_language_rtl.$!
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: AlertDialog(
                    // backgroundColor: MyTheme.accent_color,
                    content: Text(
                      AppLocalizations.of(context)!.do_you_want_close_the_app,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: app_mobile_language.$ == 'en'
                            ? "PublicSansSerif"
                            : AssetsArFonts.medium,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Platform.isAndroid ? SystemNavigator.pop() : exit(0);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.yes_ucf,
                          style: TextStyle(
                            fontFamily: app_mobile_language.$ == 'en'
                                ? "PublicSansSerif"
                                : AssetsArFonts.medium,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.no_ucf,
                          style: TextStyle(
                            fontFamily: app_mobile_language.$ == 'en'
                                ? "PublicSansSerif"
                                : AssetsArFonts.medium,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ))!;
            return shouldPop;
          }
          return widget.go_back;
        },
        child: Directionality(
          textDirection:
              app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            extendBody: true,
            body: _children[_currentIndex],
            bottomNavigationBar: SizedBox(
              height: 70,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: onTapped,
                currentIndex: _currentIndex,
                backgroundColor: Colors.white.withOpacity(0.95),
                unselectedItemColor: Color.fromRGBO(168, 175, 179, 1),
                selectedItemColor: MyTheme.accent_color,
                selectedLabelStyle: TextStyle(
                    fontFamily: app_mobile_language.$ == 'en'
                        ? "PublicSansSerif"
                        : AssetsArFonts.medium,
                    fontWeight: FontWeight.w700,
                    color: MyTheme.accent_color,
                    fontSize: 12),
                unselectedLabelStyle: TextStyle(
                  fontFamily: app_mobile_language.$ == 'en'
                      ? "PublicSansSerif"
                      : AssetsArFonts.medium,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(168, 175, 179, 1),
                  fontSize: 12,
                ),
                items: [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Image.asset(
                        "assets/home.png",
                        color: _currentIndex == 0
                            ? MyTheme.accent_color
                            : Color.fromRGBO(153, 153, 153, 1),
                        height: 16,
                      ),
                    ),
                    label: app_mobile_language.$ == 'en'
                        ? AppLocalizations.of(context)!.home_ucf
                        : "الرئيسية",
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Icon(
                        Icons.chat_sharp,
                        size: 22,
                        color: _currentIndex == 1
                            ? MyTheme.accent_color
                            : Color.fromRGBO(153, 153, 153, 1),
                      ),
                    ),
                    label: app_mobile_language.$ == 'en'
                        ? AppLocalizations.of(context)!.home_ucf
                        : "المراسلة",
                  ),
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Image.asset(
                          "assets/categories.png",
                          color: _currentIndex == 2
                              ? MyTheme.accent_color
                              : Color.fromRGBO(153, 153, 153, 1),
                          height: 16,
                        ),
                      ),
                      label: AppLocalizations.of(context)!.categories_ucf),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: badges.Badge(
                        badgeStyle: badges.BadgeStyle(
                          shape: badges.BadgeShape.circle,
                          badgeColor: MyTheme.accent_color,
                          borderRadius: BorderRadius.circular(10),
                          padding: EdgeInsets.all(5),
                        ),
                        badgeAnimation: badges.BadgeAnimation.slide(
                          toAnimate: false,
                        ),
                        child: Image.asset(
                          "assets/cart.png",
                          color: _currentIndex == 3
                              ? MyTheme.accent_color
                              : Color.fromRGBO(153, 153, 153, 1),
                          height: 16,
                        ),
                        badgeContent: Consumer<CartCounter>(
                          builder: (context, cart, child) {
                            return Text(
                              "${cart.cartCounter}",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            );
                          },
                        ),
                      ),
                    ),
                    label: app_mobile_language.$ == 'en'
                        ? AppLocalizations.of(context)!.cart_ucf
                        : "السلة",
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Image.asset(
                        "assets/profile.png",
                        color: _currentIndex == 4
                            ? MyTheme.accent_color
                            : Color.fromRGBO(153, 153, 153, 1),
                        height: 16,
                      ),
                    ),
                    label: app_mobile_language.$ == 'en'
                        ? AppLocalizations.of(context)!.profile_ucf
                        : "الاعدادات",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
