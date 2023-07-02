import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pockets_app/common/injector_config.dart';
import 'package:pockets_app/presentation/bloc/pocket_list_bloc.dart';
import 'package:pockets_app/presentation/pocket_list_screen.dart';
import 'package:realm/realm.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/pocket_list': (context) {
    final argument = ModalRoute.of(context)?.settings.arguments as Realm;
    return BlocProvider<PocketListBloc>(
      create: (context) => Injector.resolve!<PocketListBloc>(),
      child: PocketListScreen(
        pocketRealm: argument,
      ),
    );
  }
};
