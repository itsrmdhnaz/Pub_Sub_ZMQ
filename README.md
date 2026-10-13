# Tugas 4 - ZeroMQ Publish-Subscribe
Nama : Ramadhan Abdul Aziz
NIM  : 103012580007

# detail di make help 
```bash
make help
```

## 1. Menjalankan via Docker

### Menjalankan Service
```bash
make up 
# atau: docker compose up -d --build
```

### Melihat Log
```bash
# Log seluruh service
make logs

# Log publisher saja
make logs-pub

# Log ketiga subscriber bersamaan
make logs-sub

# Log spesifik per subscriber
make logs-sub-service SUBSCRIBER=sub-alif
make logs-sub-service SUBSCRIBER=sub-brindawan
make logs-sub-service SUBSCRIBER=sub-wisnu

## 2. Menjalankan via Anaconda / Lokal

### Setup Environment
```bash
# 1. Buat environment conda
make conda-create
# atau: conda env create -f environment.yml

# 2. Aktifkan environment
conda activate tugas4-pub-sub
```

