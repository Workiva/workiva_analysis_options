FROM google/dart:2.4.1

# TODO: move these checks to Travis CI when OSS

WORKDIR /build/
COPY . .
RUN pub get
RUN pub publish --dry-run
RUN dartfmt -n --set-exit-if-changed .
RUN pub run test

FROM scratch
