import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o/o.dart';

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
    $global.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final local = useState(0);

  @override
  void dispose() {
    local.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Observer(
              observable: local.o,
              builder: (context, value) => Text('Local State : $value.'),
            ),
            Observer(
              observable: $global.o,
              builder: (context, value) => Text('App State : ${value.value}'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: handleClick,
                  icon: const Icon(CupertinoIcons.add),
                ),
                IconButton(
                  onPressed: doSomething,
                  icon: const Icon(CupertinoIcons.doc),
                ),
                IconButton(
                  onPressed: () => Navigator.pushReplacement<void, void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const SecondScreen(),
                    ),
                  ),
                  icon: const Icon(CupertinoIcons.forward),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void handleClick() async {
    local.update((prev) async => ++prev);
    $global.dispatch(const IncrementAction(1));
  }

  void doSomething() async {
    final counter = await $global.dispatch(const LazyCounterAction());
    // ignore: avoid_print
    print('do something w ${local.get()} : | ${counter.value}');
  }
}

// [second_screen.dart]

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Observer(
                observable: $global.o,
                builder: (context, value) => Text(value.value.toString()),
              ),
              IconButton(
                onPressed: () => Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const Home(),
                  ),
                ),
                icon: const Icon(CupertinoIcons.back),
              ),
              IconButton(
                onPressed: doSomething,
                icon: const Icon(CupertinoIcons.doc),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void doSomething() async {
    final counter = await $global.dispatch(const GetCounterAction());
    // ignore: avoid_print
    print('do something w ${counter.value}');
  }
}

// [counter_store.dart]

final $global = createStore<CounterState, CounterActions>(
    const CounterState(1), _counterReducer);

// [ACTIONS]
sealed class CounterActions {
  const CounterActions();
}

class IncrementAction extends CounterActions {
  final int amount;
  const IncrementAction(this.amount);
}

class LazyCounterAction extends CounterActions {
  const LazyCounterAction();
}

class GetCounterAction extends CounterActions {
  const GetCounterAction();
}

// [STATE OBJ]
@immutable
class CounterState {
  final int value;
  const CounterState(this.value);
}

Future<CounterState> _counterReducer(
        CounterState state, CounterActions action) async =>
    switch (action) {
      IncrementAction(amount: final amount) =>
        CounterState(state.value + amount),
      GetCounterAction() => state,
      LazyCounterAction() => await Future.delayed(
          const Duration(seconds: 3), () => CounterState(state.value + 10)),
    };
