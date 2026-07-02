import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/bloc/worker_bloc/login/login_bloc.dart';
import 'package:nimora_worker/core/utils/app_dependencies.dart';
import 'package:nimora_worker/data/api/login/login_api_impl.dart';
import 'package:nimora_worker/domain/repositories/login/login_repository_impl.dart';
import 'package:nimora_worker/presentation/views/worker_views/login/login_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginApi = LoginApiImpl(
      dio: AppDependencies.dio,
      tokenStorage: AppDependencies.tokenStorage,
    );

    final loginRepository = LoginRepositoryImpl(
      loginApi: loginApi,
    );

    return BlocProvider(
      create: (_) => WorkerLoginBloc(
        loginRepository: loginRepository,
      )..add(LoginOnLoadEvent()),
      child: const LoginView(),
    );
  }
}