import 'package:e_learning_app/src/features/profile/presentation/payment%20method/data/models/account_status_response.dart';

abstract class PaymentMethodRepository {
  Future<String>addPaymentMethod(String cardNumber,String expMonth, String expYear, String cvc);
  Future<bool> addCard(String token);
  Future<bool> createAccount();
  Future<String>getOnbordingUrl();
  Future<AccountStatusResponse>getAccountStatus();
}
