FROM oven/bun:1.1.43-alpine@sha256:92a7a5ec007152b8669d83f42a9351a678a48534ee047ea7ac479262376886ad AS base
LABEL maintainer="DeadNews <deadnewsgit@gmail.com>"

WORKDIR /app

FROM base as runtime

ENV NODE_PORT=8000 \
    NODE_HOSTNAME=0.0.0.0 \
    NODE_ENV=production

COPY package.json bun.lockb ./
COPY src/ ./src/
RUN bun install --production --frozen-lockfile

USER bun:bun
EXPOSE ${NODE_PORT}
HEALTHCHECK NONE

CMD ["bun", "start"]
