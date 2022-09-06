import 'abstract_generate_enum_map.dart';

/// Use this annotation on enums to create an unmodifiable map based on them.
/// Such map has a const constructor.
class GenerateUnmodifiableEnumMap extends AbstractGenerateEnumMap {
  ///
  const GenerateUnmodifiableEnumMap();
}

/// Use this annotation on enums to create a modifiable map based on them.
/// Such map has a const constructor.
const unmodifiableEnumMap = GenerateUnmodifiableEnumMap();
