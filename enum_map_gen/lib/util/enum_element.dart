import 'package:analyzer/dart/element/element.dart';

extension MyEnumElement on EnumElement {
  Iterable<FieldElement> get constants {
    return fields.where((e) => e.isEnumConstant);
  }
}
