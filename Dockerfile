FROM oven/bun:1.1.20-alpine@sha256:8cab1c94e3371ab2027bd3ffe841527299075fac71d1e9d29e5e06f4c81f5a35 as base
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
HEALTHCHECK --interval=60s --retries=3 --timeout=10s --start-period=60s \
    CMD wget --no-verbose --tries=1 --spider http://127.0.0.1:${NODE_PORT}/health || exit 1

CMD ["bun", "start"]
