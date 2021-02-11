FROM docker.io/golang:latest as builder

WORKDIR /build
ADD . /build/

RUN export GARCH="$(uname -m)" && GOOS=linux GOARCH=${GARCH} CGO_ENABLED=0 go build -mod=vendor -o api-server .

FROM scratch

WORKDIR /app
COPY --from=builder /build/api-server /app/api-server

CMD [ "/app/api-server" ]
