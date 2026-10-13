FROM python:3.12-slim

WORKDIR /app
ENV PYTHONUNBUFFERED=1

# 1. Salin file requirements.txt
COPY requirements.txt .

# 2. Install dependencies berdasarkan requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# 3. Salin seluruh source code ke dalam container
COPY . .

# Default command
CMD ["python", "publisher.py"]
