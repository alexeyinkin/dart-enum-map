import 'abstract_generate_enum_map.dart';

/// Use this annotation on enums to create a modifiable map based on them.
class GenerateEnumMap extends AbstractGenerateEnumMap {
  ///
  const GenerateEnumMap();
}

/// Use this annotation on enums to create a modifiable map based on them.
const enumMap = GenerateEnumMap();
