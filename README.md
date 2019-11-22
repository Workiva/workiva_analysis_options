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
include: package:workiva_analysis_options/v1.yaml
```

Because most packages don't commit a `pubspec.lock`, CI may fail if updates to
the `analysis_options.yaml` files in this package are automatically consumed. To
avoid this, all of these files include a version in the filename, and changes
that could cause new analyzer failures will only ever be introduced in separate,
versioned files.

For example, in the next release of this library, the existing `v1` files will
remain unmodified:

- `package:workiva_analysis_options/v1.yaml`
- `package:workiva_analysis_options/v1.recommended.yaml`

And changes to the analysis options will only be included in new `v2` files:

- `package:workiva_analysis_options/v2.yaml`
- `package:workiva_analysis_options/v2.recommended.yaml`

This enables consumers to depend on this package with a version range like
`^1.0.0` while being able to manage their analysis options upgrade separately.

## How lints and analyzer rules are evaluated

Periodically, Workiva's Client Platform team will evaluate the available lints
and rules and attempt to categorize them into one of the following:

- Required
  - Should provide enough value that it is worth requiring them for all Workiva
    Dart projects.
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
  - May be targeted towards domains that Workiva Dart development does not (yet)
    overlap with (e.g. flutter).
  - May be experimental or very new.
  - May have an unclear long-term impact that should be avoided until more
    investigation/experimentation can be done.

We will use feedback from the Dart developers at Workiva, other similar
resources (like the [`pedantic` package][pedantic]), and the number of existing
infractions across Workiva Dart projects (collected automatically) to inform our
decisions. Each lint has its own issue in this repo that can be used to discuss
changes and will serve as documentation of context and reasons that influenced
the decisions.

## Opting in to recommended rules

The default `analysis_options.yaml` files only enable the required rules,
but this package also provides a separate version that also enables the
recommended rules.

```yaml
# analysis_options.yaml
# Enables all required AND recommended rules.
include: package:workiva_analysis_options/v1.recommended.yaml
```

_Note: there is also a version provided by this library that includes the
optional rules, but it is only intended for use in an automated fashion for the
purpose of gathering data on the number of infractions in Workiva packages._

## Ensuring adoption of the latest shared options

An automated tool will be integrated into a CI check to verify that Workiva Dart
projects depend on this package at a specific version (or later) and include the
shared config in `analysis_options.yaml`.

## Ensuring that analyzer infractions get fixed

All required analyzer lints and infos/hints/lints will have their severities
upgraded to "warning", e.g.:

```yaml
# package:workiva_analysis_options/v1.yaml
analyzer:
  errors:
    avoid_empty_else: warning
```

It is then expected (and enforced internally at Workiva) that CI and developers
run analysis in a way that results in a non-zero exit code when errors or
warnings are present.

With `dartanalyzer`, this means using `--fatal-warnings`. With `tuneup`, this is
enforced by default.

---

## Latest Analysis Options Designations

[Lints & Rules Table of Contents][lints-toc]

[lints-toc]: https://github.com/Workiva/workiva_analysis_options/issues/2
[pedantic]: https://pub.dev/packages/pedantic
