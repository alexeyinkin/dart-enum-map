// ignore_for_file: public_member_api_docs

import 'package:macros/macros.dart';

import 'enum_introspection_data.dart';
import 'resolved_identifiers.dart';

class IntrospectionData {
  IntrospectionData({
    required this.enumIntr,
    required this.enumName,
    required this.enuum,
    required this.ids,
    required this.mapClassName,
  });

  final EnumIntrospectionData enumIntr;
  final String enumName;
  final TypeDeclaration enuum;
  final ResolvedIdentifiers ids;
  final String mapClassName;
}
