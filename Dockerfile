FROM oven/bun:1.1.21-alpine@sha256:1c5c688753290535a4e58c09f4291b97be65020627b662caf304a67f43253bad AS base
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
