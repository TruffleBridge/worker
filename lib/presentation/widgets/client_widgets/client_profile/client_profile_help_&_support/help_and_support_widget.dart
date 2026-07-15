import 'package:flutter/material.dart';

class HelpAndSupportWidget extends StatelessWidget {
  const HelpAndSupportWidget({super.key});

  static const Color primaryColor = Color(0xff0C8A7B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
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
          "Help & Support",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [

              /// Search
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xffE5E7EB),
                  ),
                ),
                child: const TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isCollapsed: true,
                    hintText: "Search FAQs...",
                    hintStyle: TextStyle(
                      color: Color(0xff94A3B8),
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xff94A3B8),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 50,
                      minHeight: 52,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 26),

              /// FAQ Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.06),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(18, 18, 18, 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "COMMON QUESTIONS",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff3A3A3A),
                          ),
                        ),
                      ),
                    ),

                    _faqTile("How do I find a support worker?"),
                    _divider(),
                    _faqTile("What is NDIS?"),
                    _divider(),
                    _faqTile("How do payments work?"),
                    _divider(),
                    _faqTile("How to upload documents?"),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              /// Contact Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.06),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [

                    const Padding(
                      padding: EdgeInsets.fromLTRB(18, 18, 18, 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "CONTACT US",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff3A3A3A),
                          ),
                        ),
                      ),
                    ),

                    _contactTile(
                      icon: Icons.chat_bubble_outline,
                      title: "Live Chat",
                      subtitle: "Usually replies in minutes",
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Divider(height: 1),
                    ),

                    _contactTile(
                      icon: Icons.email_outlined,
                      title: "Email Support",
                      subtitle: "support@careconnect.com.au",
                    ),
                  ],
                ),
              ),

              const Spacer(),

              const Text(
                "Nimora v1.0",
                style: TextStyle(
                  color: Color(0xff94A3B8),
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 6),

              GestureDetector(
                onTap: () {},
                child: const Text(
                  "Privacy Policy",
                  style: TextStyle(
                    color: primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _faqTile(String title) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _contactTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [

          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xffEAF7F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 22,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xff718096),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _divider() {
    return const Divider(
      height: 1,
      color: Color(0xffECECEC),
    );
  }
}