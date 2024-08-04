import 'package:active_ecommerce_flutter/core/base_progress_button.dart';
import 'package:active_ecommerce_flutter/core/failure/request_state.dart';
import 'package:active_ecommerce_flutter/core/my_extensions.dart';
import 'package:active_ecommerce_flutter/core/my_text_form_field.dart';
import 'package:active_ecommerce_flutter/helpers/auth_helper.dart';
import 'package:active_ecommerce_flutter/helpers/system_config.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/screens/main_view.dart';
import 'package:active_ecommerce_flutter/ui_elements/auth_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:active_ecommerce_flutter/repositories/auth_repository.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:toast/toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Otp extends StatefulWidget {
  String? title;
  Otp({Key? key, this.title}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  //controllers
  TextEditingController _verificationCodeController = TextEditingController();

  @override
  void initState() {
    //on Splash Screen hide statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    //before going to other screen show statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  onTapResend() async {
    try {
      var resendCodeResponse = await AuthRepository().getResendCodeResponse();

      if (resendCodeResponse.result == false) {
        ToastComponent.showDialog(resendCodeResponse.message!,
            gravity: Toast.center, duration: Toast.lengthLong);
      } else {
        ToastComponent.showDialog(resendCodeResponse.message!,
            gravity: Toast.center, duration: Toast.lengthLong);
      }
    } catch (e) {
      print(e);
    }
  }

  ///
  RState confirmState = RState.defaults;
  onPressConfirm() async {
    try {
      var code = _verificationCodeController.text.toString();

      if (code == "") {
        ToastComponent.showDialog(
            AppLocalizations.of(context)!.enter_verification_code,
            gravity: Toast.center,
            duration: Toast.lengthLong);
        return;
      }
      confirmState = RState.loading;
      setState(() {});
      var confirmCodeResponse =
          await AuthRepository().getConfirmCodeResponse(code);

      if (!(confirmCodeResponse.result)) {
        ToastComponent.showDialog(confirmCodeResponse.message,
            gravity: Toast.center, duration: Toast.lengthLong);
        confirmState = RState.error;
        setState(() {});
        await Future.delayed(Duration(seconds: 1));
        confirmState = RState.defaults;
        setState(() {});
      } else {
        confirmState = RState.success;
        setState(() {});
        await Future.delayed(Duration(seconds: 1));
        confirmState = RState.defaults;
        setState(() {});
        ToastComponent.showDialog(confirmCodeResponse.message,
            gravity: Toast.center, duration: Toast.lengthLong);
        if (SystemConfig.systemUser != null) {
          SystemConfig.systemUser!.emailVerified = true;
        }
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainView()),
            (route) => false);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screen_width = MediaQuery.of(context).size.width;
    return AuthScreen.buildScreen(
      withHeader: false,
      context,
      widget.title ?? "",
      Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.title != null)
                Text(
                  widget.title!,
                  style: TextStyle(fontSize: 25, color: MyTheme.font_grey),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 15),
                child: Container(
                  width: 75,
                  height: 75,
                  child: Image.asset('assets/login_registration_form_logo.png'),
                ),
              ),
              /*Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "${AppLocalizations.of(context)!.verify_your} " +
                          (_verify_by == "email"
                              ? AppLocalizations.of(context)!.email_account_ucf
                              : AppLocalizations.of(context)!.phone_number_ucf),
                      style: TextStyle(
                          color: MyTheme.accent_color,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Container(
                        width: _screen_width * (3 / 4),
                        child: _verify_by == "email"
                            ? Text(
                            AppLocalizations.of(context)!.enter_the_verification_code_that_sent_to_your_email_recently,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyTheme.dark_grey, fontSize: 14))
                            : Text(
                            AppLocalizations.of(context)!.enter_the_verification_code_that_sent_to_your_phone_recently,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyTheme.dark_grey, fontSize: 14))),
                  ),*/
              Container(
                width: context.getWidth(80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          MyTextFormField(
                            hintText: "A X B 4 J H",
                            controller: _verificationCodeController,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    MyProgressButton(
                      text: AppLocalizations.of(context)!.confirm_ucf,
                      state: confirmState,
                      defaultColor: MyTheme.accent_color,
                      width: context.getWidth(90),
                      onPressed: () {
                        onPressConfirm();
                      },
                      colorText: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: [
                    Expanded(
                      child: MyProgressButton(
                        text: AppLocalizations.of(context)!.logout_ucf,
                        defaultColor: Colors.red,
                        width: context.getWidth(90),
                        onPressed: () {
                          onTapLogout(context);
                        },
                        isBorderColor: true,
                        colorText: Colors.red,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: MyProgressButton(
                        text: AppLocalizations.of(context)!.resend_code_ucf,
                        defaultColor: MyTheme.accent_color_shadow,
                        width: context.getWidth(90),
                        onPressed: () {
                          onTapResend();
                        },
                        isBorderColor: true,
                        colorText: MyTheme.accent_color,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onTapLogout(BuildContext context) async {
    AuthHelper().clearUserData();
    context.pushAndRemoveUntil(MainView());
  }
}
