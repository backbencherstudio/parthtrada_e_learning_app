import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../repository/api/expert/get_card_repository.dart';
import '../../../../book_expert/model/get_card_data_model.dart';
import '../data/models/account_status_response.dart';
import '../data/models/balance_response.dart';
import '../data/models/payout_response.dart';
import '../data/repository/payment_method_repository_impl.dart';

class PaymentMethodState {
  final bool isLoading;
  final String? message;

  final CardsResponse? cardsResponse;
  final bool isSuccessGetPaymentMethod;

  final bool isLoadingGetPaymentMethod;
  final String? errorMessageGetPaymentMethod;

  final bool isLoadingCreateAccount;
  final bool? isSuccessCreateAccount;
  final String? errorMessageCreateAccount;

  final bool isLoadingOnboardingUrl;
  final String? onboardingUrl;
  final String? errorMessageOnboardingUrl;

  final bool isLoadingAccountStatus;
  final AccountStatusResponse? accountStatus;
  final String? errorMessageAccountStatus;

  final bool isLoadingCheckBalance;
  final BalanceResponse? balance;
  final String? errorMessageCheckBalance;

  final bool isLoadingPayoutBalance;
  final PayoutResponse? payoutResponse;
  final String? errorMessagePayoutBalance;

  const PaymentMethodState({
    this.isLoading = false,
    this.message,
    this.isLoadingGetPaymentMethod = false,
    this.errorMessageGetPaymentMethod,
    this.cardsResponse,
    this.isSuccessGetPaymentMethod = false,
    this.isLoadingCreateAccount = false,
    this.isSuccessCreateAccount,
    this.errorMessageCreateAccount,
    this.isLoadingOnboardingUrl = false,
    this.onboardingUrl,
    this.errorMessageOnboardingUrl,
    this.isLoadingAccountStatus = false,
    this.accountStatus,
    this.errorMessageAccountStatus,
    this.isLoadingCheckBalance = false,
    this.balance,
    this.errorMessageCheckBalance,
    this.isLoadingPayoutBalance = false,
    this.payoutResponse,
    this.errorMessagePayoutBalance,
  });

  PaymentMethodState copyWith({
    bool? isLoading,
    String? message,
    bool? isLoadingGetPaymentMethod,
    String? errorMessageGetPaymentMethod,
    CardsResponse? cardsResponse,
    bool? isSuccessGetPaymentMethod,
    bool? isLoadingCreateAccount,
    bool? isSuccessCreateAccount,
    String? errorMessageCreateAccount,
    bool? isLoadingOnboardingUrl,
    String? onboardingUrl,
    String? errorMessageOnboardingUrl,
    bool? isLoadingAccountStatus,
    AccountStatusResponse? accountStatus,
    String? errorMessageAccountStatus,
    bool? isLoadingCheckBalance,
    BalanceResponse? balance,
    String? errorMessageCheckBalance,
    bool? isLoadingPayoutBalance,
    PayoutResponse? payoutResponse,
    String? errorMessagePayoutBalance,
  }) {
    return PaymentMethodState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      isLoadingGetPaymentMethod:
      isLoadingGetPaymentMethod ?? this.isLoadingGetPaymentMethod,
      errorMessageGetPaymentMethod:
      errorMessageGetPaymentMethod ?? this.errorMessageGetPaymentMethod,
      cardsResponse: cardsResponse ?? this.cardsResponse,
      isSuccessGetPaymentMethod:
      isSuccessGetPaymentMethod ?? this.isSuccessGetPaymentMethod,
      isLoadingCreateAccount:
      isLoadingCreateAccount ?? this.isLoadingCreateAccount,
      isSuccessCreateAccount:
      isSuccessCreateAccount ?? this.isSuccessCreateAccount,
      errorMessageCreateAccount:
      errorMessageCreateAccount ?? this.errorMessageCreateAccount,
      isLoadingOnboardingUrl:
      isLoadingOnboardingUrl ?? this.isLoadingOnboardingUrl,
      onboardingUrl: onboardingUrl ?? this.onboardingUrl,
      errorMessageOnboardingUrl:
      errorMessageOnboardingUrl ?? this.errorMessageOnboardingUrl,
      isLoadingAccountStatus:
      isLoadingAccountStatus ?? this.isLoadingAccountStatus,
      accountStatus: accountStatus ?? this.accountStatus,
      errorMessageAccountStatus:
      errorMessageAccountStatus ?? this.errorMessageAccountStatus,
      isLoadingCheckBalance: isLoadingCheckBalance ?? this.isLoadingCheckBalance,
      balance: balance ?? this.balance,
      errorMessageCheckBalance:
      errorMessageCheckBalance ?? this.errorMessageCheckBalance,
      isLoadingPayoutBalance:
      isLoadingPayoutBalance ?? this.isLoadingPayoutBalance,
      payoutResponse: payoutResponse ?? this.payoutResponse,
      errorMessagePayoutBalance:
      errorMessagePayoutBalance ?? this.errorMessagePayoutBalance,
    );
  }
}

