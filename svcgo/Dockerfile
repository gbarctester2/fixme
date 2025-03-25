FROM docker.io/library/golang:1.24-alpine

RUN mkdir -p /app

# Install base packages
ADD . /app/
WORKDIR /app

# Start the server by default, this can be overwritten at runtime
RUN go build
EXPOSE 8888
CMD ["./com.test.svcgo"]
