# o
O is a simple state management util to manage AppState and LocalState.

- Based on Streams
- Easy LocalState management
- Global singleton for AppState

## Features

- StreamBuilder based helper widgets
- Previous state
- Notify state
- Hooks for easy usage
- Customizable
- Filter-out unwanted rebuilds.

#### Local State

```dart
final $count = useState(50); // define

final (countO, setCount, _) = $count; // O means Observable
setCount(23);
```

```dart
final $balls = useState(50);

final (ballsO, _, setBalls) = $balls;
setBalls((prev) => prev + 100)
```

###### Usage

```dart
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final $count = useState(50);
  final $balls = useState(50);

  @override
  Widget build(BuildContext context) {
    final (countO, setCount, _) = $count;
    final (ballsO, _, _) = $balls;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Observer(
          observable: countO,
          builder: (context, obs, value) => Text('Count : $value'),
        ),
        Observer(
          observable: ballsO,
          builder: (context, obs, value) => Text('Balls : $value'),
        ),
        OutlinedButton(
            onPressed: () => setCount(100), child: const Text('make it 100')),
        OutlinedButton(onPressed: handleBalls, child: const Text('more balls'))
      ],
    );
  }

  void handleBalls() {
    final (_, _, setBalls) = $balls;
    setBalls((prev) => prev + 100);
  }
}

```

#### App State

```dart
final $count = useStore('counter', 500);

final (countO, _, setDown) = $count;
setDown(69);
```

```dart
final $count = useStore('counter', 500);

final (countO, _, setDown) = $count;
setDown((prev) => prev - 1);
```

###### Usage

```dart

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final $count = useStore('count', 500);

  @override
  Widget build(BuildContext context) {
    final (countO, _, setDown) = $count;

    return Column(
      children: [
        Observer(
          observable: countO,
          builder: (context, obs, value) => Text('Store : $value'),
        ),
        FloatingActionButton(onPressed: () => setDown((prev) => prev - 1)),
      ],
    );
  }
}

```

#### Filtered Local State

```dart
final $count = useTag(3);

final (count, setCount, _) = $count;
setCount(1, tags : ['widget1']); // tags?
```

###### Usage

```dart
// same Observer, multiple listeners
// refer tag_example

Widget : 

TaggedObserver(
            observable: count,
            builder: (context, value, obs, invalid) => Text(
                  'data',
                  style: TextStyle(
                    color: invalid ? Colors.white : Colors.blueAccent,
                  ),
                ),
            tag: 'tag')
        .distinct(); // extension
        .....
```
###### TaggedObserver extensions

```dart
distinct();
invalidatePrevNext();
invalidateDistinctPrevNext();
invalidateNext();
// refer API docs
```
#### Stateless usage
```dart
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final (count, setCount, _) = useState(50);
    final (balls, _, setBalls) = useStore('counter', 50);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Observer(
          observable: count,
          builder: (context, obs, value) => Text('Count : $value'),
        ),
        Observer(
          observable: balls,
          builder: (context, obs, value) => Text('Balls : $value'),
        ),
        OutlinedButton(
            onPressed: () => setCount(100), child: const Text('make it 100')),
        OutlinedButton(
            onPressed: () => setBalls((prev) => prev + 100),
            child: const Text('more balls'))
      ],
    );
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