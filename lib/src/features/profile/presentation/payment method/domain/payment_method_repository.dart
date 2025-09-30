abstract class PaymentMethodRepository {
  Future<String> createSetupIntent();
  Future<bool> savePaymentMethod(String paymentMethodId);
}
