import 'package:analyzer/dart/element/element.dart';
import 'package:enum_map/annotations.dart';
import 'package:source_gen/source_gen.dart';

import 'abstract_map_generator.dart';

class UnmodifiableEnumMapGenerator
    extends AbstractEnumMapGenerator<GenerateUnmodifiableEnumMap> {
  static const _throwUnsupportedError =
      "throw UnsupportedError('Cannot modify unmodifiable map');";

  @override
  GenerateUnmodifiableEnumMap readAnnotation(ConstantReader reader) {
    return const GenerateUnmodifiableEnumMap();
  }

  @override
  String getClassName(GenerateUnmodifiableEnumMap a, EnumElement e) {
    return 'Unmodifiable${e.name}Map';
  }

  @override
  String getSuperclassName(GenerateUnmodifiableEnumMap a, EnumElement e) {
    return 'UnmodifiableEnumMap';
  }

  @override
  String getConstant(
    GenerateUnmodifiableEnumMap a,
    EnumElement e,
    FieldElement c,
  ) {
    return 'final V ${c.name}';
  }

  @override
  String getOperatorSetBody(GenerateUnmodifiableEnumMap a, EnumElement e) {
    return _throwUnsupportedError;
  }

  @override
  String getAddEntriesBody(GenerateUnmodifiableEnumMap a, EnumElement e) {
    return _throwUnsupportedError;
  }

  @override
  String getUpdateBody(GenerateUnmodifiableEnumMap a, EnumElement e) {
    return _throwUnsupportedError;
  }

  @override
  String getUpdateAllBody(GenerateUnmodifiableEnumMap a, EnumElement e) {
    return _throwUnsupportedError;
  }

  @override
  String getAddAllBody(GenerateUnmodifiableEnumMap a, EnumElement e) {
    return _throwUnsupportedError;
  }

  @override
  String getPutIfAbsentBody(GenerateUnmodifiableEnumMap a, EnumElement e) {
    return _throwUnsupportedError;
  }
}
