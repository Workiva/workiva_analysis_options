FROM drydock-prod.workiva.net/workiva/dart2_base_image:0.0.0-dart2.7.0

WORKDIR /build/
COPY pubspec.yaml .
RUN pub get

FROM scratch
