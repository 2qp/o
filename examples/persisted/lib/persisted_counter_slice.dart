import 'dart:async';

import 'package:o/o.dart';
import 'package:shared_preferences/shared_preferences.dart';

final $persisted =
    createStore<int, PersistedCounterActions>(1, _counterReducer);

sealed class PersistedCounterActions {
  const PersistedCounterActions();
}

class PersistedIncrementAction extends PersistedCounterActions {
  final int amount;
  const PersistedIncrementAction(this.amount);
}

class GetIncrementAction extends PersistedCounterActions {
  const GetIncrementAction();
}

class SyncIncrement extends PersistedCounterActions {
  const SyncIncrement();
}

Future<int> _counterReducer(int state, PersistedCounterActions action) async =>
    switch (action) {
      PersistedIncrementAction(amount: final amount) =>
        await persistState(state, amount),
      GetIncrementAction() => state,
      SyncIncrement() => await getPersistedState(),
    };

Future<int> persistState(int state, int amount) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final s = state + amount;
  await prefs.setInt('counter', s);
  return s;
}

Future<int> getPersistedState() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int? counter = prefs.getInt('counter');
  return counter ?? 1;
}
