# o

## _Under Progress_

o is a simple state management util to manage AppState and LocalState.

- Based on Streams
- Easy LocalState management
- Global singleton for AppState
- Beta

## Features

- It's so bad and dumb
- StreamBuilder based helper widgets
- Previous state
- Notify state
- Hooks for easy usage
- Customizable
- Filter-out unwanted rebuilds.

#### Local State

```dart
final (count, setCount, _) = useState(50);
setCount(23);
```

```dart
final (count, _, setCount) = useState(50);
setCount((prev) => prev + 10);
```

###### Usage

```dart
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final (count, setCount, _) = useState(50);
    final (balls, _, setBalls) = useState(50);

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

#### App State

```dart
final (down, setDown, _) = useStore('counter', 500);
setDown(69);
```

```dart
final (down, _, setDown) = useStore('counter', 500);
setDown((prev) => prev - 1);
```

###### Usage

```dart

main() {
  useStore<int>('counter', 150);
  // unnecessary, [ref] automatically creates a state if needed.
  // use it when runtime stream listeners create states.
  // refer auth_example

  runApp(const MaterialApp(home: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final (down, _, setDown) = useStore('counter', 500); // [ref]

    return Column(
      children: [
        Observer(
          observable: down,
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
final (count, _, setCount) = useTag(3);

setCount((prev)=> 1, tags : ['widget1']); // tags?
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

```sh
:)
```

_Special thanks to [@theniceboy](https://github.com/theniceboy)_
| [Gist](https://gist.github.com/theniceboy/fa1546517f1b18faf3186a31c8f452c6)

## License

MIT

**Free Software, Hell Yeah!**
