FROM drydock-prod.workiva.net/workiva/dart2_base_image:1

WORKDIR /build/
COPY pubspec.yaml .
RUN pub get

FROM scratch
