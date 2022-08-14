import 'package:analyzer/dart/element/element.dart';
import 'package:enum_map/annotations.dart';
import 'package:source_gen/source_gen.dart';

import 'abstract_map_generator.dart';

class UnmodifiableEnumMapGenerator
    extends AbstractEnumMapGenerator<UnmodifiableEnumMap> {
  @override
  UnmodifiableEnumMap readAnnotation(ConstantReader reader) {
    return const UnmodifiableEnumMap();
  }

  @override
  String getClassName(UnmodifiableEnumMap a, EnumElement e) {
    return 'Unmodifiable${e.name}Map';
  }

  @override
  String getConstant(UnmodifiableEnumMap a, EnumElement e, FieldElement c) {
    return 'final V ${c.name}';
  }

  @override
  String getOperatorSetBody(UnmodifiableEnumMap a, EnumElement e) {
    return 'throw Exception("Cannot modify this map.");';
  }

  @override
  String getAddEntriesBody(UnmodifiableEnumMap a, EnumElement e) {
    return 'throw Exception("Cannot modify this map.");';
  }

  @override
  String getUpdateBody(UnmodifiableEnumMap a, EnumElement e) {
    return 'throw Exception("Cannot modify this map.");';
  }

  @override
  String getUpdateAllBody(UnmodifiableEnumMap a, EnumElement e) {
    return 'throw Exception("Cannot modify this map.");';
  }

  @override
  String getAddAllBody(UnmodifiableEnumMap a, EnumElement e) {
    return 'throw Exception("Cannot modify this map.");';
  }
}
