FROM google/dart:2

WORKDIR /build/
COPY pubspec.yaml .
RUN dart pub get

FROM scratch