class PaymentMethodNotifier extends StateNotifier<PaymentMethodState> {
  final PaymentMethodRepositoryImpl _repository = PaymentMethodRepositoryImpl();
  final GetCardRepository _getCardRepository = GetCardRepository();

  PaymentMethodNotifier() : super(const PaymentMethodState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    await getAccountStatus();
    await checkBalance();
  }

  Future<void> addNewCard({
    required String cardNumber,
    required String expMonth,
    required String expYear,
    required String cvc,
  }) async {
    try {
      state = state.copyWith(isLoading: true, message: null);

      // Step 1: Call Stripe API -> get token id
      final tokenId = await _repository.addPaymentMethod(
        cardNumber,
        expMonth,
        expYear,
        cvc,
      );

      if (tokenId.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          message: "Failed to create payment token",
        );
        return;
      }

      // Step 2: Call backend API -> add card with token
      final success = await _repository.addCard(tokenId);
      getCards();

      state = state.copyWith(
        isLoading: false,
        message: success ? "Card added successfully" : "Failed to add card",
      );
    } catch (e) {
      debugPrint("Error in addNewCard: $e");
      state = state.copyWith(isLoading: false, message: "Error: $e");
    }
  }

  Future<void> getCards() async {
    try {
      state = state.copyWith(
        isLoadingGetPaymentMethod: true,
        errorMessageGetPaymentMethod: null,
        isSuccessGetPaymentMethod: false,
      );

      final cardsResponse = await _getCardRepository.getCards();

      if (cardsResponse != null) {
        state = state.copyWith(
          isLoadingGetPaymentMethod: false,
          cardsResponse: cardsResponse,
          isSuccessGetPaymentMethod: true,
          errorMessageGetPaymentMethod: null,
        );
      } else {
        state = state.copyWith(
          isLoadingGetPaymentMethod: false,
          isSuccessGetPaymentMethod: false,
          errorMessageGetPaymentMethod: "No cards found or invalid token",
        );
      }
    } catch (e) {
      debugPrint("Error in getCards: $e");
      state = state.copyWith(
        isLoadingGetPaymentMethod: false,
        isSuccessGetPaymentMethod: false,
        errorMessageGetPaymentMethod: "Error fetching cards: $e",
      );
    }
  }

  Future<void> createAccount() async {
    try {
      state = state.copyWith(
        isLoadingCreateAccount: true,
        isSuccessCreateAccount: null,
        errorMessageCreateAccount: null,
      );

      final success = await _repository.createAccount();

      state = state.copyWith(
        isLoadingCreateAccount: false,
        isSuccessCreateAccount: success,
        errorMessageCreateAccount: success ? null : "Failed to create account",
      );
    } catch (e, stackTrace) {
      debugPrint("Error in createAccount: $e\nStackTrace: $stackTrace");
      state = state.copyWith(
        isLoadingCreateAccount: false,
        isSuccessCreateAccount: false,
        errorMessageCreateAccount: "Error creating account: $e",
      );
    }
  }

  Future<void> getOnboardingUrl() async {
    try {
      state = state.copyWith(
        isLoadingOnboardingUrl: true,
        onboardingUrl: null,
        errorMessageOnboardingUrl: null,
      );

      final url = await _repository.getOnbordingUrl();

      state = state.copyWith(
        isLoadingOnboardingUrl: false,
        onboardingUrl: url,
        errorMessageOnboardingUrl: null,
      );
    } catch (e, stackTrace) {
      debugPrint("Error in getOnboardingUrl: $e\nStackTrace: $stackTrace");
      state = state.copyWith(
        isLoadingOnboardingUrl: false,
        onboardingUrl: null,
        errorMessageOnboardingUrl: "Error fetching onboarding URL: $e",
      );
    }
  }

  Future<void> getAccountStatus() async {
    try {
      state = state.copyWith(
        isLoadingAccountStatus: true,
        accountStatus: null,
        errorMessageAccountStatus: null,
      );

      final accountStatus = await _repository.getAccountStatus();

      state = state.copyWith(
        isLoadingAccountStatus: false,
        accountStatus: accountStatus,
        errorMessageAccountStatus: null,
      );
    } catch (e, stackTrace) {
      debugPrint("Error in getAccountStatus: $e\nStackTrace: $stackTrace");
      state = state.copyWith(
        isLoadingAccountStatus: false,
        accountStatus: null,
        errorMessageAccountStatus: "Error fetching account status: $e",
      );
    }
  }

  Future<void> checkBalance() async {
    try {
      state = state.copyWith(
        isLoadingCheckBalance: true,
        balance: null,
        errorMessageCheckBalance: null,
      );

      final balance = await _repository.checkBalance();

      state = state.copyWith(
        isLoadingCheckBalance: false,
        balance: balance,
        errorMessageCheckBalance: null,
      );
    } catch (e, stackTrace) {
      debugPrint("Error in checkBalance: $e\nStackTrace: $stackTrace");
      state = state.copyWith(
        isLoadingCheckBalance: false,
        balance: null,
        errorMessageCheckBalance: "Error fetching balance: $e",
      );
    }
  }

  Future<void> payoutBalance(double amount) async {
    try {
      state = state.copyWith(
        isLoadingPayoutBalance: true,
        payoutResponse: null,
        errorMessagePayoutBalance: null,
      );

      final payoutResponse = await _repository.payoutBalance(amount);

      state = state.copyWith(
        isLoadingPayoutBalance: false,
        payoutResponse: payoutResponse,
        errorMessagePayoutBalance: payoutResponse.success == true ? null : "Failed to initiate payout",
      );
    } catch (e, stackTrace) {
      debugPrint("Error in payoutBalance: $e\nStackTrace: $stackTrace");
      state = state.copyWith(
        isLoadingPayoutBalance: false,
        payoutResponse: null,
        errorMessagePayoutBalance: "Error initiating payout: $e",
      );
    }
  }
}

