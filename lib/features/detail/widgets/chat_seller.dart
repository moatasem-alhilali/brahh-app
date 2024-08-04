import 'package:active_ecommerce_flutter/core/base_progress_button.dart';
import 'package:active_ecommerce_flutter/core/my_extensions.dart';
import 'package:active_ecommerce_flutter/core/my_text_form_field.dart';
import 'package:flutter/material.dart';


import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatSellerSheet extends StatelessWidget {
  const ChatSellerSheet({
    super.key,
    required this.sellerChatMessageController,
    required this.sellerChatTitleController,
    this.onPressSendMessage,
  });

  final void Function()? onPressSendMessage;
  final TextEditingController sellerChatMessageController;
  final TextEditingController sellerChatTitleController;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextFormField(
                    labelText: AppLocalizations.of(context)!.title_ucf,
                    controller: sellerChatTitleController,
                    hintText: AppLocalizations.of(context)!.enter_title_ucf,
                  ),
                  MyTextFormField(
                    labelText: AppLocalizations.of(context)!.message_ucf,
                    controller: sellerChatMessageController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    hintText: AppLocalizations.of(context)!.enter_message_ucf,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: MyProgressButton(
                      borderRadius: 8,
                      text: AppLocalizations.of(context)!.close_all_capital,
                      // defaultColor: Color.fromRGBO(189, 189, 189, 1),
                      colorText: Colors.white,
                      onPressed: () {
                        context.pop();
                        // Navigator.of(context, rootNavigator: true).pop();
                      },
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: MyProgressButton(
                      borderRadius: 8,

                      text: AppLocalizations.of(context)!.send_all_capital,
                      // defaultColor: Color.fromRGBO(253, 253, 253, 1),
                      onPressed: () {
                        context.pop();

                        // Navigator.of(context, rootNavigator: true).pop();
                        onPressSendMessage!();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
