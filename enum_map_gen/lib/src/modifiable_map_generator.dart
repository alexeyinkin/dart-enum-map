import 'package:analyzer/dart/element/element.dart';
import 'package:enum_map/annotations.dart';
import 'package:source_gen/source_gen.dart';

import 'abstract_map_generator.dart';

class ModifiableEnumMapGenerator
    extends AbstractEnumMapGenerator<GenerateEnumMap> {
  @override
  GenerateEnumMap readAnnotation(ConstantReader reader) {
    return const GenerateEnumMap();
  }

  @override
  String getClassName(GenerateEnumMap a, EnumElement e) {
    return '${e.name}Map';
  }

  @override
  String getSuperclassName(GenerateEnumMap a, EnumElement e) {
    return 'EnumMap';
  }

  @override
  String getConstant(GenerateEnumMap a, EnumElement e, FieldElement c) {
    return 'V ${c.name}';
  }

  @override
  String getConstructor(GenerateEnumMap a, EnumElement e) {
    return getClassName(a, e) + getConstructorArguments(a, e) + ';\n';
  }
}
