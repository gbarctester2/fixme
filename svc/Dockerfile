FROM ruby:3.2.6-slim

RUN ( \
   mkdir -p /svc; \
)
RUN (\
   apt update ; \
   apt install -y --no-install-recommends git make gcc g++ libpq-dev \
   && rm -rf /var/lib/apt/lists/*; \
   touch /pupa \
)
ADD . /svc

WORKDIR /svc

CMD ./run.sh
