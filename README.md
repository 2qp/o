# o

## _Under Progress_

o is a simple state management util to manage AppState and LocalState.

- Based on Streams
- Global singleton for AppState
- Beta

## Features

- It's so bad and dumb
- StreamBuilder based helper widgets
- Previous state
- Notify state
- Hooks for easy usage
- Customizable

##### Local State

```dart
final (count, setCount) = useState(50);
```

##### App State

```dart
final (down, setDown) = useStore('counter', 500);
```

##### Widget

```dart
Observer(observable: observable, builder: (context, observable, value, hasData) => ...)
```

##### Dep Injector

```dart
dependencies(
        [useStore<int>('counter', 25)],
        app: const Scaffold(body: Center(child: Listener())),
      );
```

##### Service Injector

```dart
dependencies([
      //useStore<int>('counter', 25),
    ],
        app: injector(
            objects: [AuthService(keyname: 'auth')],
            functions: [],
            app: const MaterialApp(
              home: AuthView(),
            )));
```

## Usage

### App State

> > this `isn't necessary` .
> > `useStore` always register an observable if there isn't any by the key .
> > but better .
> > in any `upper` widget

```dart
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: dependencies(
        [useStore<int>('counter', 25)],
        app: const Scaffold(body: Center(child: Listener())),
      ),
    );
  }
}
```

and access it in `any` widget

```dart
class Listener extends StatelessWidget {
  const Listener({super.key});

  @override
  Widget build(BuildContext context) {
    final (down, setDown) = useStore('counter', 500);

    return Column(
      children: [
        Observer(
          observable: down,
          builder: (context, observable, value, hasData) => Text('App State : ${value.toString()}'),
        ),
        FloatingActionButton(onPressed: () {
          setDown((prev) => prev - 1);
        }),
      ],
    );
  }
}
```

### Local State

> > simple

```dart
class Listener extends StatelessWidget {
  const Listener({super.key});

  @override
  Widget build(BuildContext context) {
    final (count, setCount) = useState(50);

    return Column(
      children: [
        Observer(
          observable: count,
          builder: (context, observable, value, hasData) => Text('Local State : ${value.toString()}'),
        ),
        FloatingActionButton(onPressed: () {
          setCount((prev) => prev + 1);
        }),
      ],
    );
  }
}
```

```sh
:)
```

_Special thanks to [@theniceboy](https://github.com/theniceboy)_ | [Gist](https://gist.github.com/theniceboy/fa1546517f1b18faf3186a31c8f452c6)

## License

MIT

**Free Software, Hell Yeah!**
