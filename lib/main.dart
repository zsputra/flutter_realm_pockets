import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pockets_app/common/injector_config.dart';
import 'package:pockets_app/common/routes.dart';
import 'package:pockets_app/presentation/login/bloc/login_bloc.dart';
import 'package:realm/realm.dart';

Future<void> main() async {
  Injector.setup();
  const appId = 'pocket-list-dzyks';
  final App app = App(AppConfiguration(appId));

  //Open Realm Sync
  // final realm = Realm(Configuration.flexibleSync(user, [PocketItem.schema]));
  // realm.subscriptions.update((mutableSubscription) {
  //   mutableSubscription.add(realm.all<PocketItem>());
  // });
  // realm.subscriptions.waitForSynchronization();
  runApp(MyApp(app: app));
}

class MyApp extends StatelessWidget {
  final App app;
  const MyApp({super.key, required this.app});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        app: app,
      ),
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final App app;
  const MyHomePage({super.key, required this.title, required this.app});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    loginBloc = Injector.resolve!<LoginBloc>();
  }

  void _onPress() {
    loginBloc.add(StartLogin(widget.app));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Realm Pocket List Applications',
              ),
            ],
          ),
        ),
        floatingActionButton: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSucceed) {
              Navigator.pushNamed(context, '/pocket_list' ,arguments: state.realm);
            }
          },
          child: FloatingActionButton(
            onPressed: _onPress,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
