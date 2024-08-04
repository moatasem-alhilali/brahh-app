import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/middlewares/banned_user.dart';
import 'package:active_ecommerce_flutter/repositories/api-request.dart';
import 'dart:convert';
import 'package:active_ecommerce_flutter/data_model/payment_type_response.dart';
import 'package:active_ecommerce_flutter/data_model/order_create_response.dart';
import 'package:active_ecommerce_flutter/data_model/paypal_url_response.dart';
import 'package:active_ecommerce_flutter/data_model/flutterwave_url_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/data_model/razorpay_payment_success_response.dart';
import 'package:active_ecommerce_flutter/data_model/paystack_payment_success_response.dart';
import 'package:active_ecommerce_flutter/data_model/iyzico_payment_success_response.dart';
import 'package:active_ecommerce_flutter/data_model/bkash_begin_response.dart';
import 'package:active_ecommerce_flutter/data_model/bkash_payment_process_response.dart';
import 'package:active_ecommerce_flutter/data_model/nagad_begin_response.dart';
import 'package:active_ecommerce_flutter/data_model/nagad_payment_process_response.dart';

import 'package:active_ecommerce_flutter/data_model/sslcommerz_begin_response.dart';

class PaymentRepository {
  Future<dynamic> getPaymentResponseList({mode = "", list = "both"}) async {
    String url = ("${AppConfig.BASE_URL}/payment-types?mode=$mode&list=$list");

    final response = await ApiRequest.get(
        url: url,
        headers: {
          "App-Language": app_language.$!,
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!,
        },
        middleware: BannedUser());

    return paymentTypeResponseFromJson(response.body);
  }

