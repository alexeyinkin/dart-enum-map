import 'package:enum_map/enum_map.dart';
import 'package:source_gen_test_golden/annotations.dart';

part 'output.dart';

@ShouldGenerateFile('output.dart', partOfCurrent: true)
@unmodifiableEnumMap
enum Fruit {
  apple,
  orange,
  banana,
}
