# o
O is a simple state management util to manage AppState and LocalState.

- Based on Streams
- Easy LocalState management
- Globals for AppState

## Features

- StreamBuilder based helper widgets
- Previous state
- Hooks for easy usage

#### Local State

```dart
final count = useState(50); // define

count.set(23); // [ASYNC SUPPORTED]
```

```dart
final balls = useState(50);

balls.update((prev) => prev + 100) // [ASYNC SUPPORTED]
```

###### Usage

```dart
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(home: Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final balls = useState(50);

  @override
  void dispose() {
    balls.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            Observer(
                observable: balls.o,
                builder: (context, value) => Text('Balls : $value')),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              IconButton(
                  onPressed: () => balls.set(100),
                  icon: const Icon(CupertinoIcons.add)),
              IconButton(
                  onPressed: handleBalls,
                  icon: const Icon(CupertinoIcons.infinite)),
              IconButton(
                  onPressed: () => print('do something w : ${balls.get()}'),
                  icon: const Icon(CupertinoIcons.doc))
            ])
          ])));

  void handleBalls() => balls.update((prev) => prev + 100);
  
  // void handleBalls() async {
  //   await balls.update((prev) => prev + 100);  // await for Instant Updates
  //   print('do something w : ${balls.get()}');
  // }
}
```

#### App State

```dart
// [counter_store.dart]

final $global = createStore<int, CounterActions>(1, _counterReducer);

sealed class CounterActions {
  const CounterActions();
}

class IncrementAction extends CounterActions {
  final int amount;
  const IncrementAction(this.amount);
}

class GetCounterAction extends CounterActions {
  const GetCounterAction();
}

// [ASYNC T SUPPORTED]
int _counterReducer(int state, CounterActions action) => switch (action) {
      IncrementAction(amount: final amount) => (state + amount),
      GetCounterAction() => state
    };
```

```dart
// [basic usage]
$global.dispatch(const IncrementAction(1));

___or___

final updated = await $global.dispatch(const IncrementAction(1));
```

###### Usage

```dart

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void dispose() {
    $global.dispose(); // Dispose through highest widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const MaterialApp(home: Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            Observer(
                observable: $global.o,
                builder: (context, value) => Text('App State : $value')),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              IconButton(
                  onPressed: handleClick, icon: const Icon(CupertinoIcons.add)),
              IconButton(
                  onPressed: doSomething, icon: const Icon(CupertinoIcons.doc))
            ])
          ])));

  void handleClick() async => $global.dispatch(const IncrementAction(1));

  void doSomething() async {
    final counter = await $global.dispatch(const GetCounterAction());

    print('do something w : $counter');
  }
}
```

```sh
:)
```

_Special thanks to [@theniceboy](https://github.com/theniceboy)_ | [gist](https://gist.github.com/theniceboy/fa1546517f1b18faf3186a31c8f452c6)

## License

MIT

**Free Software, Hell Yeah!**