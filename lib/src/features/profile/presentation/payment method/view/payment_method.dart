import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../sub_feature/user profile/widget/custom_button.dart';
import '../viewmodel/payment_method_notifier_provider.dart';

class PaymentMethodScreen extends ConsumerStatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  ConsumerState<PaymentMethodScreen> createState() =>
      _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends ConsumerState<PaymentMethodScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvcController.dispose();
    super.dispose();
  }

  bool get _isValid {
    // Basic validation for card details
    final cardNumber = _cardNumberController.text.replaceAll(' ', '');
    final expiry = _expiryController.text;
    final cvc = _cvcController.text;

    return cardNumber.length >= 15 &&
        expiry.length == 5 &&
        cvc.length >= 3 &&
        _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty;
  }

  // Format expiry date as MM/YY
  String? _formatExpiry(String value) {
    value = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (value.length > 2) {
      value = '${value.substring(0, 2)}/${value.substring(2, min(value.length, 4))}';
    }
    return value;
  }

  // Format card number with spaces (e.g., 4242 4242 4242 4242)
  String? _formatCardNumber(String value) {
    value = value.replaceAll(RegExp(r'[^0-9]'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < value.length; i++) {
      buffer.write(value[i]);
      if ((i + 1) % 4 == 0 && i + 1 != value.length) {
        buffer.write(' ');
      }
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(paymentMethodNotifierProvider);
    final notifier = ref.read(paymentMethodNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Payment Method",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add a Payment Method",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 16.h),

            // Name field
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                print("Name input: $value");
              },
            ),
            SizedBox(height: 16.h),

            // Email field
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                print("Email input: $value");
              },
            ),
            SizedBox(height: 16.h),

            // Card Number field
            TextFormField(
              controller: _cardNumberController,
              decoration: InputDecoration(
                labelText: "Card Number",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              maxLength: 19, // 16 digits + 3 spaces
              onChanged: (value) {
                final formatted = _formatCardNumber(value);
                if (formatted != value) {
                  _cardNumberController.value = TextEditingValue(
                    text: formatted ?? value,
                    selection: TextSelection.collapsed(offset: formatted?.length ?? value.length),
                  );
                }
                print("Card number: $value");
              },
            ),
            SizedBox(height: 16.h),

            // Expiry and CVC fields (in a row)
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _expiryController,
                    decoration: InputDecoration(
                      labelText: "MM/YY",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 5, // MM/YY format
                    onChanged: (value) {
                      final formatted = _formatExpiry(value);
                      if (formatted != value) {
                        _expiryController.value = TextEditingValue(
                          text: formatted ?? value,
                          selection: TextSelection.collapsed(offset: formatted?.length ?? value.length),
                        );
                      }
                      print("Expiry: $value");
                    },
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: TextFormField(
                    controller: _cvcController,
                    decoration: InputDecoration(
                      labelText: "CVC",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 4, // CVC is typically 3-4 digits
                    onChanged: (value) {
                      print("CVC: $value");
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Loading indicator
            if (state.isLoading) const Center(child: CircularProgressIndicator()),

            // Message display
            if (state.message != null)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Text(
                  state.message!,
                  style: TextStyle(
                    color: state.message!.contains("success")
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            // Save button
            Mybutton(
              color: Colors.blue,
              text: "Save Card",
              width: double.infinity,
              onTap: !_isValid
                  ? null
                  : () async {
                final cardNumber = _cardNumberController.text.replaceAll(' ', '');
                final expiry = _expiryController.text.split('/');
                final expiryMonth = expiry[0];
                final expiryYear = expiry.length > 1 ? expiry[1] : '';
                final cvc = _cvcController.text;

                print("Saving card: $cardNumber, $expiryMonth/$expiryYear, $cvc");

                await notifier.addCard(
                  cardDetails: CardFieldInputDetails(
                    number: cardNumber,
                    expiryMonth: int.tryParse(expiryMonth) ?? 0,
                    expiryYear: int.tryParse(expiryYear) ?? 0,
                    cvc: cvc,
                    complete: _isValid,
                  ),
                  name: _nameController.text,
                  email: _emailController.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}