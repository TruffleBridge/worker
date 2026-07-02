import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nimora_worker/core/constants/nimora_colors.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/MorePageAppBar.dart';
import 'package:nimora_worker/routes/app_router.dart';

class PaymentInfoPage extends StatelessWidget {
  const PaymentInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: const MorePageAppBar(title: 'Payment Info'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const BankAccountCard(),

            const SizedBox(height: 16),

            Column(
              children: [
                const Row(
                  children: [
                    Text(
                      'Bank Accounts',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: NimoraColors.titleColor,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFDBEAFE),
                      child: Image.asset('assets/images/profile_icon.png'),
                    ),
                    title: const Text('Savings Account'),
                    titleTextStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A233A),
                    ),
                    subtitle: const Text('**** 6789'),
                    subtitleTextStyle: const TextStyle(
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 10,
                      children: [
                        Image.asset('assets/images/edit_icon_bank.png'),
                        Image.asset('assets/images/delete_icon.png'),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.push(AppRoutes.addBankAccount);
                },
                icon: const Icon(Icons.add),
                label: const Text('Add New Bank Account'),
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BankAccountCard extends StatelessWidget {
  const BankAccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFFF9557)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Bank Account',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              Image.asset('assets/images/bank_icon.png'),
              const SizedBox(width: 15),
            ],
          ),

          const Spacer(),

          const Text(
            'BSB',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'XXX XXX',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'ACCOUNT NUMBER',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            'XXX XXX 789',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// class AddBankAccountPage extends StatelessWidget {
//   const AddBankAccountPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const MorePageAppBar(
//         title: 'Add Bank Account',
//         actionButton: 'assets/images/share_icon.png',
//       ),
//
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Info Card
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFFFF5F2),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 40,
//                       height: 40,
//                       decoration: const BoxDecoration(
//                         color: Color(0xFFFFE7DD),
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(
//                         Icons.account_balance,
//                         color: Color(0xFFFF6B35),
//                         size: 20,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     const Expanded(
//                       child: Text(
//                         'Provide your bank information to receive payments directly.',
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Color(0xFF475467),
//                           height: 1.4,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               const Text(
//                 'Account Holder Name',
//                 style: TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,
//                   color: Color(0xFF344054),
//                 ),
//               ),
//
//               TextFormField(
//                 decoration: const InputDecoration(
//                   hintText: 'e.g. John D. Smith',
//                   border: UnderlineInputBorder(),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'BSB',
//                           style: TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             hintText: '000',
//                             border: UnderlineInputBorder(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(width: 16),
//
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Branch',
//                           style: TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         TextFormField(
//                           decoration: const InputDecoration(
//                             hintText: '000',
//                             border: UnderlineInputBorder(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 20),
//
//               const Text(
//                 'Account Number',
//                 style: TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//
//               TextFormField(
//                 decoration: const InputDecoration(
//                   hintText: 'Enter up to 9 digits',
//                   border: UnderlineInputBorder(),
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(14),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF7F0FA),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Icon(
//                       Icons.verified_user_outlined,
//                       size: 18,
//                       color: Color(0xFF7F56D9),
//                     ),
//                     SizedBox(width: 8),
//                     Expanded(
//                       child: Text.rich(
//                         TextSpan(
//                           children: [
//                             TextSpan(
//                               text: 'Secured & Encrypted. ',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             TextSpan(
//                               text:
//                               'Your bank details are protected using AES-256 standards.',
//                             ),
//                           ],
//                         ),
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Color(0xFF475467),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 32),
//
//               SizedBox(
//                 width: double.infinity,
//                 height: 52,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF086D63),
//                     foregroundColor: Colors.white,
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                   ),
//                   onPressed: () {
//                     context.push(AppRoutes.paymentSuccess);
//                   },
//                   child: const Text(
//                     'Save Bank Account',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
class AddBankAccountPage extends StatelessWidget {
  const AddBankAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MorePageAppBar(
        title: 'Add Bank Account',
        actionButton: 'assets/images/share_icon.png',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info Card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFCF8FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFE7DD),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.account_balance,
                        color: Color(0xFFFF6B35),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Payment Details',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: NimoraColors.titleColor,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Provide your bank information to receive NDIS reimbursements directly to your nominated account.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF364153),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Account Holder Name
              _buildLabel('Account Holder Name'),
              const SizedBox(height: 6),
              _buildTextField(hintText: 'e.g. John D. Smith'),

              const SizedBox(height: 20),

              // BSB + Branch Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('BSB Number'),
                        const SizedBox(height: 6),
                        _buildTextField(hintText: '000'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Branch'),
                        const SizedBox(height: 6),
                        _buildTextField(hintText: '000'),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Account Number
              _buildLabel('Account Number'),
              const SizedBox(height: 6),
              _buildTextField(hintText: 'Enter up to 9 digits'),

              const SizedBox(height: 24),

              // Security Badge
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE9FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.verified_user_rounded,
                      size: 18,
                      color: Color(0xFF7F56D9),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Secured & Encrypted. ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Color(0xFF7747A7),
                              ),
                            ),
                            TextSpan(
                              text:
                                  'Your bank details are encrypted using AES-256 standards and are never stored in plain text on our servers.',
                            ),
                          ],
                        ),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF594237),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 130),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF086D63),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    context.push(AppRoutes.paymentSuccess);
                  },
                  child: const Text(
                    'Save Bank Account',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xFF344054),
      ),
    );
  }

  Widget _buildTextField({required String hintText}) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFFB0B7C3),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFD0D5DD), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF086D63), width: 1.5),
        ),
      ),
    );
  }
}

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MorePageAppBar(
        title: 'Add Bank Account',
        actionButton: 'assets/images/share_icon.png',
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: Color(0xFF5ED46D),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 36),
            ),

            const SizedBox(height: 24),

            const Text(
              'Your bank account has been\nadded successfully',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.go(AppRoutes.home);
                  },
                  child: const Text('Go to Home'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
