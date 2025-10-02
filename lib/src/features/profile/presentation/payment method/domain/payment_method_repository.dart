abstract class PaymentMethodRepository {
  Future<String>addPaymentMethod(String cardNumber,String expMonth, String expYear, String cvc);
  Future<bool> addCard(String token);
}
