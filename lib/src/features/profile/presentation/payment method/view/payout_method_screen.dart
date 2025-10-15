import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/src/features/profile/presentation/payment%20method/view/webview_screen.dart' show WebViewScreen, StripeWebViewScreen;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../viewmodel/payment_method_notifier_provider.dart';


class PayoutMethodScreen extends ConsumerStatefulWidget {
  const PayoutMethodScreen({super.key});

  @override
  _PayoutMethodScreenState createState() => _PayoutMethodScreenState();
}

class _PayoutMethodScreenState extends ConsumerState<PayoutMethodScreen> {

  @override
  Widget build(BuildContext context) {
    final paymentState = ref.watch(paymentMethodNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black45,
        title: const Text(
          'Payout Method',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: paymentState.isLoadingAccountStatus
            ? const CircularProgressIndicator()
            : paymentState.errorMessageAccountStatus != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 50),
            const SizedBox(height: 16),
            Text(
              paymentState.errorMessageAccountStatus!.contains('rate limit')
                  ? 'Rate limit exceeded. Please try again later.'
                  : paymentState.errorMessageAccountStatus!,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(paymentMethodNotifierProvider.notifier).getAccountStatus();
              },
              child: const Text('Retry'),
            ),
          ],
        )
            : _buildAccountStatusContent(context, ref, paymentState),
      ),
    );
  }

  Widget _buildAccountStatusContent(BuildContext context, WidgetRef ref, PaymentMethodState state) {
    final accountStatus = state.accountStatus;

    if (accountStatus == null) {
      return const Text('No account status available');
    }

    if (accountStatus.isOnboarded == true) {
      // Account is connected
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_balance_wallet, color: Colors.green, size: 50),
            const SizedBox(height: 16),
            Text(
              'Account Connected',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Account ID: ${accountStatus.accountId ?? 'N/A'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            // if (accountStatus.requirements?.currentlyDue?.isNotEmpty == true)
            //   Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 8.0),
            //     child: Text(
            //       'Pending Requirements: ${accountStatus.requirements!.currentlyDue!.join(', ')}',
            //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red),
            //     ),
            //   ),
            // if (accountStatus.requirements?.disabledReason != null)
            //   Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 8.0),
            //     child: Text(
            //       'Disabled Reason: ${accountStatus.requirements!.disabledReason}',
            //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red),
            //     ),
            //   ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {

                context.pushNamed(RouteName.withdrawScreen);

              },
              child: const Text('Withdraw'),
            ),
          ],
        ),
      );
    } else {
      // Account is not connected
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.account_balance_wallet_outlined, size: 50),
          const SizedBox(height: 16),
          Text(
            'No Payout Account Connected',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          state.isLoadingCreateAccount || state.isLoadingOnboardingUrl
              ? const CircularProgressIndicator()
              : ElevatedButton(
            onPressed: () async {
              try {
                // Step 1: Create account
                await ref.read(paymentMethodNotifierProvider.notifier).createAccount();
                final newState = ref.read(paymentMethodNotifierProvider);
                if (newState.isSuccessCreateAccount != true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(newState.errorMessageCreateAccount ?? 'Failed to create account'),
                    ),
                  );
                 // return;
                }

                // Step 2: Get onboarding URL
                await ref.read(paymentMethodNotifierProvider.notifier).getOnboardingUrl();
                final updatedState = ref.read(paymentMethodNotifierProvider);
                if (updatedState.onboardingUrl != null) {
                  // Step 3: Navigate to WebViewScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StripeWebViewScreen(url:  updatedState.onboardingUrl!),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(updatedState.errorMessageOnboardingUrl ?? 'Failed to get onboarding URL'),
                    ),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            },
            child: const Text('Add Account'),
          ),
        ],
      );
    }
  }
}