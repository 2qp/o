import 'package:flutter/material.dart';
import 'package:o/o.dart';

main() => runApp(const App());

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

class Listener extends StatelessWidget {
  const Listener({super.key});

  @override
  Widget build(BuildContext context) {
    final (count, setCount) = useState(50);
    final (down, setDown) = useStore('counter', 500);

    return Column(
      children: [
        Observer(
          observable: count,
          builder: (p0, p1, p2, p3) => Text('Local State : ${p2.toString()}'),
        ),
        Observer(
          observable: down,
          builder: (p0, p1, p2, p3) => Text('App State : ${p2.toString()}'),
        ),
        FloatingActionButton(onPressed: () {
          setCount((prev) => prev + 1);
          setDown((prev) => prev - 1);
        }),
      ],
    );
  }
}
