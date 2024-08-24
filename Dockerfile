FROM oven/bun:1.1.25-alpine@sha256:2d9027f7dd57d5343d787eae23d5bfa80cc8480154893e156d39ccc86df05cb4 AS base
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
