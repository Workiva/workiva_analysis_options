# Workiva's Shared Dart Analysis Options

This is our take on the Dart team's [`pedantic` package][pedantic] and is used
in all Workiva Dart packages.

This package (`package:workiva_analysis_options`) publicly exports
`analysis_options.yaml` files that can be included in a project's own
`analysis_options.yaml`.

```yaml
# pubspec.yaml
dev_dependencies:
  workiva_analysis_options: ^1.0.0
```

```yaml
# analysis_options.yaml
include: package:workiva_analysis_options/analysis_options.yaml
```

Because most packages don't commit a `pubspec.lock`, CI may fail whenever a new
version of `workiva_analysis_options` is released due to changes in these shared
options. To avoid this, consumers should target a specific version of
`analysis_options.yaml` instead:

```yaml
# analysis_options.yaml
include: package:workiva_analysis_options/analysis_options.1.0.0.yaml
```

## How lints and analyzer rules are evaluated

Periodically, Workiva's Client Platform team will evaluate the available lints
and rules and attempt to categorize them into one of the following:

- Required
  - Should provide enough value that it is worth requiring them for all Workiva
    dart projects.
  - Should not contradict any other required rules.
  - Usually help identify problematic code or protect against patterns that can
    be confusing or incorrect.
  - May enforce stylistic/subjective patterns that are nearly universally agreed
    upon within the organization.

- Recommended
  - Should be valuable to most projects.
  - Should not contradict any required rules or other recommended rules.
  - May have certain exceptions or caveats that prevent them from being
    required.
  - May be used for rules that could be required, but are not currently worth
    the investment due to the # of infractions that would need to be fixed in
    order to adopt.
  - May be used for rules that are intended to be upgraded to required in the
    future but are either new or were not previously required.

- Optional
  - Should not contradict any required or recommended rules.
  - May have incompatibilities with common patterns or libraries used at
    Workiva.
  - Often times stylistic or subjective.
  - May be used for rules that could be recommended, but are not currently worth
    the investment due to the # of infractions that would need to be fixed in
    order to adopt.
  - May be used for rules that are intended to be upgraded to recommended in the
    future but are either new or were not previously required.

- Avoid/Not Recommended
  - May contradict one or more required or recommended rules.
  - May be targeted towards domains that Workiva dart development does not (yet)
    overlap with (e.g. flutter).
  - May be experimental or very new.
  - May have an unclear long-term impact that should be avoided until more
    investigation/experimentation can be done.

We will also seek feedback from the Dart developers at Workiva on a regular
basis and will document these designations here in this README so that anyone
can contribute or suggest changes.

## Upgrading to the latest shared options

To upgrade from workiva_analysis_options version `<current>` to `<new>`:

```diff
  # pubspec.yaml
  dev_dependencies:
-   workiva_analysis_options: ^<current>
+   workiva_analysis_options: ^<new>
```

```diff
  # analysis_options.yaml
- include: package:workiva_analysis_options/analysis_options.<current>.yaml
+ include: package:workiva_analysis_options/analysis_options.<new>.yaml
```

Then all errors found by the analyzer in your IDE or by `ddev analyze` should be
fixed and PR'd to master.

## Opting in to recommended and/or optional rules

The default `analysis_options.yaml` files only enable the required rules,
but this package also provides "strict" and "experimental" versions that also
enable the recommended and optional rules, respectively.

```yaml
# analysis_options.yaml
# Enables all required AND recommended rules.
include: package:workiva_analysis_options/analysis_options.strict.1.0.0.yaml
```

```yaml
# analysis_options.yaml
# Enables all required AND recommended AND optional rules.
include: package:workiva_analysis_options/analysis_options.experimental.1.0.0.yaml
```

## Ensuring adoption of the latest shared options

The [`abide` tool][abide] will be integrated into a CI check to verify that
Workiva Dart projects depend on this package at a specific version (or later)
and include the shared config in `analysis_options.yaml`.

## Ensuring that analyzer errors/warnings/lints get fixed

All required analyzer lints and rules will have their severities upgraded to
"error" so that they cause analysis to fail by default.

```yaml
# package:workiva_analysis_options/analysis_options.yaml
analyzer:
  errors:
    avoid_empty_else: error
```

---

## Latest Analysis Options Designations

### Lints

_TODO: Finalize these designations for v1.0.0. This is currently just a
placeholder to demonstrate how these will be documented._

Level | Name | Issue Link
-|-|-
![require][lvl-req] | [`avoid_return_types_on_setters`][avoid_return_types_on_setters] | #10
![require][lvl-req] | [`avoid_init_to_null`][avoid_init_to_null] | #11
![recommend][lvl-rec] | [`non_constant_identifier_names`][non_constant_identifier_names] | #12
![recommend][lvl-rec] | [`prefer_initializing_formals`][prefer_initializing_formals] | #13
![optional][lvl-opt] | [`avoid_js_rounded_ints`][avoid_js_rounded_ints] | #14
![optional][lvl-opt] | [`avoid_renaming_method_parameters`][avoid_renaming_method_parameters] | #15
![avoid][lvl-avoid] | [`lines_longer_than_80_chars`][lines_longer_than_80_chars] | #16
![avoid][lvl-avoid] | [`prefer_double_quotes`][prefer_double_quotes] | #17

[abide]: https://github.com/Workiva/abide
[pedantic]: https://github.com/dart-lang/pedantic
[lvl-req]: https://img.shields.io/badge/-require-blue
[lvl-rec]: https://img.shields.io/badge/-recommend-green
[lvl-opt]: https://img.shields.io/badge/-optional-lightgrey
[lvl-avoid]: https://img.shields.io/badge/-avoid-red

[avoid_js_rounded_ints]: https://dart-lang.github.io/linter/lints/avoid_js_rounded_ints.html
[avoid_renaming_method_parameters]: https://dart-lang.github.io/linter/lints/avoid_renaming_method_parameters.html
[avoid_return_types_on_setters]: https://dart-lang.github.io/linter/lints/avoid_return_types_on_setters.html
[avoid_init_to_null]: https://dart-lang.github.io/linter/lints/avoid_init_to_null.html
[lines_longer_than_80_chars]: https://dart-lang.github.io/linter/lints/lines_longer_than_80_chars.html
[non_constant_identifier_names]: https://dart-lang.github.io/linter/lints/non_constant_identifier_names.html
[prefer_double_quotes]: https://dart-lang.github.io/linter/lints/prefer_double_quotes.html
[prefer_initializing_formals]: https://dart-lang.github.io/linter/lints/prefer_initializing_formals.html
[prefer_mixin]: https://dart-lang.github.io/linter/lints/prefer_mixin.html
