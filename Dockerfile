# -------------------------
# 1. Builder stage (normal OS)
# -------------------------
FROM python:3.11-slim-bookworm AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt


# -------------------------
# 2. Runtime stage (distroless)
# -------------------------
FROM gcr.io/distroless/python3-debian12

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.11 /usr/local/lib/python3.11
COPY --from=builder /usr/local/bin /usr/local/bin
COPY . .

CMD ["app.py"]
