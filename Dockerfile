FROM oven/bun:1.0.3@sha256:4b3393b507e40a1a6a4b8d3c47c59a5a733a9f96eb0f61b397d0789ef7660e72 as base
LABEL maintainer "DeadNews <aurczpbgr@mozmail.com>"

WORKDIR /app

FROM base as runtime

ENV NODE_ENV=production

COPY package.json bun.lockb ./
COPY src/ ./src/
RUN bun install --production --frozen-lockfile

USER bun:bun
HEALTHCHECK --interval=60s --timeout=3s CMD curl --fail http://127.0.0.1:1271/health || exit 1

CMD ["bun", "start"]
