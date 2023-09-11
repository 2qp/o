import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o/o.dart';

main() {
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

class Listener extends StatefulWidget {
  const Listener({super.key});

  @override
  State<Listener> createState() => _ListenerState();
}

class _ListenerState extends State<Listener> {
  final $local = useState(50);
  final $global = useStore('counter', 500);

  @override
  Widget build(BuildContext context) {
    final (count, _, _) = $local;
    final (down, _, _) = $global;

    return Column(
      children: [
        Observer(
          observable: count,
          builder: (context, obs, value) => Text('Local State : $value.'),
        ),
        Observer(
          observable: down,
          builder: (context, obs, value) => Text('App State : $value'),
        ),
        FloatingActionButton(
          onPressed: handleClick,
          child: const Icon(CupertinoIcons.add),
        ),
      ],
    );
  }

  void handleClick() {
    final (_, setCount, _) = $local;
    final (_, _, setDown) = $global;

    setCount(23);
    setDown((prev) => prev - 1);
  }
}
