import 'package:auth_example/auth.dart';
import 'package:auth_example/dialog.dart';
import 'package:auth_example/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:o/o.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return dependencies([
      //useStore<int>('counter', 25),
    ],
        app: globalServices(
            objects: [AuthService(keyname: 'auth')],
            app: const MaterialApp(
              home: AuthView(),
            )));
  }
}

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final (auth, setAuth) = useStore<UserRuntime>('auth', UserRuntime());

    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Observer(
            observable: auth,
            builder: (p0, p1, p2, p3) => Column(
              children: [
                Text('Authenticated ${p2.authenticated.toString()}'),
                Text('is Ran : ${p2.ran.toString()}'),
                Text('User : ${p2.user?.email.toString()}'),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  tooltip: 'signin',
                  onPressed: () => _showEmailPasswordDialog(context))),
          Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                  tooltip: 'signout',
                  onPressed: () async => await AuthService.unAuthenticate())),
        ],
      ),
    ));
  }

  void _showEmailPasswordDialog(BuildContext context) async {
    Map<String, String> result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const EmailPasswordDialog();
      },
    );

    if (result.isNotEmpty) {
      String? email = result['email'];
      String? password = result['password'];

      await AuthService.authenticate(email!, password!);
    }
  }
}
