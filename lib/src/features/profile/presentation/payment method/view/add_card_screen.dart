import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/theme_part/app_colors.dart';
import '../../../../book_expert/rvierpod/get_card_notifier.dart';
import '../../../sub_feature/user profile/widget/custom_button.dart';
import '../viewmodel/payment_method_notifier_provider.dart';

class AddCardScreen extends ConsumerStatefulWidget {
  const AddCardScreen({super.key});

  @override
  ConsumerState<AddCardScreen> createState() =>
      _AddCardScreenState();
}

class _AddCardScreenState extends ConsumerState<AddCardScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();

  String? _expiryError;
  String? _cvcError;

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
    final cardNumber = _cardNumberController.text.replaceAll(' ', '');
    final expiry = _expiryController.text;
    final cvc = _cvcController.text;

    if (_nameController.text.isEmpty || _emailController.text.isEmpty) return false;

    if (cardNumber.length < 15 || cardNumber.length > 19) return false;

    if (cvc.length != 3) return false;

    // Expiry validation
    final expiryParts = expiry.split('/');
    if (expiryParts.length != 2 ||
        expiryParts[0].length != 2 ||
        expiryParts[1].length != 2) {
      return false;
    }

    final int? month = int.tryParse(expiryParts[0]);
    final int? year = int.tryParse(expiryParts[1]);

    if (month == null || year == null || month < 1 || month > 12) {
      return false;
    }

    final fullYear = 2000 + year;
    final now = DateTime.now();
    final currentYear = now.year;
    final currentMonth = now.month;

    if (fullYear < currentYear || (fullYear == currentYear && month < currentMonth)) {
      return false;
    }

    return true;
  }

  void _validateExpiry() {
    final value = _expiryController.text;
    _expiryError = null;

    if (value.isEmpty) return;

    final parts = value.split('/');
    if (parts.length != 2 || parts[0].length != 2 || parts[1].length != 2) {
      _expiryError = "Enter MM/YY";
      return;
    }

    final int? mm = int.tryParse(parts[0]);
    final int? yy = int.tryParse(parts[1]);

    if (mm == null || yy == null) {
      _expiryError = "Invalid format";
      return;
    }

    if (mm < 1 || mm > 12) {
      _expiryError = "Invalid month";
      return;
    }

    final fullYear = 2000 + yy;
    final now = DateTime.now();
    final currentYear = now.year;
    final currentMonth = now.month;

    if (fullYear < currentYear || (fullYear == currentYear && mm < currentMonth)) {
      _expiryError = "Expiry date must be in the future";
    }
  }

  void _validateCvc() {
    final value = _cvcController.text;
    _cvcError = value.length != 3 ? "CVC must be 3 digits" : null;
  }

  // Format expiry date as MM/YY
  String? _formatExpiry(String value) {
    value = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (value.length > 2) {
      value =
      '${value.substring(0, 2)}/${value.substring(2, min(value.length, 4))}';
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
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () async {
              await ref.read(cardProvider.notifier).fetchCards();
              Navigator.pop(context);
            }
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
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}), // Update UI on input change
            ),
            SizedBox(height: 16.h),

            // Email field
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (_) => setState(() {}), // Update UI on input change
            ),
            SizedBox(height: 16.h),

            // Card Number field
            TextFormField(
              controller: _cardNumberController,
              decoration: const InputDecoration(
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
                    selection: TextSelection.collapsed(
                        offset: formatted?.length ?? value.length),
                  );
                }
                setState(() {}); // Update UI on input change
              },
            ),
            SizedBox(height: 16.h),

            // Expiry + CVC fields in row
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _expiryController,
                    decoration: InputDecoration(
                      labelText: "MM/YY",
                      border: OutlineInputBorder(),
                      errorText: _expiryError,
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                    onChanged: (value) {
                      final formatted = _formatExpiry(value);
                      if (formatted != value) {
                        _expiryController.value = TextEditingValue(
                          text: formatted ?? value,
                          selection: TextSelection.collapsed(
                              offset: formatted?.length ?? value.length),
                        );
                      }
                      _validateExpiry();
                      setState(() {}); // Update UI on input change
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
                      errorText: _cvcError,
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    onChanged: (value) {
                      _validateCvc();
                      setState(() {}); // Update UI on input change
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),


            // Save button
            Mybutton(
              color: AppColors.primary,
              text: state.isLoading ? "Saving..." : "Save Card",
              width: double.infinity,
              onTap: (!_isValid || state.isLoading)
                  ? null
                  : () async {
                final cardNumber = _cardNumberController.text.replaceAll(' ', '');
                final expiry = _expiryController.text.split('/');
                final expiryMonth = expiry[0];
                final expiryYear = expiry.length > 1 ? expiry[1] : '';
                final cvc = _cvcController.text;

                await notifier.addNewCard(
                  cardNumber: cardNumber,
                  expMonth: expiryMonth,
                  expYear: expiryYear,
                  cvc: cvc,
                );

                final newState = ref.read(paymentMethodNotifierProvider);
                if (!newState.isLoading &&
                    newState.message != null &&
                    newState.message!.toLowerCase().contains("success")) {
                  Future.delayed(const Duration(milliseconds: 800), () async {
                    if (mounted) {
                      await ref.read(cardProvider.notifier).fetchCards();
                      Navigator.pop(context);
                    }
                  });
                }
              },
            ),

            // Display validation errors below the button if present
            if (_expiryError != null || _cvcError != null)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Column(
                  children: [
                    if (_expiryError != null)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(color: Colors.red.withOpacity(0.3)),
                        ),
                        child: Text(
                          _expiryError!,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    if (_cvcError != null)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(color: Colors.red.withOpacity(0.3)),
                        ),
                        child: Text(
                          _cvcError!,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                  ],
                ),
              ),

            if (state.isLoading)
              const Center(child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              )),

            if (state.message != null)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Center(
                  child: Builder(
                    builder: (context) {
                      String displayMessage = state.message!;
                      bool isSuccess = displayMessage.toLowerCase().contains("success");
                      if (!isSuccess && (displayMessage.toLowerCase().contains("error") || displayMessage.toLowerCase().contains("failed"))) {
                        displayMessage = "Please check your card details and try again.";
                      }
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.w),
                        child: Text(
                          displayMessage,
                          style: TextStyle(
                            color: isSuccess ? Colors.green : Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: null,
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}




// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../../core/theme/theme_part/app_colors.dart';
// import '../../../../book_expert/rvierpod/get_card_notifier.dart';
// import '../../../sub_feature/user profile/widget/custom_button.dart';
// import '../viewmodel/payment_method_notifier_provider.dart';
//
// class AddCardScreen extends ConsumerStatefulWidget {
//   const AddCardScreen({super.key});
//
//   @override
//   ConsumerState<AddCardScreen> createState() =>
//       _AddCardScreenState();
// }
//
// class _AddCardScreenState extends ConsumerState<AddCardScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _cardNumberController = TextEditingController();
//   final TextEditingController _expiryController = TextEditingController();
//   final TextEditingController _cvcController = TextEditingController();
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _cardNumberController.dispose();
//     _expiryController.dispose();
//     _cvcController.dispose();
//     super.dispose();
//   }
//
//   bool get _isValid {
//     final cardNumber = _cardNumberController.text.replaceAll(' ', '');
//     final expiry = _expiryController.text;
//     final cvc = _cvcController.text;
//
//     // Additional validation for expiry (MM/YY format)
//     final expiryParts = expiry.split('/');
//     final isExpiryValid = expiryParts.length == 2 &&
//         expiryParts[0].length == 2 &&
//         expiryParts[1].length == 2 &&
//         int.tryParse(expiryParts[0]) != null &&
//         int.tryParse(expiryParts[0])! >= 1 &&
//         int.tryParse(expiryParts[0])! <= 12;
//
//     return cardNumber.length >= 15 &&
//         isExpiryValid &&
//         cvc.length >= 3 &&
//         _nameController.text.isNotEmpty &&
//         _emailController.text.isNotEmpty;
//   }
//
//   // Format expiry date as MM/YY
//   String? _formatExpiry(String value) {
//     value = value.replaceAll(RegExp(r'[^0-9]'), '');
//     if (value.length > 2) {
//       value =
//       '${value.substring(0, 2)}/${value.substring(2, min(value.length, 4))}';
//     }
//     return value;
//   }
//
//   // Format card number with spaces (e.g., 4242 4242 4242 4242)
//   String? _formatCardNumber(String value) {
//     value = value.replaceAll(RegExp(r'[^0-9]'), '');
//     final buffer = StringBuffer();
//     for (int i = 0; i < value.length; i++) {
//       buffer.write(value[i]);
//       if ((i + 1) % 4 == 0 && i + 1 != value.length) {
//         buffer.write(' ');
//       }
//     }
//     return buffer.toString();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(paymentMethodNotifierProvider);
//     final notifier = ref.read(paymentMethodNotifierProvider.notifier);
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: Text(
//           "Payment Method",
//           style: Theme.of(context)
//               .textTheme
//               .bodyLarge!
//               .copyWith(fontWeight: FontWeight.w700),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () async {
//             await ref.read(cardProvider.notifier).fetchCards();
//             Navigator.pop(context);
//           }
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(24.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Add a Payment Method",
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//             SizedBox(height: 16.h),
//
//             // Name field
//             TextFormField(
//               controller: _nameController,
//               decoration: const InputDecoration(
//                 labelText: "Name",
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: (_) => setState(() {}), // Update UI on input change
//             ),
//             SizedBox(height: 16.h),
//
//             // Email field
//             TextFormField(
//               controller: _emailController,
//               decoration: const InputDecoration(
//                 labelText: "Email",
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.emailAddress,
//               onChanged: (_) => setState(() {}), // Update UI on input change
//             ),
//             SizedBox(height: 16.h),
//
//             // Card Number field
//             TextFormField(
//               controller: _cardNumberController,
//               decoration: const InputDecoration(
//                 labelText: "Card Number",
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.number,
//               maxLength: 19, // 16 digits + 3 spaces
//               onChanged: (value) {
//                 final formatted = _formatCardNumber(value);
//                 if (formatted != value) {
//                   _cardNumberController.value = TextEditingValue(
//                     text: formatted ?? value,
//                     selection: TextSelection.collapsed(
//                         offset: formatted?.length ?? value.length),
//                   );
//                 }
//                 setState(() {}); // Update UI on input change
//               },
//             ),
//             SizedBox(height: 16.h),
//
//             // Expiry + CVC fields in row
//             Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     controller: _expiryController,
//                     decoration: const InputDecoration(
//                       labelText: "MM/YY",
//                       border: OutlineInputBorder(),
//                     ),
//                     keyboardType: TextInputType.number,
//                     maxLength: 5,
//                     onChanged: (value) {
//                       final formatted = _formatExpiry(value);
//                       if (formatted != value) {
//                         _expiryController.value = TextEditingValue(
//                           text: formatted ?? value,
//                           selection: TextSelection.collapsed(
//                               offset: formatted?.length ?? value.length),
//                         );
//                       }
//                       setState(() {}); // Update UI on input change
//                     },
//                   ),
//                 ),
//                 SizedBox(width: 16.w),
//                 Expanded(
//                   child: TextFormField(
//                     controller: _cvcController,
//                     decoration: const InputDecoration(
//                       labelText: "CVC",
//                       border: OutlineInputBorder(),
//                     ),
//                     keyboardType: TextInputType.number,
//                     maxLength: 4,
//                     onChanged: (_) => setState(() {}), // Update UI on input change
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 24.h),
//
//
//             // Save button
//             Mybutton(
//               color: AppColors.primary,
//               text: state.isLoading ? "Saving..." : "Save Card",
//               width: double.infinity,
//               onTap: (!_isValid || state.isLoading)
//                   ? null
//                   : () async {
//                 final cardNumber = _cardNumberController.text.replaceAll(' ', '');
//                 final expiry = _expiryController.text.split('/');
//                 final expiryMonth = expiry[0];
//                 final expiryYear = expiry.length > 1 ? expiry[1] : '';
//                 final cvc = _cvcController.text;
//
//                 await notifier.addNewCard(
//                   cardNumber: cardNumber,
//                   expMonth: expiryMonth,
//                   expYear: expiryYear,
//                   cvc: cvc,
//                 );
//
//                 final newState = ref.read(paymentMethodNotifierProvider);
//                 if (!newState.isLoading &&
//                     newState.message != null &&
//                     newState.message!.toLowerCase().contains("success")) {
//                   Future.delayed(const Duration(milliseconds: 800), () async {
//                     if (mounted) {
//                       await ref.read(cardProvider.notifier).fetchCards();
//                       Navigator.pop(context);
//                     }
//                   });
//                 }
//               },
//             ),
//
//             if (state.isLoading)
//               const Center(child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: CircularProgressIndicator(),
//               )),
//
//             if (state.message != null)
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 12.h),
//                 child: Center(
//                   child: Text(
//                     state.message!,
//                     style: TextStyle(
//                       color: state.message!.contains("success")
//                           ? Colors.green
//                           : Colors.red,
//                       fontWeight: FontWeight.w600,
//                     ),
//
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }