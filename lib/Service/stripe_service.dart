// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:drivy_driver/Component/custom_toast.dart';
//
// class StripeService {
//   static CardDetails? _cardDetails;
//   static TokenData? _tokenData;
//
//   static Future<String?>? stripeToken(
//       {String? cardNumber,
//       String? expMonth,
//       String? expYear,
//       String? cvc}) async {
//     String? _cardToken;
//     try {
//       _cardDetails = CardDetails(
//         number: cardNumber ?? "",
//         expirationMonth: int.parse(expMonth ?? "0"),
//         expirationYear: int.parse(expYear ?? "0"),
//         cvc: cvc ?? "",
//       );
//       Stripe.instance.dangerouslyUpdateCardDetails(_cardDetails!);
//       _tokenData = await Stripe.instance.createToken(CreateTokenParams.card(params: CardTokenParams()));
//       print("Token Data:${_tokenData}");
//       _cardToken = _tokenData?.id;
//     } on StripeException catch (ex) {
//       CustomToast().showToast('Error', ex.error.message ?? "", true);
//     } catch (ex) {
//       CustomToast().showToast('Error', ex.toString(), true);
//     }
//     return _cardToken;
//   }
// }
