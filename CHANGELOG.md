## 1.4.1

- [#200](https://github.com/Workiva/workiva_analysis_options/pull/200) Remove
`sdk_version_<language_feature>` rules. These were diagnostics produced by the
analyzer when a language feature was used without specifying the proper minimum
SDK version and this package was promoting them to errors since earlier versions
of Dart did not do that by default. They are no longer necessary.

## 1.4.0

- [#198](https://github.com/Workiva/workiva_analysis_options/pull/198) Add NNBD-related lints

## 1.3.0

- Add `v2` rulesets:
  - `package:workiva_analysis_options/v2.yaml`
  - `package:workiva_analysis_options/v2.recommended.yaml`

## 1.2.5

- CI tweaks.

## 1.2.4

- Replace deprecated `pub` commands.

## 1.2.3

- CI tweaks.

## 1.2.2

- The following rules are no longer promoted to warnings:
  - `unused_element`
  - `unused_field`
  - `unused_import`
  - `unsafe_html`

## 1.2.1

- Widen dependency ranges.

## 1.2.0

- Null safety release. No Dart code in this package's `lib/`, so this is being
done in a minor release.
- Switch from Travis CI to GitHub workflow.

## 1.1.0

- Add ignore for uri_has_not_been_generated errors

## 1.0.2

- Setup Travis CI

## 1.0.1

- Initial release
