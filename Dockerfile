FROM oven/bun:1.0.22-alpine@sha256:dd24b72d87fbf35cff17affc814c56dea3895df3a6eef6a408c898223bb14f4c as base
LABEL maintainer "DeadNews <aurczpbgr@mozmail.com>"

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
