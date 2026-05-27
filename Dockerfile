FROM python:3.11-slim

WORKDIR /app

# 1. System security patching (IMPORTANT)
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    libncursesw6 libtinfo6 ncurses-base ncurses-bin && \
    rm -rf /var/lib/apt/lists/*

# 2. Upgrade pip tooling FIRST (important for CVEs like wheel)
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# 3. Copy dependencies first (better caching)
COPY requirements.txt .

# 4. Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 5. Force fix known vulnerable python build deps
RUN pip install --no-cache-dir --upgrade wheel jaraco.context

# 6. Copy application
COPY . .

# 7. Runtime config
ENV PYTHONPATH=/app

EXPOSE 5000

CMD ["python", "app/main.py"]
