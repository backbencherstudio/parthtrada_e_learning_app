import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/src/features/book_expert/model/get_card_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../viewmodel/payment_method_notifier_provider.dart';

class PaymentMethodScreen extends ConsumerStatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  ConsumerState<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends ConsumerState<PaymentMethodScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch card data when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(paymentMethodNotifierProvider.notifier).getCards();
    });
  }

  @override
  Widget build(BuildContext context) {
    final paymentState = ref.watch(paymentMethodNotifierProvider);
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        title: Text(
          'Payment Methods',
          style: textStyle.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: paymentState.isLoadingGetPaymentMethod
          ? const Center(
        child: CircularProgressIndicator(color: Color(0xFF4CAF50)),
      )
          : paymentState.isSuccessGetPaymentMethod &&
          paymentState.cardsResponse != null
          ? SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Cards',
              style: textStyle.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.h),
            paymentState.cardsResponse!.data.isEmpty
                ? Center(
              child: Text(
                'No cards found',
                style: textStyle.bodyMedium?.copyWith(
                  color: const Color(0xFFA5A5AB),
                ),
              ),
            )
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
              paymentState.cardsResponse!.data.length,
              itemBuilder: (context, index) {
                final card = paymentState.cardsResponse!.data[index];
                return _buildCardTile(card, textStyle);
              },
            ),
            SizedBox(height: 80.h), // Add space for FAB visibility
          ],
        ),
      )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              paymentState.errorMessageGetPaymentMethod ??
                  'Failed to load cards',
              style: textStyle.bodyMedium?.copyWith(
                color: Colors.redAccent,
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () => ref
                  .read(paymentMethodNotifierProvider.notifier)
                  .getCards(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                padding: EdgeInsets.symmetric(
                    horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Retry',
                style: textStyle.labelLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4CAF50),
        onPressed: () => context.push(RouteName.addPaymentMethod),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );

  }

  Widget _buildCardTile(CardModel card, TextTheme textStyle) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A), // Dark card background
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Card icon based on brand
          Icon(
            card.brand.toLowerCase().contains('visa')
                ? Icons.credit_card
                : card.brand.toLowerCase().contains('mastercard')
                ? Icons.credit_card
                : Icons.payment,
            color: Colors.white,
            size: 32.sp,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${card.brand} ending in ${card.last4}',
                  style: textStyle.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Expires: ${card.expMonth.toString().padLeft(2, '0')}/${card.expYear}',
                  style: textStyle.bodyMedium?.copyWith(
                    color: const Color(0xFFA5A5AB),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}