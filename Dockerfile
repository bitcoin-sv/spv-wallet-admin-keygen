# syntax=docker/dockerfile:1

ARG GO_VERSION=1.21
FROM --platform=$TARGETPLATFORM golang:${GO_VERSION} AS build
WORKDIR /src

COPY . /src

RUN --mount=type=cache,target=/go/pkg/mod/ \
    --mount=type=bind,source=go.sum,target=go.sum \
    --mount=type=bind,source=go.mod,target=go.mod \
    go mod download -x

RUN --mount=type=cache,target=/go/pkg/mod/ \
    --mount=type=bind,target=. \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -o /generator

FROM --platform=$TARGETPLATFORM bitnami/kubectl:latest AS final

WORKDIR /src

ENV SECRET_NAME=bux-keys
ENV XPUB_KEY_NAME=admin_xpub
ENV XPRV_KEY_NAME=admin_xpriv

COPY --from=build src/set_secret.sh .
COPY --from=build /generator .

USER root
RUN chmod +x /src/set_secret.sh
USER 1001

ENTRYPOINT [ "./set_secret.sh" ]
