import '../models/credit_card.dart';

final List<CreditTarget> cards = <CreditTarget>[
  CreditTarget(
      cardNumberHidden: '4242',
      cvv: '213',
      cardNumber: '4242424242424242',
      brand: 'visa',
      expiracyDate: '01/25',
      cardHolderName: 'Ruddy Quispe'),
  CreditTarget(
      cardNumberHidden: '5555',
      cvv: '213',
      cardNumber: '5555555555555555',
      brand: 'mastercard',
      expiracyDate: '01/25',
      cardHolderName: 'Melisa Flores'),
  CreditTarget(
      cardNumberHidden: '3782',
      cvv: '2134',
      cardNumber: '3782822463100050',
      brand: 'american express',
      expiracyDate: '01/25',
      cardHolderName: 'Conrado Moscoso')
];

// probar

// child: Image.network(pictureUrl, fit: BoxFit.cover),
