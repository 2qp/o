import 'package:flutter_test/flutter_test.dart';

import 'package:o/o.dart';

void main() {
  test('useState test', () {
    final (count, setCount) = useState(5);
    setCount((p0) => 5);
    expect(count.value, 5);
  });

  test('useStore test', () {
    final (gCount, setGCount) = useStore('count', 2);
    setGCount((p0) => p0 + 1);
    expect(gCount.value, 3);

    getStore().removeObservable(key: 'count');
    // ignore: unused_local_variable
    final (newCount, setNewCount) = useStore('count', 100);
    expect(newCount.value, 100);

    // ignore: unused_local_variable
    final (sameCount, setSameCount) = useStore('count', 500);
    expect(sameCount.value, 100);
  });
}
