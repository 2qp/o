import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o/o.dart';
import 'package:persisted/persisted_counter_slice.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void dispose() {
    $persisted.dispose();
    super.dispose();
  }

  @override
  void initState() {
    $persisted.dispatch(const SyncIncrement());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Listener()),
    );
  }
}

class Listener extends StatelessWidget {
  const Listener({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Observer(
            observable: $persisted.o,
            builder: (context, value) => Text('Persisted State : $value'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: handleClick,
                child: const Icon(CupertinoIcons.add),
              ),
              FloatingActionButton(
                onPressed: doSomething,
                child: const Icon(CupertinoIcons.doc),
              ),
            ],
          )
        ],
      ),
    );
  }

  void handleClick() => $persisted.dispatch(const PersistedIncrementAction(1));

  void doSomething() async {
    final persisted = await $persisted.dispatch(const GetIncrementAction());
    // ignore: avoid_print
    print('do something w $persisted');
  }
}
