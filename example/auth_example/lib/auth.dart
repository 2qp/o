import 'package:firebase_auth/firebase_auth.dart';
import 'package:o/o.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static late final String _key;

  factory AuthService.initialize({required String keyname}) {
    assert(keyname.isNotEmpty, 'keyname must not be null');
    _key = keyname;

    // Prevent multiple instances with different keynames
    assert(_key == keyname,
        'Cannot instantiate more than once with different keyname');

    return _instance;
  }

  AuthService._internal() {
    final (_, _, setUser) = useStore(_key, UserRuntime());

    _auth.authStateChanges().listen((User? user) async {
      setUser((value) => UserRuntime(user: user));

      if (user != null) {
        await user.getIdToken().then((String token) async {
          // Set secure storage

          setUser(
              (value) => UserRuntime(user: value.user, authenticated: true));
        });
      } else {
        setUser((value) => UserRuntime(user: null, authenticated: false));
      }
    });
  }

  static Future<void> authenticate(String email, String password) async {
    await _instance._auth
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> unAuthenticate() async {
    await _instance._auth.signOut();
  }
}

class UserRuntime {
  final User? user;
  final bool authenticated;
  final bool ran;

  UserRuntime({this.user, this.authenticated = false, this.ran = false});
}
