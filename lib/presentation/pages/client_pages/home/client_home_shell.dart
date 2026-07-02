import 'package:flutter/material.dart';
import 'package:nimora_worker/presentation/pages/client_pages/home/client_app_bottom_nav_bar.dart';
import 'package:nimora_worker/presentation/pages/client_pages/home/client_home_page.dart';
import 'package:nimora_worker/presentation/widgets/components/coming_soon_widget.dart';

class ClientHomeShellPage extends StatefulWidget {
  const ClientHomeShellPage({super.key});

  @override
  State<ClientHomeShellPage> createState() => _ClientHomeShellPageState();
}

class _ClientHomeShellPageState extends State<ClientHomeShellPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    ClientHomePage(),
    ComingSoonWidget(), // My Jobs
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
          //ToDo
          // setState(() {
          //   _currentIndex = index;
          // });
        },
        onAddTap: () {
          //ToDo
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text('Create Job Coming Soon'),
          //   ),
          // );
        },
      ),
    );
  }
}