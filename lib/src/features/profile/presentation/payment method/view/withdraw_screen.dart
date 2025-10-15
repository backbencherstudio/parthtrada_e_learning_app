import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_learning_app/src/features/profile/presentation/payment%20method/viewmodel/payment_method_notifier_provider.dart';

class WithdrawScreen extends ConsumerStatefulWidget {
  const WithdrawScreen({super.key});

  @override
  _WithdrawScreenState createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends ConsumerState<WithdrawScreen> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch balance when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(paymentMethodNotifierProvider.notifier).checkBalance();
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _showSuccessDialog(double amount) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.6), // Softer overlay
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle_rounded,
                  color: Color(0xFF26A69A), size: 64), // Accent color
              const SizedBox(height: 16),
              Text(
                "Withdraw Successful",
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFE0E0E0),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "You’ve successfully withdrawn \$${amount.toStringAsFixed(2)}",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: const Color(0xFFB0B0B0),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  // Expanded(
                  //   child: TextButton(
                  //     onPressed: () => Navigator.pop(context),
                  //     child: Text(
                  //       "View Details",
                  //       style: GoogleFonts.inter(
                  //         fontSize: 16,
                  //         color: const Color(0xFF26A69A),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // close dialog
                        Navigator.pop(context); // go back to payout screen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF26A69A), // Accent color
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        "Done",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: const Color(0xFFE0E0E0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onConfirmWithdraw() {
    final paymentState = ref.read(paymentMethodNotifierProvider);
    final amountText = _amountController.text.trim();

    if (amountText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please enter withdraw amount",
            style: GoogleFonts.inter(color: const Color(0xFFE0E0E0)),
          ),
          backgroundColor: const Color(0xFFCF6679),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Invalid amount entered",
            style: GoogleFonts.inter(color: const Color(0xFFE0E0E0)),
          ),
          backgroundColor: const Color(0xFFCF6679),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    final currentBalance = paymentState.balance?.data?.amount?.toDouble() ?? 0;
    if (amount > currentBalance) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Insufficient balance",
            style: GoogleFonts.inter(color: const Color(0xFFE0E0E0)),
          ),
          backgroundColor: const Color(0xFFCF6679),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    // Initiate payout
    ref.read(paymentMethodNotifierProvider.notifier).payoutBalance(double.tryParse(amountText)?? 0).then((_) {
      final updatedState = ref.read(paymentMethodNotifierProvider);
      if (updatedState.payoutResponse?.success == true) {
        _showSuccessDialog(amount);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              updatedState.errorMessagePayoutBalance ?? "Failed to initiate payout",
              style: GoogleFonts.inter(color: const Color(0xFFE0E0E0)),
            ),
            backgroundColor: const Color(0xFFCF6679),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error: $e",
            style: GoogleFonts.inter(color: const Color(0xFFE0E0E0)),
          ),
          backgroundColor: const Color(0xFFCF6679),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final paymentState = ref.watch(paymentMethodNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(
          "Withdraw",
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFE0E0E0),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E1E1E), Color(0xFF2C2C2C)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E1E1E), Color(0xFF2C2C2C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Available Balance",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xFFB0B0B0),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  paymentState.isLoadingCheckBalance
                      ? const CircularProgressIndicator(
                    color: Color(0xFF26A69A),
                  )
                      : Text(
                    paymentState.balance != null
                        ? "\$${paymentState.balance!.data!.amount!.toDouble().toStringAsFixed(2)}"
                        : "Balance: Not loaded",
                    style: GoogleFonts.inter(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFE0E0E0),
                    ),
                  ),
                  if (paymentState.errorMessageCheckBalance != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        paymentState.errorMessageCheckBalance!,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: const Color(0xFFCF6679),
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    "You can withdraw up to your available balance.",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: const Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Divider
            Divider(
              color: const Color(0xFF333333),
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),

            const SizedBox(height: 32),

            // Withdraw Form
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Withdraw Amount",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFE0E0E0),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _amountController,
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    style: GoogleFonts.inter(
                      color: const Color(0xFFE0E0E0),
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: "e.g. 50.00",
                      hintStyle: GoogleFonts.inter(
                        color: const Color(0xFF999999),
                        fontSize: 16,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        child: Text(
                          "\$",
                          style: GoogleFonts.inter(
                            color: const Color(0xFFB0B0B0),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      prefixIconConstraints:
                      const BoxConstraints(minWidth: 0, minHeight: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                        const BorderSide(color: Color(0xFF26A69A), width: 2),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF2C2C2C),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: paymentState.isLoadingPayoutBalance
                          ? null
                          : _onConfirmWithdraw,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF26A69A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        shadowColor: const Color(0xFF26A69A).withOpacity(0.4),
                      ),
                      child: paymentState.isLoadingPayoutBalance
                          ? const CircularProgressIndicator(
                        color: Color(0xFFE0E0E0),
                      )
                          : Text(
                        "Confirm Withdraw",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFE0E0E0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}