  Future<dynamic> getOrderCreateResponse(paymentMethod) async {
    var postBody = jsonEncode({"payment_type": "$paymentMethod"});

    String url = ("${AppConfig.BASE_URL}/order/store");
    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!,
        },
        body: postBody,
        middleware: BannedUser());

    return orderCreateResponseFromJson(response.body);
  }

  Future<PaypalUrlResponse> getPaypalUrlResponse(String paymentType,
      int? combinedOrderId, var packageId, double? amount) async {
    String url =
        ("${AppConfig.BASE_URL}/paypal/payment/url?payment_type=$paymentType&combined_order_id=$combinedOrderId&amount=$amount&user_id=${user_id.$}&package_id=$packageId");
    final response = await ApiRequest.get(url: url, headers: {
      "App-Language": app_language.$!,
    });
    return paypalUrlResponseFromJson(response.body);
  }

  Future<FlutterwaveUrlResponse> getFlutterwaveUrlResponse(String paymentType,
      int? combinedOrderId, var packageId, double? amount) async {
    String url =
        ("${AppConfig.BASE_URL}/flutterwave/payment/url?payment_type=$paymentType&combined_order_id=$combinedOrderId&amount=$amount&user_id=${user_id.$}&package_id=$packageId");

    final response = await ApiRequest.get(url: url, headers: {
      "App-Language": app_language.$!,
    });

    return flutterwaveUrlResponseFromJson(response.body);
  }

  Future<dynamic> getOrderCreateResponseFromWallet(
      paymentMethod, double? amount) async {
    String url = ("${AppConfig.BASE_URL}/payments/pay/wallet");

    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "payment_type": "$paymentMethod",
      "amount": "$amount"
    });

    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!
        },
        body: postBody,
        middleware: BannedUser());

    return orderCreateResponseFromJson(response.body);
  }

  Future<dynamic> getOrderCreateResponseFromCod(paymentMethod) async {
    var postBody = jsonEncode(
        {"user_id": "${user_id.$}", "payment_type": "$paymentMethod"});

    String url = ("${AppConfig.BASE_URL}/payments/pay/cod");

    print(url);
    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}"
        },
        body: postBody,
        middleware: BannedUser());
    print(response.body);

    return orderCreateResponseFromJson(response.body);
  }

  Future<dynamic> getOrderCreateResponseFromManualPayment(paymentMethod) async {
    var postBody = jsonEncode(
        {"user_id": "${user_id.$}", "payment_type": "$paymentMethod"});

    String url = ("${AppConfig.BASE_URL}/payments/pay/manual");

    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!
        },
        body: postBody,
        middleware: BannedUser());

    return orderCreateResponseFromJson(response.body);
  }

  Future<RazorpayPaymentSuccessResponse> getRazorpayPaymentSuccessResponse(
      paymentType,
      double? amount,
      int? combinedOrderId,
      String? paymentDetails) async {
    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "payment_type": "$paymentType",
      "combined_order_id": "$combinedOrderId",
      "amount": "$amount",
      "payment_details": "$paymentDetails"
    });

    String url = ("${AppConfig.BASE_URL}/razorpay/success");

    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!
        },
        body: postBody);

    return razorpayPaymentSuccessResponseFromJson(response.body);
  }

  Future<PaystackPaymentSuccessResponse> getPaystackPaymentSuccessResponse(
      paymentType,
      double? amount,
      int? combinedOrderId,
      String? paymentDetails) async {
    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "payment_type": "$paymentType",
      "combined_order_id": "$combinedOrderId",
      "amount": "$amount",
      "payment_details": "$paymentDetails"
    });

    String url = ("${AppConfig.BASE_URL}/paystack/success");
    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}"
        },
        body: postBody);

    return paystackPaymentSuccessResponseFromJson(response.body);
  }

  Future<IyzicoPaymentSuccessResponse> getIyzicoPaymentSuccessResponse(
      paymentType,
      double? amount,
      int? combinedOrderId,
      String? paymentDetails) async {
    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "payment_type": "$paymentType",
      "combined_order_id": "$combinedOrderId",
      "amount": "$amount",
      "payment_details": "$paymentDetails"
    });

    String url = ("${AppConfig.BASE_URL}/paystack/success");
    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}"
        },
        body: postBody);

    return iyzicoPaymentSuccessResponseFromJson(response.body);
  }

  Future<BkashBeginResponse> getBkashBeginResponse(String paymentType,
      int? combinedOrderId, var packageId, double? amount) async {
    String url =
        ("${AppConfig.BASE_URL}/bkash/begin?payment_type=$paymentType&combined_order_id=$combinedOrderId&amount=$amount&user_id=${user_id.$}&package_id=$packageId");

    print(url.toString());
    final response = await ApiRequest.get(
      url: url,
      headers: {"Authorization": "Bearer ${access_token.$}"},
    );

    return bkashBeginResponseFromJson(response.body);
  }

  Future<BkashPaymentProcessResponse> getBkashPaymentProcessResponse({
    required payment_type,
    required double? amount,
    required int? combined_order_id,
    required String? payment_id,
    required String? token,
    required String package_id,
  }) async {
    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "payment_type": "$payment_type",
      "combined_order_id": "$combined_order_id",
      "package_id": "$package_id",
      "amount": "$amount",
      "payment_id": "$payment_id",
      "token": "$token"
    });

    String url = ("${AppConfig.BASE_URL}/bkash/api/success");
    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!,
        },
        body: postBody);

    return bkashPaymentProcessResponseFromJson(response.body);
  }

  Future<SslcommerzBeginResponse> getSslcommerzBeginResponse(String paymentType,
      int? combinedOrderId, var packageId, double? amount) async {
    String url =
        ("${AppConfig.BASE_URL}/sslcommerz/begin?payment_type=$paymentType&combined_order_id=$combinedOrderId&amount=$amount&user_id=${user_id.$}&package_id=$packageId");

    final response = await ApiRequest.get(
      url: url,
      headers: {
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$!
      },
    );

    return sslcommerzBeginResponseFromJson(response.body);
  }

  Future<NagadBeginResponse> getNagadBeginResponse(String paymentType,
      int? combinedOrderId, var packageId, double? amount) async {
    String url =
        ("${AppConfig.BASE_URL}/nagad/begin?payment_type=$paymentType&combined_order_id=$combinedOrderId&amount=$amount&user_id=${user_id.$}&package_id=$packageId");

    final response = await ApiRequest.get(
      url: url,
      headers: {
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$!
      },
    );

    return nagadBeginResponseFromJson(response.body);
  }

  Future<NagadPaymentProcessResponse> getNagadPaymentProcessResponse(
      paymentType,
      double? amount,
      int? combinedOrderId,
      String? paymentDetails) async {
    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "payment_type": "$paymentType",
      "combined_order_id": "$combinedOrderId",
      "amount": "$amount",
      "payment_details": "$paymentDetails"
    });

    String url = ("${AppConfig.BASE_URL}/nagad/process");

    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!,
        },
        body: postBody);

    return nagadPaymentProcessResponseFromJson(response.body);
  }
}
