FROM google/dart:2

WORKDIR /build/
COPY pubspec.yaml .
RUN pub get

FROM scratch
