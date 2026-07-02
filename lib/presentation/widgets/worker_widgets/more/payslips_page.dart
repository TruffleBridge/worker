import 'package:flutter/material.dart';
import 'package:nimora_worker/presentation/widgets/worker_widgets/more/MorePageAppBar.dart';

// ─────────────────────────────────────────────
// PAYSLIPS LIST PAGE
// ─────────────────────────────────────────────
class PayslipsPage extends StatelessWidget {
  const PayslipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: const MorePageAppBar(title: 'Payslips'),
      body: Column(
        children: [
          // Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFFFF6D6),
              border: Border(
                left: BorderSide(color: Color(0xFFE9A800), width: 4),
              ),
            ),
            child: const Text(
              'Payments are sent every 2 weeks on Thursdays.',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF8A6D1D),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 5,
              itemBuilder: (_, index) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: PayslipCard(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PAYSLIP CARD
// ─────────────────────────────────────────────
class PayslipCard extends StatelessWidget {
  const PayslipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: date + badge
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Apr 1 - Apr 14, 2026',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF1A1F36),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7F8EA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Paid',
                  style: TextStyle(
                    color: Color(0xFF22A559),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          // Paid on date
          const Text(
            'Paid on Apr 21, 2026',
            style: TextStyle(fontSize: 11, color: Color(0xFF9AA3B2)),
          ),

          const SizedBox(height: 16),

          // Amount row
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFFEAF8EE),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '\$',
                    style: TextStyle(
                      color: Color(0xFF22A559),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Amount',
                    style: TextStyle(color: Color(0xFF9AA3B2), fontSize: 11),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '\$2,660.00',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: Color(0xFF1A1F36),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 14),

          const Divider(height: 1, color: Color(0xFFF0F0F0)),

          const SizedBox(height: 12),

          // Bottom row: hours + view details
          Row(
            children: [
              const Icon(Icons.schedule, size: 16, color: Color(0xFF9AA3B2)),
              const SizedBox(width: 6),
              const Text(
                'Hours',
                style: TextStyle(fontSize: 12, color: Color(0xFF9AA3B2)),
              ),
              const SizedBox(width: 4),
              const Text(
                '35h',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Color(0xFF1A1F36),
                ),
              ),
              const Spacer(),
              GestureDetector(
                // onTap: () => context.push('/payslip-detail'),
                onTap: () {},
                child: const Row(
                  children: [
                    Text(
                      'View Details',
                      style: TextStyle(
                        color: Color(0xFFFF6B35),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Color(0xFFFF6B35),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PAYSLIP DETAIL PAGE
// ─────────────────────────────────────────────
class PayslipDetailPage extends StatelessWidget {
  const PayslipDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: const MorePageAppBar(title: 'Payslip Detail'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ── Pay Period Card ──
            _section(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Pay Period',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF9AA3B2),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE7F8EA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Paid',
                          style: TextStyle(
                            color: Color(0xFF22A559),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Apr 1 - Apr 14, 2026',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Color(0xFF1A1F36),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Paid on Apr 21, 2026  ·  Invoice #INV-2024-082',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9AA3B2)),
                  ),
                  const SizedBox(height: 16),

                  // Download PDF button
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.download_outlined,
                        size: 18,
                        color: Color(0xFFE05C2A),
                      ),
                      label: const Text(
                        'Download PDF',
                        style: TextStyle(
                          color: Color(0xFFE05C2A),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFFE05C2A),
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ── Worker Information ──
            _section(
              title: 'Worker Information',
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0F0F0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Color(0xFF9AA3B2),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Manoj Rajkumar',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xFF1A1F36),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'ABN 123 456 789 001',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9AA3B2),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ── Provider ──
            _section(
              title: 'Provider',
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Connect NDIS Services',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF1A1F36),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Wellness Way, Sydney NSW 2000\nABN 12 345 678 901',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9AA3B2),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ── Payment Summary ──
            _section(
              title: 'Payment Summary',
              child: Column(
                children: [
                  const _SummaryRow('Total Hours Worked', '35h'),
                  const _SummaryRow('Hourly Rate', '\$70.00/hr'),
                  const _SummaryRow('Transport  \$1/hr', '\$43'),
                  const SizedBox(height: 4),
                  const Divider(color: Color(0xFFF0F0F0)),
                  const SizedBox(height: 4),
                  const _SummaryRow('Gross Pay', '\$2450.00'),
                  const _SummaryRow('Deductions', '-\$0.00'),
                  const Divider(color: Color(0xFFF0F0F0)),
                  _SummaryRow(
                    'Net Pay',
                    '\$2450.00',
                    isBold: true,
                    valueColor: const Color(0xFF086D63),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _section({String? title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFF1A1F36),
                ),
              ),
            ),
          child,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SUMMARY ROW WIDGET
// ─────────────────────────────────────────────
class _SummaryRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isBold;
  final Color? valueColor;

  const _SummaryRow(
    this.title,
    this.value, {
    this.isBold = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
                color: isBold
                    ? const Color(0xFF1A1F36)
                    : const Color(0xFF475467),
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              fontSize: isBold ? 15 : 13,
              color:
                  valueColor ??
                  (isBold ? const Color(0xFF1A1F36) : const Color(0xFF1A1F36)),
            ),
          ),
        ],
      ),
    );
  }
}
