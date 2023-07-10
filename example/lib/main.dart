import 'package:flutter/material.dart';
import 'package:o/o.dart';

main() {
  useStore<int>('counter', 150);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Listener())),
    );
  }
}

class Listener extends StatelessWidget {
  const Listener({super.key});

  @override
  Widget build(BuildContext context) {
    final (count, setCount, _) = useState(50);

    final (pCount, _, setPrev) = useState(50);

    final (down, _, setDown) = useStore('counter', 500);

    return Column(
      children: [
        Observer(
          observable: count,
          builder: (context, obs, value) => Text('Local State : $value.'),
        ),
        Observer(
          observable: pCount,
          builder: (context, obs, value) => Text('Prev State : $value'),
        ),
        Observer(
          observable: down,
          builder: (context, obs, value) => Text('App State : $value'),
        ),
        Observer(
          observable: down,
          builder: (context, obs, value) => Text('App State : $value '),
        ),
        FloatingActionButton(onPressed: () {
          setCount(23);

          setPrev((prev) => prev + 10);

          setDown((prev) => prev - 1);
        }),
      ],
    );
  }
}
