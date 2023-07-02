import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pockets_app/schema/pocket_item.dart';
import 'package:realm/realm.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  static String email = 'test@gmail.com';
  static String password = 'test12345';
  LoginBloc() : super(LoginInitial()) {
    on<StartLogin>((event, emit) async {
      EmailPasswordAuthProvider authProvider =
          EmailPasswordAuthProvider(event.app);
          try{
      await authProvider.registerUser(email, password);
          } catch(e){
            // ignore: avoid_print
            print('error');
          }
      User loggedInUser = event.app.currentUser ??
          await event.app.logIn(Credentials.emailPassword(email, password));

      //Open Realm Sync
      final realm =
          Realm(Configuration.flexibleSync(loggedInUser, _schemaObjects));
      realm.subscriptions.update((mutableSubscriptions) {
        mutableSubscriptions.add(realm.all<PocketItem>());
      });
      await realm.subscriptions.waitForSynchronization();

      emit(LoginSucceed(realm: realm));
    });
  }

  List<SchemaObject> get _schemaObjects => [PocketItem.schema];
}