final paymentMethodNotifierProvider =
StateNotifierProvider<PaymentMethodNotifier, PaymentMethodState>(
      (ref) => PaymentMethodNotifier(),
);







// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../../../repository/api/expert/get_card_repository.dart';
// import '../../../../book_expert/model/get_card_data_model.dart';
// import '../data/repository/payment_method_repository_impl.dart';
//
// class PaymentMethodState {
//   final bool isLoading;
//   final String? message;
//
//   final CardsResponse? cardsResponse;
//   final bool isSuccessGetPaymentMethod;
//
//   final bool isLoadingGetPaymentMethod;
//   final String? errorMessageGetPaymentMethod;
//
//   const PaymentMethodState({
//     this.isLoading = false,
//     this.message,
//     this.isLoadingGetPaymentMethod = false,
//     this.errorMessageGetPaymentMethod,
//     this.cardsResponse,
//     this.isSuccessGetPaymentMethod = false,
//   });
//
//   PaymentMethodState copyWith({
//     bool? isLoading,
//     String? message,
//     bool? isLoadingGetPaymentMethod,
//     String? errorMessageGetPaymentMethod,
//     CardsResponse? cardsResponse,
//     bool? isSuccessGetPaymentMethod,
//   }) {
//     return PaymentMethodState(
//       isLoading: isLoading ?? this.isLoading,
//       message: message ?? this.message,
//       isLoadingGetPaymentMethod:
//           isLoadingGetPaymentMethod ?? this.isLoadingGetPaymentMethod,
//       errorMessageGetPaymentMethod:
//           errorMessageGetPaymentMethod ?? this.errorMessageGetPaymentMethod,
//       cardsResponse: cardsResponse ?? this.cardsResponse,
//       isSuccessGetPaymentMethod: isSuccessGetPaymentMethod ?? this.isSuccessGetPaymentMethod,
//     );
//   }
// }
//
// class PaymentMethodNotifier extends StateNotifier<PaymentMethodState> {
//   final PaymentMethodRepositoryImpl _repository = PaymentMethodRepositoryImpl();
//   final GetCardRepository _getCardRepository = GetCardRepository();
//
//   PaymentMethodNotifier() : super(const PaymentMethodState());
//
//   Future<void> addNewCard({
//     required String cardNumber,
//     required String expMonth,
//     required String expYear,
//     required String cvc,
//   }) async {
//     try {
//       state = state.copyWith(isLoading: true, message: null);
//
//       // Step 1: Call Stripe API -> get token id
//       final tokenId = await _repository.addPaymentMethod(
//         cardNumber,
//         expMonth,
//         expYear,
//         cvc,
//       );
//
//       if (tokenId.isEmpty) {
//         state = state.copyWith(
//           isLoading: false,
//           message: "Failed to create payment token",
//         );
//         return;
//       }
//
//       // Step 2: Call backend API -> add card with token
//       final success = await _repository.addCard(tokenId);
//       getCards();
//
//       state = state.copyWith(
//         isLoading: false,
//         message: success ? "Card added successfully" : "Failed to add card",
//       );
//     } catch (e) {
//       debugPrint("Error: $e");
//       state = state.copyWith(isLoading: false, message: "Error: $e");
//     }
//   }
//
//
//
//
//   Future<void> getCards() async {
//     try {
//       state = state.copyWith(
//         isLoadingGetPaymentMethod: true,
//         errorMessageGetPaymentMethod: null,
//         isSuccessGetPaymentMethod: false,
//       );
//
//       final cardsResponse = await _getCardRepository.getCards();
//
//       if (cardsResponse != null) {
//         state = state.copyWith(
//           isLoadingGetPaymentMethod: false,
//           cardsResponse: cardsResponse,
//           isSuccessGetPaymentMethod: true,
//           errorMessageGetPaymentMethod: null,
//         );
//       } else {
//         state = state.copyWith(
//           isLoadingGetPaymentMethod: false,
//           isSuccessGetPaymentMethod: false,
//           errorMessageGetPaymentMethod: "No cards found or invalid token",
//         );
//       }
//     } catch (e) {
//       state = state.copyWith(
//         isLoadingGetPaymentMethod: false,
//         isSuccessGetPaymentMethod: false,
//         errorMessageGetPaymentMethod: "Error fetching cards: $e",
//       );
//     }
//   }
//
//
//
// }
//
// final paymentMethodNotifierProvider =
//     StateNotifierProvider<PaymentMethodNotifier, PaymentMethodState>(
//       (ref) => PaymentMethodNotifier(),
//     );
