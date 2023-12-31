import 'package:flutter_test/flutter_test.dart';

import 'package:o/o.dart';

var state = createStore<CounterState, CounterActions>(
    const CounterState(0), counterReducer);

void main() {
  group('Global State Management Tests', () {
    setUp(() {
      // Initialize or reset your global state before each test if needed.
      state = createStore<CounterState, CounterActions>(
          const CounterState(0), counterReducer);
    });

    tearDown(() {
      // Clean up resources after each test if needed.
      state.dispose();
    });

    test('Initial state is as expected', () async {
      expect(
          await state.dispatch(RetreiveValue()), equals(const CounterState(0)));
    });

    test('Global state can be updated', () async {
      // Perform an action that updates the global state.

      await state.dispatch(const IncrementAction(42));

      // Verify that the global state has been updated.
      expect(await state.dispatch(RetreiveValue()),
          equals(const CounterState(42)));
    });
  });
}

class CounterState {
  final int value;

  @override
  bool operator ==(Object other) =>
      other is CounterState && other.value == value;

  @override
  int get hashCode => value.hashCode;

  const CounterState(this.value);
}

sealed class CounterActions {
  const CounterActions();
}

class RetreiveValue extends CounterActions {}

class IncrementAction extends CounterActions {
  final int amount;
  const IncrementAction(this.amount);
}

Future<CounterState> counterReducer(
        CounterState state, CounterActions action) async =>
    switch (action) {
      IncrementAction(amount: final amount) =>
        CounterState(state.value + amount),
      RetreiveValue() => state,
    };
