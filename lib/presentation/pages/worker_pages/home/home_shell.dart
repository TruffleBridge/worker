import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/bloc/worker_bloc/bookings/bookings_bloc.dart';
import 'package:nimora_worker/bloc/worker_bloc/jobs/jobs_bloc.dart';
import 'package:nimora_worker/bloc/worker_bloc/messages/messages_bloc.dart';
import 'package:nimora_worker/core/utils/app_dependencies.dart';
import 'package:nimora_worker/data/api/jobs/jobs_api_impl.dart';
import 'package:nimora_worker/data/source_data/bookings_data_source.dart';
import 'package:nimora_worker/data/source_data/messages_source_data.dart';
import 'package:nimora_worker/domain/repositories/jobs/jobs_repository_impl.dart';
import 'package:nimora_worker/presentation/pages/worker_pages/bookings/bookings_page.dart';
import 'package:nimora_worker/presentation/pages/worker_pages/home/app_bottom_nav_bar.dart';
import 'package:nimora_worker/presentation/pages/worker_pages/jobs/jobs_page.dart';
import 'package:nimora_worker/presentation/pages/worker_pages/messages/messages_page.dart';
import 'package:nimora_worker/presentation/pages/worker_pages/more/more_page.dart';
import 'package:nimora_worker/presentation/pages/worker_pages/profile_page/ProfilePage.dart';

class HomeShellPage extends StatefulWidget {
  const HomeShellPage({super.key});

  @override
  State<HomeShellPage> createState() => _HomeShellPageState();
}

class _HomeShellPageState extends State<HomeShellPage> {
  int _currentIndex = 0;

  late final JobsBloc _jobsBloc;
  late final MessagesBloc _messagesBloc;

  late final BookingsBloc _bookingsBloc;
  // late final MessagesBloc _messagesBloc;

  final List<Widget> _pages = const [
    JobsPage(),
    BookingsPage(),
    MessagesPage(),
    ProfilePage(),
    MorePage(),
  ];

  @override
  void initState() {
    super.initState();
    _jobsBloc = JobsBloc(
      jobsRepository: JobsRepositoryImpl(
        jobsApi: JobsApiImpl(dio: AppDependencies.dio),
      ),
    )..add(const JobsOnLoadedEvent());

    _bookingsBloc = BookingsBloc(dataSource: BookingsDataSourceImpl())
      ..add(const BookingsLoaded());

    _messagesBloc = MessagesBloc(
      dataSource: MessagesDataSourceImpl(),
    )..add(const MessagesLoaded());
  }

  @override
  void dispose() {
    _jobsBloc.close();
    _bookingsBloc.close();
    _messagesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _jobsBloc),
        BlocProvider.value(value: _bookingsBloc),
        BlocProvider.value(value: _messagesBloc),
      ],
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: _pages),
        bottomNavigationBar: AppBottomNav(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
