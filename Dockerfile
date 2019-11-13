FROM drydock-prod.workiva.net/workiva/dart2_base_image:1

WORKDIR /build/
COPY . .
RUN pub get

# TODO: move these checks to Travis CI when OSS
RUN pub publish --dry-run
RUN dartfmt -n --set-exit-if-changed .
RUN pub run test

FROM scratch
