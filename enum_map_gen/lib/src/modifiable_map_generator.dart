import 'package:analyzer/dart/element/element.dart';
import 'package:enum_map/annotations.dart';
import 'package:source_gen/source_gen.dart';

import 'abstract_map_generator.dart';

class ModifiableEnumMapGenerator extends AbstractEnumMapGenerator<EnumMap> {
  @override
  EnumMap readAnnotation(ConstantReader reader) {
    return const EnumMap();
  }

  @override
  String getClassName(EnumMap a, EnumElement e) {
    return '${e.name}Map';
  }

  @override
  String getConstant(EnumMap a, EnumElement e, FieldElement c) {
    return 'V ${c.name}';
  }

  @override
  String getConstructor(EnumMap a, EnumElement e) {
    return getClassName(a, e) + getConstructorArguments(a, e) + ';\n';
  }
}
