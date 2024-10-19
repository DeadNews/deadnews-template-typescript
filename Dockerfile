FROM oven/bun:1.1.31-alpine@sha256:d460ce709afd575c4920074c3b3bd55787833fdf787984362c846fccbc1b5243 AS base
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
