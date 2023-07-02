import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pockets_app/common/injector_config.dart';
import 'package:pockets_app/presentation/bloc/pocket_list_bloc.dart';
import 'package:realm/realm.dart';

class PocketListScreen extends StatefulWidget {
  final Realm pocketRealm;
  const PocketListScreen({
    super.key,
    required this.pocketRealm,
  });

  @override
  State<PocketListScreen> createState() => _PocketListScreenState();
}

class _PocketListScreenState extends State<PocketListScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late PocketListBloc _pocketListBloc;

  @override
  void initState() {
    super.initState();
    _pocketListBloc = Injector.resolve!<PocketListBloc>()
      ..add(LoadPocketListEvent(widget.pocketRealm));
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Pocket List')), body: _buildBody());
  }

  Widget _buildBody() {
    return BlocBuilder<PocketListBloc, PocketListState>(
      bloc: _pocketListBloc,
      builder: (context, state) {
        if (state is PocketListLoaded) {
          return _buildGridPockets(state);
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Padding _buildGridPockets(PocketListLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16)
          .copyWith(bottom: 50, top: 16),
      child: GridView.builder(
          itemCount: state.pockets.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 30,
            crossAxisSpacing: 30,
          ),
          itemBuilder: (context, index) {
            final item = state.pockets[index];
            return Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.amber),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.pocketName ?? 'Default',
                          style: const TextStyle(
                            fontSize: 20,
                          )),
                      Expanded(
                        child: Center(
                          child: Text(item.emoji ?? '😶',
                              style: const TextStyle(fontSize: 70)),
                        ),
                      )
                    ]),
              ),
            );
          }),
    );
  }
}
