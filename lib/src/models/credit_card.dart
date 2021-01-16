import 'package:meta/meta.dart';

class CreditTarget {
  final String cardNumberHidden;
  final String cvv;
  final String brand;
  final String cardNumber;
  final String expiracyDate;
  final String cardHolderName;

  CreditTarget(
      {@required this.cardNumberHidden,
      @required this.cvv,
      @required this.cardNumber,
      @required this.brand,
      @required this.expiracyDate,
      @required this.cardHolderName});
}
