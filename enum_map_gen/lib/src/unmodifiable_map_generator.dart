import 'package:analyzer/dart/element/element.dart';
import 'package:enum_map/annotations.dart';
import 'package:source_gen/source_gen.dart';

import 'abstract_map_generator.dart';

class UnmodifiableEnumMapGenerator
    extends AbstractEnumMapGenerator<GenerateUnmodifiableEnumMap> {
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
    return 'throw Exception("Cannot modify this map.");';
  }

  @override
  String getAddEntriesBody(GenerateUnmodifiableEnumMap a, EnumElement e) {
    return 'throw Exception("Cannot modify this map.");';
  }

  @override
  String getUpdateBody(GenerateUnmodifiableEnumMap a, EnumElement e) {
    return 'throw Exception("Cannot modify this map.");';
  }

  @override
  String getUpdateAllBody(GenerateUnmodifiableEnumMap a, EnumElement e) {
    return 'throw Exception("Cannot modify this map.");';
  }

  @override
  String getAddAllBody(GenerateUnmodifiableEnumMap a, EnumElement e) {
    return 'throw Exception("Cannot modify this map.");';
  }
}
