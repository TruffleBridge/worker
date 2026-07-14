import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nimora_worker/presentation/pages/client_pages/home/client_app_bottom_nav_bar.dart';
import 'package:nimora_worker/presentation/pages/client_pages/home/client_home_page.dart';
import 'package:nimora_worker/presentation/pages/job_lisiting/job_listing_page.dart';
import 'package:nimora_worker/presentation/pages/worker_pages/more/more_page.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/more/more_widget.dart';
import 'package:nimora_worker/presentation/widgets/components/coming_soon_widget.dart';

import '../../../../routes/app_router.dart';

class ClientHomeShellPage extends StatefulWidget {
  const ClientHomeShellPage({super.key});

  @override
  State<ClientHomeShellPage> createState() => _ClientHomeShellPageState();
}

class _ClientHomeShellPageState extends State<ClientHomeShellPage> {
  int _currentIndex = 0;

  Widget _buildPage() {
    switch (_currentIndex) {
      case 0:
        return const ClientHomePage();

      case 1:
        return const JobListingPage();

      case 2:
        return const ComingSoonWidget();

      case 3:
        return const MorePage();

      default:
        return const ClientHomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(),
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