FROM rust:1-alpine AS builder
RUN apk add --no-cache musl-dev
WORKDIR /src
COPY . .
RUN cargo build --release

FROM alpine:3
COPY --from=builder /src/target/release/REPLACE_ME /usr/local/bin/
ENTRYPOINT ["REPLACE_ME"]
CMD ["--transport", "streamable-http", "--host", "0.0.0.0"]
