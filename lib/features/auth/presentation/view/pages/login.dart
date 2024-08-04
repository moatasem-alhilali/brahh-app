import 'dart:convert';
import 'dart:math';

import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/core/base_progress_button.dart';
import 'package:active_ecommerce_flutter/core/failure/request_state.dart';
import 'package:active_ecommerce_flutter/core/my_extensions.dart';
import 'package:active_ecommerce_flutter/core/my_text_form_field.dart';
import 'package:active_ecommerce_flutter/core/resources/assets_fonts.dart';
import 'package:active_ecommerce_flutter/custom/input_decorations.dart';
import 'package:active_ecommerce_flutter/custom/intl_phone_input.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/features/auth/presentation/view/pages/password_forget.dart';
import 'package:active_ecommerce_flutter/features/auth/presentation/view/pages/registration.dart';
import 'package:active_ecommerce_flutter/helpers/auth_helper.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/main.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/other_config.dart';
import 'package:active_ecommerce_flutter/repositories/auth_repository.dart';
import 'package:active_ecommerce_flutter/repositories/profile_repository.dart';
import 'package:active_ecommerce_flutter/screens/main_view.dart';
import 'package:active_ecommerce_flutter/ui_elements/auth_ui.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:toast/toast.dart';

import '../../../../../repositories/address_repository.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _login_by = "email"; //phone or email
  String initialCountry = 'US';

  // PhoneNumber phoneCode = PhoneNumber(isoCode: 'US', dialCode: "+1");
  var countries_code = <String?>[];

  String? _phone = "";

  GlobalKey<FormState> keyForm = GlobalKey();
  //controllers
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    //on Splash Screen hide statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
    fetchCountry();
  }

  fetchCountry() async {
    var data = await AddressRepository().getCountryList();
    data.countries.forEach((c) => countries_code.add(c.code));
  }

  @override
  void dispose() {
    //before going to other screen show statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  ///
  RState loginRState = RState.defaults;
  onPressedLogin() async {
    var email = _emailController.text.toString();
    var password = _passwordController.text.toString();
    if (keyForm.currentState!.validate()) {
      loginRState = RState.loading;
      setState(() {});
      var loginResponse = await AuthRepository().getLoginResponse(
          _login_by == 'email' ? email : _phone, password, _login_by);
      if (loginResponse.result == false) {
        // Logger(loginResponse.message.toString());
        ToastComponent.showDialog(
          loginResponse.message,
          gravity: Toast.center,
          duration: Toast.lengthLong,
        );
        loginRState = RState.error;
        setState(() {});
        await Future.delayed(Duration(seconds: 1));
        loginRState = RState.defaults;
        setState(() {});
      } else {
        loginRState = RState.success;
        setState(() {});
        ToastComponent.showDialog(loginResponse.message!,
            gravity: Toast.center, duration: Toast.lengthLong);
        AuthHelper().setUserData(loginResponse);
        // push notification starts
        try {
          if (OtherConfig.USE_PUSH_NOTIFICATION) {
            final FirebaseMessaging _fcm = FirebaseMessaging.instance;

            await _fcm.requestPermission(
              alert: true,
              announcement: false,
              badge: true,
              carPlay: false,
              criticalAlert: false,
              provisional: false,
              sound: true,
            );

            String? fcmToken = await _fcm.getToken();

            if (fcmToken != null) {
              print("--fcm token--");
              if (is_logged_in.$ == true) {
                await ProfileRepository()
                    .getDeviceTokenUpdateResponse(fcmToken);
              }
            }
          }
        } catch (e) {
          logger.e(e);
        }

        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return MainView();
        }), (newRoute) => false);
      }
    }
  }

  onPressedGoogleLogin() async {
    try {
      final GoogleSignInAccount googleUser = (await GoogleSignIn().signIn())!;

      print(googleUser.toString());

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;
      String? accessToken = googleSignInAuthentication.accessToken;

      print("displayName ${googleUser.displayName}");
      print("email ${googleUser.email}");
      print("googleUser.id ${googleUser.id}");

      var loginResponse = await AuthRepository().getSocialLoginResponse(
          "google", googleUser.displayName, googleUser.email, googleUser.id,
          accessToken: accessToken);

      if (loginResponse.result == false) {
        ToastComponent.showDialog(loginResponse.message!,
            gravity: Toast.center, duration: Toast.lengthLong);
      } else {
        ToastComponent.showDialog(loginResponse.message!,
            gravity: Toast.center, duration: Toast.lengthLong);
        AuthHelper().setUserData(loginResponse);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MainView();
            },
          ),
        );
      }
      GoogleSignIn().disconnect();
    } on Exception catch (e) {
      print("error is ....... $e");
      // TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreen.buildScreen(
        context,
        "${AppLocalizations.of(context)!.login_to} " + AppConfig.app_name,
        buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    return Form(
      key: keyForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: context.getWidth(90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_login_by == "email")
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextFormField(
                          keyboardType: TextInputType.emailAddress,
                          hintText: "user@example.com",
                          labelText: app_mobile_language.$ == 'en'
                              ? "Email"
                              : "البريد الإلكتروني",
                          controller: _emailController,
                        ),
                        otp_addon_installed.$
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _login_by = "phone";
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .or_login_with_a_phone,
                                    style: TextStyle(
                                      color: MyTheme.accent_color,
                                      fontFamily: app_mobile_language.$ == 'ar'
                                          ? AssetsArFonts.medium
                                          : 'Public Sans',
                                    ),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 36,
                          child: CustomInternationalPhoneNumberInput(
                            countries: countries_code,
                            onInputChanged: (PhoneNumber number) {
                              print(number.phoneNumber);
                              setState(() {
                                _phone = number.phoneNumber;
                              });
                            },
                            onInputValidated: (bool value) {
                              print(value);
                            },
                            selectorConfig: SelectorConfig(
                              selectorType: PhoneInputSelectorType.DIALOG,
                            ),
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle:
                                TextStyle(color: MyTheme.font_grey),
                            textStyle: TextStyle(color: MyTheme.font_grey),
                            // initialValue: PhoneNumber(
                            //     isoCode: countries_code[0].toString()),
                            textFieldController: _phoneNumberController,
                            formatInput: true,
                            keyboardType: TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputDecoration:
                                InputDecorations.buildInputDecoration_phone(
                                    hint_text: "01XXX XXX XXX"),
                            onSaved: (PhoneNumber number) {
                              print('On Saved: $number');
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _login_by = "email";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .or_login_with_an_email,
                              style: TextStyle(
                                color: MyTheme.accent_color,
                                fontFamily: app_mobile_language.$ == 'ar'
                                    ? AssetsArFonts.medium
                                    : 'Public Sans',
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyTextFormField(
                        hintText: "• • • • • • • •",
                        labelText: app_mobile_language.$ == 'en'
                            ? "Password"
                            : "كلمة السر",
                        controller: _passwordController,
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          context.push(PasswordForget());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            AppLocalizations.of(context)!
                                .login_screen_forgot_password,
                            style: TextStyle(
                              color: MyTheme.accent_color,
                              fontFamily: app_mobile_language.$ == 'ar'
                                  ? AssetsArFonts.medium
                                  : 'Public Sans',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: context.getHight(7),
                    child: Row(
                      children: [
                        Expanded(
                          child: MyProgressButton(
                            text: app_mobile_language.$ == 'en'
                                ? "log in"
                                : "تسجيل الدخول",
                            state: loginRState,
                            // width: context.getWidth(90),
                            onPressed: () {
                              onPressedLogin();
                            },
                            colorText: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                            ),
                            onPressed: () {
                              onPressedGoogleLogin();
                            },
                            child: SvgPicture.asset(
                              'assets/svg/google.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: app_mobile_language.$ == 'en'
                            ? "Dont have an account ? "
                            : "لايوجد لديك حساب ؟",
                        style: TextStyle(
                          color: MyTheme.font_grey,
                          fontSize: 14,
                          fontFamily: app_mobile_language.$ == 'ar'
                              ? AssetsArFonts.medium
                              : 'Public Sans',
                        ),
                      ),
                      TextSpan(
                        text: app_mobile_language.$ == 'en'
                            ? "create a new "
                            : "إنشاء حساب جديد",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.push(Registration()),
                        style: TextStyle(
                          color: MyTheme.accent_color,
                          fontSize: 14,
                          fontFamily: app_mobile_language.$ == 'ar'
                              ? AssetsArFonts.medium
                              : 'Public Sans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
