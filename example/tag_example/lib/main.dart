import 'package:flutter/material.dart';
import 'package:o/o.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavBarView(),
      body: Center(),
    ));
  }
}

class BottomNavBarView extends StatelessWidget {
  const BottomNavBarView({super.key});

  @override
  Widget build(BuildContext context) => const CustomNavBar();
}

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final (count, setCount, _) = useTag(3);

    final List<NavItem> items = [
      NavItem(
        Icons.ac_unit,
        Colors.blueAccent,
      ),
      NavItem(Icons.home_max, Colors.blueAccent),
      NavItem(Icons.maps_home_work, Colors.blueAccent),
      NavItem(Icons.shopping_bag, Colors.blueAccent),
      NavItem(Icons.account_circle_outlined, Colors.blueAccent)
    ];

    return Row(
      children: <Widget>[
        for (int index = 0; index < items.length; index++)
          TaggedObserver(
                  observable: count,
                  builder: (context, value, obs, invalid) => ItemBuilder(
                      icon: items[index].icon,
                      label: '',
                      onClick: () => setCount(index, tags: [index.toString()]),
                      color: invalid ? Colors.white : items[index].color),
                  tag: index.toString())
              .invalidatePrevNext()
      ],
    );
  }
}

class ItemBuilder extends StatelessWidget {
  const ItemBuilder({
    super.key,
    required this.icon,
    required this.label,
    required this.onClick,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: () => onClick(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(icon, color: color)],
      ),
    ));
  }
}

class NavItem {
  final IconData icon;
  final Color color;

  NavItem(this.icon, this.color);
}

final items = [
  NavItem(
    Icons.ac_unit,
    Colors.blueAccent,
  ),
  NavItem(Icons.home_max, Colors.blueAccent),
  NavItem(Icons.maps_home_work, Colors.blueAccent),
  NavItem(Icons.shopping_bag, Colors.blueAccent),
  NavItem(Icons.account_circle_outlined, Colors.blueAccent)
];
