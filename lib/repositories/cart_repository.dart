import 'dart:convert';

import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/data_model/cart_add_response.dart';
import 'package:active_ecommerce_flutter/data_model/cart_count_response.dart';
import 'package:active_ecommerce_flutter/data_model/cart_delete_response.dart';
import 'package:active_ecommerce_flutter/data_model/cart_process_response.dart';
import 'package:active_ecommerce_flutter/data_model/cart_response.dart';
import 'package:active_ecommerce_flutter/data_model/cart_summary_response.dart';
import 'package:active_ecommerce_flutter/data_model/check_response_model.dart';
import 'package:active_ecommerce_flutter/helpers/response_check.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/helpers/system_config.dart';
import 'package:active_ecommerce_flutter/main.dart';
import 'package:active_ecommerce_flutter/middlewares/banned_user.dart';
import 'package:active_ecommerce_flutter/repositories/api-request.dart';

class CartRepository {
  Future<dynamic> getCartResponseList(
    int? userId,
  ) async {
    String url = ("${AppConfig.BASE_URL}/carts");
    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!,
          "Currency-Code": SystemConfig.systemCurrency!.code.toString(),
          "Currency-Exchange-Rate":
              SystemConfig.systemCurrency!.exchangeRate.toString(),
        },
        body: '',
        middleware: BannedUser());
    logger.d(jsonDecode(response.body));
    return cartResponseFromJson(response.body);
  }

  Future<dynamic> getCartCount() async {
    if (is_logged_in.$) {
      String url = ("${AppConfig.BASE_URL}/cart-count");
      final response = await ApiRequest.get(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!,
        },
      );
      bool checkResult = ResponseCheck.apply(response.body);

      if (!checkResult) return responseCheckModelFromJson(response.body);

      return cartCountResponseFromJson(response.body);
    } else {
      return CartCountResponse(count: 0, status: false);
    }
  }

  Future<dynamic> getCartDeleteResponse(
    int? cartId,
  ) async {
    String url = ("${AppConfig.BASE_URL}/carts/$cartId");
    final response = await ApiRequest.delete(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!
        },
        middleware: BannedUser());
    return cartDeleteResponseFromJson(response.body);
  }

  Future<dynamic> getCartProcessResponse(
      String cartIds, String cartQuantities) async {
    var postBody = jsonEncode(
        {"cart_ids": "${cartIds}", "cart_quantities": "$cartQuantities"});

    String url = ("${AppConfig.BASE_URL}/carts/process");
    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!
        },
        body: postBody,
        middleware: BannedUser());
    return cartProcessResponseFromJson(response.body);
  }

  Future<dynamic> getCartAddResponse(
      int? id, String? variant, int? userId, int? quantity) async {
    var postBody = jsonEncode({
      "id": "${id}",
      "variant": variant,
      "user_id": "$userId",
      "quantity": "$quantity",
      "cost_matrix": AppConfig.purchase_code
    });

    String url = ("${AppConfig.BASE_URL}/carts/add");
    final response = await ApiRequest.post(
      url: url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$!
      },
      body: postBody,
      middleware: BannedUser(),
    );
    print(response.body);

    return cartAddResponseFromJson(response.body);
  }

  Future<dynamic> getCartSummaryResponse() async {
    String url = ("${AppConfig.BASE_URL}/cart-summary");
    print(" cart summary");
    final response = await ApiRequest.get(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!,
          "Currency-Code": SystemConfig.systemCurrency!.code!,
          "Currency-Exchange-Rate":
              SystemConfig.systemCurrency!.exchangeRate.toString(),
        },
        middleware: BannedUser());

    return cartSummaryResponseFromJson(response.body);
  }
}
