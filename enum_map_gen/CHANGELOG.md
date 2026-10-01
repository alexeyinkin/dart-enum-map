## 0.3.2

* Require `analyzer` 8.1.1 or later, `source_gen` 4.x, and `build` 3.x or 4.x.
  This supports `analyzer` up to 14.x. Projects on older `analyzer` versions resolve 0.3.1.
* **BREAKING:** Removed the `MyEnumElement` extension.
  Use `EnumElement.constants` from `analyzer` instead.
* Fixed blank lines between entries in the generated `entries` getter.

## 0.3.1

* Using [source_gen_test](https://pub.dev/packages/source_gen_test) for testing generated code.

## 0.3.0

* **BREAKING:** Unsupported operations throw `UnsupportedError` instead of `Exception`.
* **BREAKING:** Unmodifiable map's `putIfAbsent` throws `UnsupportedError` instead of returning
  an always-existing value.
* Added golden tests for generation result.
* Added tests on goldens.
* Fixed linter issues on output.

## 0.2.0

* Require `enum_map` 0.2.0, see its changelog.

## 0.1.0

* Initial release.
