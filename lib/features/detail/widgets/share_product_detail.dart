import 'package:active_ecommerce_flutter/core/base_progress_button.dart';
import 'package:active_ecommerce_flutter/core/my_extensions.dart';
import 'package:active_ecommerce_flutter/core/resources/assets_fonts.dart';
import 'package:active_ecommerce_flutter/custom/btn.dart';
import 'package:active_ecommerce_flutter/data_model/product_details_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_share/social_share.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShareProductDetail extends StatelessWidget {
  const ShareProductDetail({
    super.key,
    required this.productDetails,
    required this.onPressedCopy,
    required this.showCopied,
  });

  final Function()? onPressedCopy;
  final bool showCopied;
  final DetailedProduct? productDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          MyProgressButton(
            text: AppLocalizations.of(context)!.copy_product_link_ucf,
            width: double.infinity,
            borderRadius: 8,
            isBorderColor: true,
            colorText: MyTheme.accent_color_shadow,
            border: Border.all(
              color: MyTheme.accent_color_shadow,
            ),
            onPressed: () {
              onPressedCopy!();
            },
          ),
          MyProgressButton(
            text: AppLocalizations.of(context)!.share_options_ucf,
            width: double.infinity,
            borderRadius: 8,
            isBorderColor: true,
            colorText: MyTheme.accent_color,
            border: Border.all(
              color: MyTheme.accent_color,
            ),
            onPressed: () {
              SocialShare.shareOptions(productDetails!.link!);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyProgressButton(
              text: "اغلاق",
              width: double.infinity,
              borderRadius: 8,
              onPressed: () {
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
