import 'package:test/test.dart';

import 'src/input.dart';

void main() {
  late UnmodifiableFruitMap<String> map;

  setUp(() {
    // ignore: prefer_const_constructors
    map = UnmodifiableFruitMap<String>(
      apple: 'apple',
      banana: 'banana',
      orange: 'orange',
    );
  });

  test('containsValue', () {
    expect(map.containsValue('apple'), true);
    expect(map.containsValue('banana'), true);
    expect(map.containsValue('orange'), true);

    expect(map.containsValue('kiwi'), false);
    expect(map.containsValue(DateTime(2022)), false);
  });

  test('containsKey', () {
    expect(map.containsKey(Fruit.apple), true);
    expect(map.containsKey(Fruit.banana), true);
    expect(map.containsKey(Fruit.orange), true);

    expect(map.containsKey(null), false);
    expect(map.containsKey(DateTime(2022)), false);
  });

  test('operator []=', () {
    expect(
      () => map[Fruit.apple] = 'apple',
      throwsException,
    );
  });
}
