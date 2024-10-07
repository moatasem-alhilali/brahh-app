import 'package:active_ecommerce_flutter/core/base_progress_button.dart';
import 'package:active_ecommerce_flutter/core/failure/request_state.dart';
import 'package:active_ecommerce_flutter/core/my_extensions.dart';
import 'package:active_ecommerce_flutter/core/my_text_form_field.dart';
import 'package:active_ecommerce_flutter/custom/btn.dart';
import 'package:active_ecommerce_flutter/custom/device_info.dart';
import 'package:active_ecommerce_flutter/custom/lang_text.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/ui_elements/auth_ui.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:active_ecommerce_flutter/custom/input_decorations.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:toast/toast.dart';
import 'package:active_ecommerce_flutter/repositories/auth_repository.dart';
import 'package:active_ecommerce_flutter/features/auth/presentation/view/pages/login.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordOtp extends StatefulWidget {
  PasswordOtp({Key? key, this.verify_by = "email", this.email_or_code})
      : super(key: key);
  final String verify_by;
  final String? email_or_code;

  @override
  _PasswordOtpState createState() => _PasswordOtpState();
}

class _PasswordOtpState extends State<PasswordOtp> {
  //controllers
  TextEditingController _codeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  String headeText = "";

  FlipCardController cardController = FlipCardController();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      headeText = AppLocalizations.of(context)!.enter_the_code_sent;
      setState(() {});
    });
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

  ///
  RState confirmCodeState = RState.defaults;

  onPressConfirm() async {
    var code = _codeController.text.toString();
    var password = _passwordController.text.toString();
    var password_confirm = _passwordConfirmController.text.toString();

    if (code == "") {
      ToastComponent.showDialog(AppLocalizations.of(context)!.enter_the_code,
          gravity: Toast.center, duration: Toast.lengthLong);
      return;
    } else if (password == "") {
      ToastComponent.showDialog(AppLocalizations.of(context)!.enter_password,
          gravity: Toast.center, duration: Toast.lengthLong);
      return;
    } else if (password_confirm == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context)!.confirm_your_password,
          gravity: Toast.center,
          duration: Toast.lengthLong);
      return;
    } else if (password.length < 6) {
      ToastComponent.showDialog(
          AppLocalizations.of(context)!
              .password_must_contain_at_least_6_characters,
          gravity: Toast.center,
          duration: Toast.lengthLong);
      return;
    } else if (password != password_confirm) {
      ToastComponent.showDialog(
          AppLocalizations.of(context)!.passwords_do_not_match,
          gravity: Toast.center,
          duration: Toast.lengthLong);
      return;
    }

    confirmCodeState = RState.loading;
    setState(() {});
    var passwordConfirmResponse =
        await AuthRepository().getPasswordConfirmResponse(code, password);

    if (passwordConfirmResponse.result == false) {
      resendCodeState = RState.error;
      setState(() {});
      await Future.delayed(Duration(seconds: 1));
      resendCodeState = RState.defaults;
      setState(() {});
      ToastComponent.showDialog(passwordConfirmResponse.message!,
          gravity: Toast.center, duration: Toast.lengthLong);
    } else {
      resendCodeState = RState.success;
      setState(() {});
      await Future.delayed(Duration(seconds: 1));
      resendCodeState = RState.defaults;
      setState(() {});
      ToastComponent.showDialog(passwordConfirmResponse.message!,
          gravity: Toast.center, duration: Toast.lengthLong);

      headeText = AppLocalizations.of(context)!.password_changed_ucf;
      cardController.toggleCard();
      setState(() {});
    }
  }

  RState resendCodeState = RState.defaults;
  onTapResend() async {
    resendCodeState = RState.loading;
    setState(() {});

    var passwordResendCodeResponse = await AuthRepository()
        .getPasswordResendCodeResponse(widget.email_or_code, widget.verify_by);

    if (passwordResendCodeResponse.result == false) {
      resendCodeState = RState.error;
      setState(() {});
      await Future.delayed(Duration(seconds: 1));
      resendCodeState = RState.defaults;
      setState(() {});
      ToastComponent.showDialog(passwordResendCodeResponse.message!,
          gravity: Toast.center, duration: Toast.lengthLong);
    } else {
      resendCodeState = RState.success;
      setState(() {});
      await Future.delayed(Duration(seconds: 1));
      resendCodeState = RState.defaults;
      setState(() {});
      ToastComponent.showDialog(passwordResendCodeResponse.message!,
          gravity: Toast.center, duration: Toast.lengthLong);
    }
  }

  gotoLoginScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    String _verify_by = widget.verify_by; //phone or email
    return AuthScreen.buildScreen(
        context,
        headeText,
        WillPopScope(
            onWillPop: () {
              gotoLoginScreen();
              return Future.delayed(Duration.zero);
            },
            child: buildBody(context, _verify_by)));
  }

  Widget buildBody(BuildContext context, String _verify_by) {
    return FlipCard(
      flipOnTouch: false,
      controller: cardController,
      //fill: Fill.fillBack, // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.HORIZONTAL,
      // default
      front: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Container(
                width: context.getWidth(90),
                child: _verify_by == "email"
                    ? Text(
                        AppLocalizations.of(context)!
                            .enter_the_verification_code_that_sent_to_your_email_recently,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: MyTheme.dark_grey, fontSize: 14))
                    : Text(
                        AppLocalizations.of(context)!
                            .enter_the_verification_code_that_sent_to_your_phone_recently,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: MyTheme.dark_grey, fontSize: 14),
                      ),
              ),
            ),
            Container(
              width: context.getWidth(90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextFormField(
                    labelText: "Enter The Code",
                    hintText: "A X B 4 J H",
                    controller: _codeController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextFormField(
                          labelText: AppLocalizations.of(context)!.password_ucf,
                          hintText: "• • • • • • • •",
                          controller: _passwordController,
                        ),
                        MyTextFormField(
                          labelText:
                              AppLocalizations.of(context)!.retype_password_ucf,
                          hintText: "• • • • • • • •",
                          controller: _passwordConfirmController,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            AppLocalizations.of(context)!
                                .password_must_contain_at_least_6_characters,
                            style: TextStyle(
                              color: MyTheme.grey_153,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyProgressButton(
                          state: confirmCodeState,
                          onPressed: () {
                            onPressConfirm();
                          },
                          text: AppLocalizations.of(context)!.confirm_ucf,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: MyProgressButton(
                          state: resendCodeState,
                          text: AppLocalizations.of(context)!.resend_code_ucf,
                          onPressed: () {
                            onTapResend();
                          },
                          defaultColor: MyTheme.accent_color_shadow,
                          colorText: MyTheme.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      back: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Container(
                  width: context.getWidth(90),
                  child: Text(LangText(context).local!.congratulations_ucf,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: MyTheme.accent_color,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Container(
                width: context.getWidth(90),
                child: Text(
                  LangText(context)
                      .local!
                      .you_have_successfully_changed_your_password,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: MyTheme.accent_color,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Image.asset(
                'assets/changed_password.png',
                width: DeviceInfo(context).width! / 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 45,
                child: Btn.basic(
                  minWidth: MediaQuery.of(context).size.width,
                  color: MyTheme.accent_color,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(6.0))),
                  child: Text(
                    AppLocalizations.of(context)!.back_to_Login_ucf,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    gotoLoginScreen();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}