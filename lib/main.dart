import 'package:active_ecommerce_flutter/core/helper/dio/dio_helper.dart';
import 'package:active_ecommerce_flutter/core/services/service_locator.dart';
import 'package:active_ecommerce_flutter/features/category/presentation/view/pages/category_products.dart';
import 'package:active_ecommerce_flutter/features/category/presentation/view/pages/category_screen.dart';
import 'package:active_ecommerce_flutter/features/home/data/home_repo_imp.dart';
import 'package:active_ecommerce_flutter/features/home/presentation/bloc/home_bloc.dart';
import 'package:active_ecommerce_flutter/helpers/addons_helper.dart';
import 'package:active_ecommerce_flutter/helpers/auth_helper.dart';
import 'package:active_ecommerce_flutter/helpers/business_setting_helper.dart';
import 'package:active_ecommerce_flutter/presenter/cart_counter.dart';
import 'package:active_ecommerce_flutter/presenter/currency_presenter.dart';
import 'package:active_ecommerce_flutter/features/address/pages/address.dart';
import 'package:active_ecommerce_flutter/features/cart/presentation/view/pages/cart.dart';
import 'package:active_ecommerce_flutter/screens/digital_product/digital_products.dart';
import 'package:active_ecommerce_flutter/features/auth/presentation/view/pages/login.dart';
import 'package:active_ecommerce_flutter/screens/main_view.dart';
import 'package:active_ecommerce_flutter/screens/map_location.dart';
import 'package:active_ecommerce_flutter/screens/messenger_list.dart';
import 'package:active_ecommerce_flutter/screens/order_details.dart';
import 'package:active_ecommerce_flutter/screens/order_list.dart';
import 'package:active_ecommerce_flutter/screens/product_reviews.dart';
import 'package:active_ecommerce_flutter/screens/profile.dart';
import 'package:active_ecommerce_flutter/screens/refund_request.dart';
import 'package:active_ecommerce_flutter/screens/splash_screen.dart';
import 'package:active_ecommerce_flutter/screens/todays_deal_products.dart';
import 'package:active_ecommerce_flutter/screens/top_selling_products.dart';
import 'package:active_ecommerce_flutter/screens/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:logger/logger.dart';
import 'package:shared_value/shared_value.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'app_config.dart';
import 'package:active_ecommerce_flutter/services/push_notification_service.dart';
import 'package:one_context/one_context.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:active_ecommerce_flutter/providers/locale_provider.dart';
import 'core/themes/light_theme.dart';
import 'lang_config.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/auction_products.dart';
import 'screens/auction_products_details.dart';
import 'screens/brand_products.dart';
import 'screens/chat.dart';
import 'screens/checkout.dart';
import 'screens/classified_ads/classified_ads.dart';
import 'screens/classified_ads/classified_product_details.dart';
import 'screens/classified_ads/my_classified_ads.dart';
import 'screens/club_point.dart';
import 'screens/digital_product/digital_product_details.dart';
import 'screens/digital_product/purchased_digital_produts.dart';
import 'screens/flash_deal_list.dart';
import 'screens/flash_deal_products.dart';
import 'features/home/presentation/view/pages/home_page_screen.dart';
import 'screens/package/packages.dart';
import 'features/detail/screen/product_details.dart';
import 'screens/seller_details.dart';
import 'screens/seller_products.dart';

Logger logger = Logger();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Downloader
  // FlutterDownloader.initialize(debug: true, ignoreSsl: true);

  //Firebase
  try {
    await Firebase.initializeApp();
    await PushNotificationService().initialise();
    PushNotificationService.initBackgroundMessage();
    PushNotificationService.message();
    PushNotificationService.messageOpenedApp();
  } catch (e) {
    logger.d(e);
  }

  //Another
  AddonsHelper().setAddonsData();
  BusinessSettingHelper().setBusinessSettingData();
  setupServiceLocator();
  await DioHelper.init();

  runApp(SharedValue.wrapApp(MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _initLang();
    _loadToken();
    _initSystemChrome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (context) => CartCounter()),
        ChangeNotifierProvider(create: (context) => CurrencyPresenter()),
        // ChangeNotifierProvider(create: (context) => HomePresenter())
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, provider, snapshot) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  // lazy: false,
                  create: (context) => HomeBloc(
                      homeRepositoryImp: getIt.get<HomeRepositoryImp>())
                    ..getAll()),
            ],
            child: MaterialApp(
              initialRoute: "/",
              routes: generateRoutes,
              builder: OneContext().builder,
              navigatorKey: OneContext().navigator.key,
              title: AppConfig.app_name,
              themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                AppLocalizations.delegate,
              ],
              locale: provider.locale,
              supportedLocales: LangConfig().supportedLocales(),
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                if (AppLocalizations.delegate.isSupported(deviceLocale!)) {
                  return deviceLocale;
                }
                return const Locale('ar');
              },
            ),
          );
        },
      ),
    );
  }

  Map<String, WidgetBuilder> get generateRoutes {
    return {
      "/": (context) => SplashScreen(),
      "/classified_ads": (context) => ClassifiedAds(),
      "/classified_ads_details": (context) => ClassifiedAdsDetails(id: 0),
      "/my_classified_ads": (context) => MyClassifiedAds(),
      "/digital_product_details": (context) => DigitalProductDetails(id: 0),
      "/digital_products": (context) => DigitalProducts(),
      "/purchased_digital_products": (context) => PurchasedDigitalProducts(),
      "/update_package": (context) => UpdatePackage(),
      "/address": (context) => AddressScreen(),
      "/auction_products": (context) => AuctionProducts(),
      "/auction_products_details": (context) => AuctionProductsDetails(id: 0),
      "/brand_products": (context) => BrandProducts(id: 0, brand_name: ""),
      "/cart": (context) => Cart(),
      "/category_list": (context) => CategoryScreen(
            parentCategoryId: 0,
            isBaseCategory: true,
            parentCategoryName: "",
            isTopCategory: false,
          ),
      "/category_products": (context) =>
          CategoryProducts(categoryId: 0, categoryName: ""),
      "/chat": (context) => Chat(),
      "/checkout": (context) => Checkout(),
      "/clubpoint": (context) => Clubpoint(),
      "/flash_deal_list": (context) => FlashDealList(),
      "/flash_deal_products": (context) => FlashDealProducts(),
      "/home": (context) => HomePageScreen(),
      "/login": (context) => Login(),
      "/main": (context) => MainView(),
      "/map_location": (context) => MapLocation(),
      "/messenger_list": (context) => MessengerList(),
      "/order_details": (context) => OrderDetails(),
      "/order_list": (context) => OrderList(),
      "/product_details": (context) => ProductDetails(id: 0),
      "/product_reviews": (context) => ProductReviews(id: 0),
      "/profile": (context) => Profile(),
      "/refund_request": (context) => RefundRequest(),
      "/seller_details": (context) => SellerDetails(id: 0),
      "/seller_products": (context) => SellerProducts(),
      "/todays_deal_products": (context) => TodaysDealProducts(),
      "/top_selling_products": (context) => TopSellingProducts(),
      "/wallet": (context) => Wallet(),
    };
  }
}

void _loadToken() {
  access_token.load().whenComplete(() {
    AuthHelper().fetch_and_set();
  });
}

void _initLang() async {
  await app_language.load();
  await app_mobile_language.load();
  await app_language_rtl.load();
}

void _initSystemChrome() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));
}
