FROM oven/bun:1.0.18-alpine@sha256:f5067895ea6e81362fbcf8481d9f8f2cab5ca1fd2c4924eec5ecc75a1efda89b as base
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
