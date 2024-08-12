FROM docker.io/library/alpine:3.20.2

RUN --mount=type=cache,target=/var/cache/apk,sharing=locked apk add tar curl make parallel

COPY --from=docker.io/peakcom/s5cmd:v2.2.2 --chmod=555 /s5cmd /usr/local/bin/s5cmd

CMD ["make"]
