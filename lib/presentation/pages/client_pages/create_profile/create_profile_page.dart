import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/bloc/client_bloc/create_profile/create_profile_bloc.dart';
import 'package:nimora_worker/core/utils/app_dependencies.dart';
import 'package:nimora_worker/data/api/create_profile/create_profile_api_impl.dart';
import 'package:nimora_worker/domain/repositories/create_profile/create_profile_repository_impl.dart';
import 'package:nimora_worker/presentation/views/client_views/create_profile/create_profile_view.dart';

class CreateProfilePage extends StatelessWidget {
  const CreateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateProfileBloc(
        createProfileRepository: CreateProfileRepositoryImpl(
          createProfileApi: CreateProfileApiImpl(
            dio: AppDependencies.dio,
          ),
        ),
      ),
      child: const CreateProfileView(),
    );
  }
}