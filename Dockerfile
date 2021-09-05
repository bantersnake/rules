FROM golang as builder

WORKDIR /build

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o battlesnake -a -ldflags '-extldflags "-static"' ./cli/battlesnake/main.go

FROM scratch

COPY --from=builder /build/battlesnake /app/battlesnake

WORKDIR /app

CMD ["./battlesnake"]