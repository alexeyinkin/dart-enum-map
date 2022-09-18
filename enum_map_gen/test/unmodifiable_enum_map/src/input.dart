import 'package:enum_map/enum_map.dart';
import 'package:source_gen_test/annotations.dart';

part 'output.dart';

@ShouldGenerateGolden('output.dart', partOfCurrent: true)
@unmodifiableEnumMap
enum Fruit {
  apple,
  orange,
  banana,
}
