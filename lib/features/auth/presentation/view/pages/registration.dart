import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/core/base_progress_button.dart';
import 'package:active_ecommerce_flutter/core/failure/request_state.dart';
import 'package:active_ecommerce_flutter/core/my_extensions.dart';
import 'package:active_ecommerce_flutter/core/my_text_form_field.dart';
import 'package:active_ecommerce_flutter/core/resources/assets_fonts.dart';
import 'package:active_ecommerce_flutter/custom/device_info.dart';
import 'package:active_ecommerce_flutter/custom/intl_phone_input.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/helpers/auth_helper.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/main.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/other_config.dart';
import 'package:active_ecommerce_flutter/repositories/address_repository.dart';
import 'package:active_ecommerce_flutter/repositories/auth_repository.dart';
import 'package:active_ecommerce_flutter/repositories/profile_repository.dart';
import 'package:active_ecommerce_flutter/screens/common_webview_screen.dart';
import 'package:active_ecommerce_flutter/features/auth/presentation/view/pages/login.dart';
import 'package:active_ecommerce_flutter/screens/main_view.dart';
import 'package:active_ecommerce_flutter/ui_elements/auth_ui.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:toast/toast.dart';
import 'package:validators/validators.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String _register_by = "email"; //phone or email
  String initialCountry = 'US';
  GlobalKey<FormState> keyForm = GlobalKey();

  var countries_code = <String?>[];

  String? _phone = "";
  bool? _isAgree = false;
  bool _isCaptchaShowing = false;
  String googleRecaptchaKey = "";

  //controllers
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  @override
  void initState() {
    //on Splash Screen hide statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
    fetch_country();
  }

  fetch_country() async {
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
  RState signUpState = RState.defaults;
  onPressSignUp() async {
    var name = _nameController.text.toString();
    var email = _emailController.text.toString();
    var password = _passwordController.text.toString();
    var passwordConfirm = _passwordConfirmController.text.toString();
    if (!keyForm.currentState!.validate()) {
      return;
    }

    if (password.length < 6) {
      ToastComponent.showDialog(
          AppLocalizations.of(context)!
              .password_must_contain_at_least_6_characters,
          gravity: Toast.center,
          duration: Toast.lengthLong);
      return;
    }

    if (password != passwordConfirm) {
      ToastComponent.showDialog(
          AppLocalizations.of(context)!.passwords_do_not_match,
          gravity: Toast.center,
          duration: Toast.lengthLong);
      return;
    }
    signUpState = RState.loading;
    setState(() {});
    var signupResponse = await AuthRepository().getSignupResponse(
      name,
      _register_by == 'email' ? email : _phone,
      password,
      passwordConfirm,
      _register_by,
      googleRecaptchaKey,
    );

    if (signupResponse.result == false) {
      var message = "";
      signupResponse.message.forEach((value) {
        message += value + "\n";
      });
      signUpState = RState.error;
      setState(() {});
      await Future.delayed(Duration(seconds: 1));
      signUpState = RState.defaults;
      setState(() {});

      ToastComponent.showDialog(message, gravity: Toast.center, duration: 3);
    } else {
      signUpState = RState.success;
      setState(() {});
      await Future.delayed(Duration(seconds: 1));
      signUpState = RState.defaults;
      setState(() {});
      ToastComponent.showDialog(signupResponse.message,
          gravity: Toast.center, duration: Toast.lengthLong);
      AuthHelper().setUserData(signupResponse);
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
            print(fcmToken);
            if (is_logged_in.$ == true) {
              // update device token
              await ProfileRepository().getDeviceTokenUpdateResponse(fcmToken);
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

  @override
  Widget build(BuildContext context) {
    return AuthScreen.buildScreen(
      context,
      app_mobile_language.$ == 'en'
          ? "Joing To \n" + AppConfig.app_name
          : "الانضمام إلى \n" + AppConfig.app_name,
      buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Form(
      key: keyForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: context.getWidth(87),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextFormField(
                  height: context.getHight(9),
                  hintText: "John Doe",
                  labelText: app_mobile_language.$ == 'en' ? "name" : "الاسم",
                  controller: _nameController,
                ),
                if (_register_by == "email")
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextFormField(
                          keyboardType: TextInputType.emailAddress,
                          height: context.getHight(9),
                          hintText: "user@example.com",
                          labelText: app_mobile_language.$ == 'en'
                              ? "email"
                              : "البريد الإلكتروني",
                          controller: _emailController,
                        ),
                        otp_addon_installed.$
                            ? Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _register_by = "phone";
                                    });
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .or_register_with_a_phone,
                                    style: TextStyle(
                                      color: MyTheme.accent_color,
                                      fontFamily: app_mobile_language.$ == 'en'
                                          ? "PublicSansSerif"
                                          : AssetsArFonts.medium,
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
                          // height: 40,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            bottom: 5,
                            left: 5,
                          ),
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
                            selectorTextStyle: TextStyle(
                              color: MyTheme.font_grey,
                            ),
                            textFieldController: _phoneNumberController,
                            formatInput: true,
                            keyboardType: TextInputType.numberWithOptions(
                              signed: true,
                              decimal: true,
                            ),
                            inputDecoration: InputDecoration(
                              hintText: "777777777",
                            ),
                            // inputDecoration:
                            //     InputDecorations.buildInputDecoration_phone(
                            //   hint_text: "01XXX XXX XXX",
                            // ),

                            onSaved: (PhoneNumber number) {},
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _register_by = "email";
                            });
                          },
                          child: Text(
                            AppLocalizations.of(context)!
                                .or_register_with_an_email,
                            style: TextStyle(
                              color: MyTheme.accent_color,
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                              fontFamily: app_mobile_language.$ == 'en'
                                  ? "PublicSansSerif"
                                  : AssetsArFonts.medium,
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
                        height: context.getHight(9),
                        hintText: "• • • • • • • •",
                        labelText: app_mobile_language.$ == 'en'
                            ? "Password"
                            : "كلمة المرور",
                        controller: _passwordController,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          AppLocalizations.of(context)!
                              .password_must_contain_at_least_6_characters,
                          style: TextStyle(
                            color: Color.fromARGB(255, 178, 176, 176),
                            fontFamily: app_mobile_language.$ == 'en'
                                ? "PublicSansSerif"
                                : AssetsArFonts.medium,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                MyTextFormField(
                  height: context.getHight(9),
                  hintText: "• • • • • • • •",
                  labelText: app_mobile_language.$ == 'en'
                      ? "Retype Password"
                      : "إعادة كلمة المرور",
                  controller: _passwordConfirmController,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            value: _isAgree,
                            onChanged: (newValue) {
                              _isAgree = newValue;
                              setState(() {});
                            }),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            width: DeviceInfo(context).width! - 130,
                            child: RichText(
                              maxLines: 2,
                              text: TextSpan(
                                style: TextStyle(
                                  color: MyTheme.font_grey,
                                  fontSize: 12,
                                  fontFamily: app_mobile_language.$ == 'en'
                                      ? "PublicSansSerif"
                                      : AssetsArFonts.medium,
                                ),
                                children: [
                                  TextSpan(
                                    text: "I agree to the",
                                    style: TextStyle(
                                      fontFamily: app_mobile_language.$ == 'en'
                                          ? "PublicSansSerif"
                                          : AssetsArFonts.medium,
                                    ),
                                  ),
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CommonWebviewScreen(
                                              page_name: "Terms Conditions",
                                              url:
                                                  "${AppConfig.RAW_BASE_URL}/mobile-page/terms",
                                            ),
                                          ),
                                        );
                                      },
                                    style: TextStyle(
                                      color: MyTheme.accent_color,
                                      fontFamily: app_mobile_language.$ == 'en'
                                          ? "PublicSansSerif"
                                          : AssetsArFonts.medium,
                                    ),
                                    text: " Terms Conditions",
                                  ),
                                  TextSpan(
                                    text: " &",
                                  ),
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CommonWebviewScreen(
                                              page_name: "Privacy Policy",
                                              url:
                                                  "${AppConfig.RAW_BASE_URL}/mobile-page/privacy-policy",
                                            ),
                                          ),
                                        );
                                      },
                                    text: " Privacy Policy",
                                    style: TextStyle(
                                      color: MyTheme.accent_color,
                                      fontFamily: app_mobile_language.$ == 'en'
                                          ? "PublicSansSerif"
                                          : AssetsArFonts.medium,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: MyProgressButton(
                    defaultColor: _isAgree! ? null : Colors.grey,
                    text: AppLocalizations.of(context)!.sign_up_ucf,
                    state: signUpState,
                    width: context.getWidth(90),
                    onPressed: _isAgree!
                        ? () {
                            onPressSignUp();
                          }
                        : null,
                    colorText: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.already_have_an_account,
                          style: TextStyle(
                            color: MyTheme.font_grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: app_mobile_language.$ == 'en'
                                ? "PublicSansSerif"
                                : AssetsArFonts.medium,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        child: Text(
                          AppLocalizations.of(context)!.log_in,
                          style: TextStyle(
                            color: MyTheme.accent_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: app_mobile_language.$ == 'en'
                                ? "PublicSansSerif"
                                : AssetsArFonts.medium,
                          ),
                        ),
                        onTap: () {
                          context.push(Login());
                        },
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
