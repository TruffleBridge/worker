import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/presentation/widgets/client_widgets/client_profile/client_profile_widget.dart';

import '../../../../bloc/client_bloc/client_profile/client_profile_bloc.dart';
import '../../../../bloc/client_bloc/client_profile/client_profile_event.dart';

class ClientProfileView extends StatelessWidget {
  const ClientProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc()..add(LoadProfileEvent()),
      child: const ClientProfileWidget(),
    );
  }
}
