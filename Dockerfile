FROM oven/bun:1.0.4-alpine@sha256:07343bd778e11bad4c6b434737e4cafc843cefcf69523b3868c4443e564f38b9 as base
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
