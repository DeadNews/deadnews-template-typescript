FROM oven/bun:1.1.34-alpine@sha256:490d28250f51bf30fd88c3277f43c2c2bd721599d9ae373458c487d27bcb10f3 AS base
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
