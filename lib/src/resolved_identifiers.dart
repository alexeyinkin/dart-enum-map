// ignore_for_file: constant_identifier_names
// ignore_for_file: deprecated_member_use
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs

import 'package:macros/macros.dart';

import 'libraries.dart';

class ResolvedIdentifiers {
  ResolvedIdentifiers({
    required this.bool,
    required this.EnumMap,
    required this.int,
    required this.Iterable,
    required this.Map,
    required this.MapEntry,
    required this.Object,
    required this.override,
    required this.String,
    required this.StringBuffer,
    required this.UnmodifiableEnumMap,
    required this.UnmodifiableListView,
    required this.UnsupportedError,
  });

  final Identifier bool;
  final Identifier EnumMap;
  final Identifier int;
  final Identifier Iterable;
  final Identifier Map;
  final Identifier MapEntry;
  final Identifier Object;
  final Identifier override;
  final Identifier String;
  final Identifier StringBuffer;
  final Identifier UnmodifiableEnumMap;
  final Identifier UnmodifiableListView;
  final Identifier UnsupportedError;

  static Future<ResolvedIdentifiers> fill(
    MemberDeclarationBuilder builder,
  ) async {
    final (
      (
        bool,
        EnumMap,
        int,
        Iterable,
        Map,
        MapEntry,
        Object,
        override,
      ),
      (
        String,
        StringBuffer,
        UnmodifiableEnumMap,
        UnmodifiableListView,
        UnsupportedError,
      ),
    ) = await (
      (
        builder.resolveIdentifier(Libraries.core, 'bool'),
        builder.resolveIdentifier(Libraries.enumMap, 'EnumMap'),
        builder.resolveIdentifier(Libraries.core, 'int'),
        builder.resolveIdentifier(Libraries.core, 'Iterable'),
        builder.resolveIdentifier(Libraries.core, 'Map'),
        builder.resolveIdentifier(Libraries.core, 'MapEntry'),
        builder.resolveIdentifier(Libraries.core, 'Object'),
        builder.resolveIdentifier(Libraries.core, 'override'),
      ).wait,
      (
        builder.resolveIdentifier(Libraries.core, 'String'),
        builder.resolveIdentifier(Libraries.core, 'StringBuffer'),
        builder.resolveIdentifier(
          Libraries.unmodifiableEnumMap,
          'UnmodifiableEnumMap',
        ),
        builder.resolveIdentifier(Libraries.collection, 'UnmodifiableListView'),
        builder.resolveIdentifier(Libraries.core, 'UnsupportedError'),
      ).wait,
    ).wait;

    return ResolvedIdentifiers(
      bool: bool,
      EnumMap: EnumMap,
      int: int,
      Iterable: Iterable,
      Map: Map,
      MapEntry: MapEntry,
      Object: Object,
      override: override,
      String: String,
      StringBuffer: StringBuffer,
      UnmodifiableEnumMap: UnmodifiableEnumMap,
      UnmodifiableListView: UnmodifiableListView,
      UnsupportedError: UnsupportedError,
    );
  }
}
