import 'package:enum_map/enum_map.dart';

@MakeMap()
@MakeUnmodifiableMap()
enum Fruit {
  apple,
  orange,
  banana,
}

void main() {
  final modifiableMap = FruitMap<String>(apple: 'a', orange: 'o', banana: 'b');
  print(modifiableMap); // prints: {Fruit.apple: a, Fruit.orange: o, Fruit.banana: b}
  print(modifiableMap[Fruit.apple]); //     prints: a
  print(modifiableMap.get(Fruit.apple)); // prints: a

  const unmodifiableMap = UnmodifiableFruitMap<String>(apple: 'a', orange: 'o', banana: 'b');
  print(unmodifiableMap); // prints: {Fruit.apple: a, Fruit.orange: o, Fruit.banana: b}
  print(unmodifiableMap[Fruit.apple]); //     prints: a
  print(unmodifiableMap.get(Fruit.apple)); // prints: a
}
