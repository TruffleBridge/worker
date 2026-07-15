import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/client_bloc/client_profile/client_profile_bloc.dart';
import '../../../../../bloc/client_bloc/client_profile/client_profile_event.dart';
import '../../../../../bloc/client_bloc/client_profile/client_profile_state.dart';
import 'card_added_successfully.dart';

class AddToPayment extends StatefulWidget {
  const AddToPayment({super.key});

  @override
  State<AddToPayment> createState() => _AddToPaymentState();
}

class _AddToPaymentState extends State<AddToPayment> {
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardHolderController = TextEditingController();

  static const Color primaryColor = Color(0xff0C8A7B);

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _cardHolderController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration({
    required String hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xffA5B0C5)),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xffF7F8FA),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xffE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xffE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: primaryColor,
          width: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 70,
        leading: Center(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xffF1F3F5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        title: const Text(
          "Add Payment Method",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Material(
              color: Colors.white,
              elevation: 2,
              borderRadius: BorderRadius.circular(18),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Card Number",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _cardNumberController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration(
                        hint: "0000 0000 0000 0000",
                        suffixIcon: const Icon(Icons.credit_card),
                      ),
                    ),
                    const SizedBox(height: 18),

                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Expiry Date",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "CVV",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _expiryController,
                            keyboardType: TextInputType.datetime,
                            decoration:
                            _inputDecoration(hint: "MM/YY"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _cvvController,
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            decoration: _inputDecoration(
                              hint: "123",
                              suffixIcon: const Icon(
                                Icons.help_outline,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      "Cardholder Name",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: _cardHolderController,
                      decoration: _inputDecoration(
                        hint: "Full Name on Card",
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  final number = _cardNumberController.text.replaceAll(' ', '');

                  if (number.length < 4) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter a valid card number"),
                      ),
                    );
                    return;
                  }
                  context.read<ProfileBloc>().add(
                    AddPaymentCardEvent(
                      PaymentCardModel(
                        cardName: "Visa ending ${number.substring(number.length - 4)}",
                        expiry: "Expires ${_expiryController.text}",
                      ),
                    ),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<ProfileBloc>(),
                        child: const CardAddedSuccessScreen(),
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Save Card",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              "We use 256-bit SSL encryption to protect your data.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff7A869A),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}