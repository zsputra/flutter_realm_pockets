import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pockets_app/schema/pocket_item.dart';
import 'package:realm/realm.dart';

part 'pocket_list_event.dart';
part 'pocket_list_state.dart';

class PocketListBloc extends Bloc<PocketListEvent, PocketListState> {
  PocketListBloc() : super(PocketListInitial()) {
    on<LoadPocketListEvent>((event, emit) async {
      await _mapLoadPocketListEventToState(event, emit);
    });
  }

  Future<void> _mapLoadPocketListEventToState(
      LoadPocketListEvent event, Emitter<PocketListState> emit) async {
    final pockets = event.pocketRealm.all<PocketItem>();
    await emit.forEach(pockets.changes, onData: (data) {
      return PocketListLoaded(data.results);
    });
  }
}
