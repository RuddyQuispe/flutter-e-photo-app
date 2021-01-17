import 'package:dio/dio.dart';
import 'package:flutter_e_photograph_app/src/models/payment_intent_response.dart';
import 'package:flutter_e_photograph_app/src/models/stripe_custom_response.dart';
import 'package:meta/meta.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  StripeService._privateConstructor();
  static final StripeService _intance = StripeService._privateConstructor();
  factory StripeService() => _intance;

  final String _paymentApiUrl = "https://api.stripe.com/v1/payment_intents";
  static final String _secretKey =
      "sk_test_51I923EECjsiDCI9qwX0A3LR9Ce5xjydVan8WS4afanzrQwlk6rp3ju9RHAosVYxT7VmwOP8VoKqEZdPKB5vR4L2K00TnfbjOWv";
  final String _apiKey =
      "pk_test_51I923EECjsiDCI9qLFqtZKSJBBPW7X2gBkr4staL2e6fFK66NjGm9jaSJnBF8PaLej09F6PbjQQPiBLslPbU9dNZ00Znw7yFm0";

  final headerOptions = new Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {'Authorization': 'Bearer ${StripeService._secretKey}'});

  void init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey: this._apiKey,
        androidPayMode: 'test',
        merchantId: 'test'));
  }

  Future buyAppPayGooglePay(
      {@required String amount, @required String currency}) async {}

  /*
   * Buy a new card
   */
  Future<StripeCustomResponse> buyNewCard(
      {@required String amount, @required String currency}) async {
    try {
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      final resp = await this._makePayment(
          amount: amount, currency: currency, paymentMethod: paymentMethod);
      return resp;
    } catch (e) {
      return StripeCustomResponse(success: false, message: e.toString());
    }
  }

  Future<PaymentIntentResponse> _makePaymentIntent(
      {@required String amount, @required String currency}) async {
    try {
      final dio = new Dio();
      final data = {'amount': amount, 'currency': currency};
      final response =
          await dio.post(_paymentApiUrl, data: data, options: headerOptions);
      return PaymentIntentResponse.fromJson(response.data);
    } catch (e) {
      print("Ocurrió un error con el payment intent response");
      return PaymentIntentResponse(status: "400");
    }
  }

  Future<StripeCustomResponse> _makePayment(
      {@required String amount,
      @required String currency,
      @required PaymentMethod paymentMethod}) async {
    try {
      // Crear el intent
      final paymentIntent =
          await this._makePaymentIntent(amount: amount, currency: currency);
      final paymentResult = await StripePayment.confirmPaymentIntent(
          PaymentIntent(
              clientSecret: paymentIntent.clientSecret,
              paymentMethodId: paymentMethod.id));
      if (paymentResult.status == 'succeeded') {
        return StripeCustomResponse(success: true);
      } else {
        return StripeCustomResponse(
            success: false,
            message:
                'Error in method _makePayment(String amount,String currency, PaymentMethod paymentMethod): ${paymentResult.status}');
      }
    } catch (e) {
      print(e.toString());
      return StripeCustomResponse(success: false, message: e.toString());
    }
  }
}
