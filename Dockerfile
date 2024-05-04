FROM oven/bun:1.1.7-alpine@sha256:2079a46121650eeec498e8d952dd3a70b7fd63a634092ccba918dabac8f0965e as base
LABEL maintainer "DeadNews <deadnewsgit@gmail.com>"

WORKDIR /app

FROM base as runtime

ENV NODE_PORT=3000 \
    NODE_HOSTNAME=0.0.0.0 \
    NODE_ENV=production

COPY package.json bun.lockb ./
COPY src/ ./src/
RUN bun install --production --frozen-lockfile

USER bun:bun
EXPOSE ${NODE_PORT}
HEALTHCHECK --interval=60s --timeout=3s \
    CMD wget --no-verbose --tries=1 --spider http://127.0.0.1:${NODE_PORT}/health || exit 1

CMD ["bun", "start"]
