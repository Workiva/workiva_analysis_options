FROM google/dart:2.4.1

# TODO: move these checks to Travis CI when OSS

WORKDIR /build/
COPY . .
RUN pub get
RUN pub publish --dry-run

WORKDIR /build/example/
RUN pub get
RUN dartanalyzer .

FROM scratch
