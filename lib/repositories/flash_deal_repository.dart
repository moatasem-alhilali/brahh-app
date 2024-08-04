import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/data_model/flash_deal_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/repositories/api-request.dart';

import '../helpers/system_config.dart';

class FlashDealRepository {
  getFlashDeals() async {
    try {
      String url = ("${AppConfig.BASE_URL}/flash-deals");
      final response = await ApiRequest.get(
        url: url,
        headers: {
          "App-Language": app_language.$!,
          "Currency-Code": SystemConfig.systemCurrency!.code!,
          "Currency-Exchange-Rate":
              SystemConfig.systemCurrency!.exchangeRate.toString(),
        },
      );

      return flashDealResponseFromJson(response.body.toString());
    } catch (e) {
      print("====================getFlashDeals=======================");
      print(e);
      print("====================getFlashDeals=======================");
    }
  }
}
