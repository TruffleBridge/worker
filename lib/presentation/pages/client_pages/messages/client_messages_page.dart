import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimora_worker/bloc/client_bloc/messages/client_messages_event.dart';
import 'package:nimora_worker/data/source_data/messages_source_data.dart';

import '../../../../bloc/client_bloc/messages/client_messages_bloc.dart';
import '../../../views/client_views/messages/client_messages_view.dart';

class ClientMessagesPage extends StatelessWidget {
  const ClientMessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ClientMessagesBloc(dataSource: MessagesDataSourceImpl()
      )..add(const ClientMessagesLoaded()),
      child: const ClientMessagesView(),
    );
  }
}
