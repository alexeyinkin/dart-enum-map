part of 'input.dart';

class UnmodifiableFruitMap<V> extends UnmodifiableEnumMap<Fruit, V> {
  final V apple;
  final V orange;
  final V banana;

  const UnmodifiableFruitMap({
    required this.apple,
    required this.orange,
    required this.banana,
  });

  @override
  Map<RK, RV> cast<RK, RV>() {
    return Map.castFrom<Fruit, V, RK, RV>(this);
  }

  @override
  bool containsValue(Object? value) {
    if (this.apple == value) return true;
    if (this.orange == value) return true;
    if (this.banana == value) return true;
    return false;
  }

  @override
  bool containsKey(Object? key) {
    return key.runtimeType == Fruit;
  }

  @override
  V? operator [](Object? key) {
    switch (key) {
      case Fruit.apple:
        return this.apple;
      case Fruit.orange:
        return this.orange;
      case Fruit.banana:
        return this.banana;
    }

    return null;
  }

  @override
  void operator []=(Fruit key, V value) {
    throw UnsupportedError('Cannot modify unmodifiable map');
  }

  @override
  Iterable<MapEntry<Fruit, V>> get entries {
    return [
      MapEntry<Fruit, V>(Fruit.apple, this.apple),
      MapEntry<Fruit, V>(Fruit.orange, this.orange),
      MapEntry<Fruit, V>(Fruit.banana, this.banana),
    ];
  }

  @override
  Map<K2, V2> map<K2, V2>(
    MapEntry<K2, V2> Function(Fruit key, V value) transform,
  ) {
    final apple = transform(Fruit.apple, this.apple);
    final orange = transform(Fruit.orange, this.orange);
    final banana = transform(Fruit.banana, this.banana);
    return {
      apple.key: apple.value,
      orange.key: orange.value,
      banana.key: banana.value,
    };
  }

  @override
  void addEntries(Iterable<MapEntry<Fruit, V>> newEntries) {
    throw UnsupportedError('Cannot modify unmodifiable map');
  }

  @override
  V update(Fruit key, V Function(V value) update, {V Function()? ifAbsent}) {
    throw UnsupportedError('Cannot modify unmodifiable map');
  }

  @override
  void updateAll(V Function(Fruit key, V value) update) {
    throw UnsupportedError('Cannot modify unmodifiable map');
  }

  @override
  void removeWhere(bool Function(Fruit key, V value) test) {
    throw UnsupportedError('Cannot remove objects from this map');
  }

  @override
  V putIfAbsent(Fruit key, V Function() ifAbsent) {
    throw UnsupportedError('Cannot modify unmodifiable map');
  }

  @override
  void addAll(Map<Fruit, V> other) {
    throw UnsupportedError('Cannot modify unmodifiable map');
  }

  @override
  V? remove(Object? key) {
    throw UnsupportedError('Cannot remove objects from this map');
  }

  @override
  void clear() {
    throw UnsupportedError('Cannot remove objects from this map');
  }

  @override
  void forEach(void Function(Fruit key, V value) action) {
    action(Fruit.apple, this.apple);
    action(Fruit.orange, this.orange);
    action(Fruit.banana, this.banana);
  }

  @override
  Iterable<Fruit> get keys {
    return Fruit.values;
  }

  @override
  Iterable<V> get values {
    return List.unmodifiable([
      this.apple,
      this.orange,
      this.banana,
    ]);
  }

  @override
  int get length {
    return 3;
  }

  @override
  bool get isEmpty {
    return false;
  }

  @override
  bool get isNotEmpty {
    return true;
  }

  @override
  V get(Fruit key) {
    switch (key) {
      case Fruit.apple:
        return this.apple;
      case Fruit.orange:
        return this.orange;
      case Fruit.banana:
        return this.banana;
    }
  }

  @override
  String toString() {
    final buffer = StringBuffer('{');
    buffer.write('Fruit.apple: ${this.apple}');
    buffer.write(', ');
    buffer.write('Fruit.orange: ${this.orange}');
    buffer.write(', ');
    buffer.write('Fruit.banana: ${this.banana}');
    buffer.write('}');
    return buffer.toString();
  }
}
