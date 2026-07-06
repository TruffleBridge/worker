import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nimora_worker/presentation/pages/client_pages/home/client_app_bottom_nav_bar.dart';
import 'package:nimora_worker/presentation/pages/client_pages/home/client_home_page.dart';
import 'package:nimora_worker/presentation/pages/job_lsiting/job_listing_page.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/job_post/job_post_widget.dart';
import 'package:nimora_worker/presentation/widgets/components/coming_soon_widget.dart';

import '../../../../routes/app_router.dart';
import '../job_post/job_post_page.dart';

class ClientHomeShellPage extends StatefulWidget {
  const ClientHomeShellPage({super.key});

  @override
  State<ClientHomeShellPage> createState() => _ClientHomeShellPageState();
}

class _ClientHomeShellPageState extends State<ClientHomeShellPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    ClientHomePage(),
    JobListingPage(), // My Jobs
    ComingSoonWidget(), // Messages
    ComingSoonWidget(), // Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: ClientAppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        onAddTap: () {
          context.go(AppRoutes.clientJobPost);
        },
      ),
    );
  }
}