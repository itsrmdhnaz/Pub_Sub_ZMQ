# ==============================================================================
# Makefile - Tugas 4 ZeroMQ Publish-Subscribe
# ==============================================================================

.PHONY: help build run up down reset reset-sub reset-pub logs logs-pub logs-sub \
        logs-alif logs-brindawan logs-wisnu stats restart clean \
        conda-create conda-reset conda-update \
        local-pub local-sub-alif local-sub-brindawan local-sub-wisnu zip

# Menu Bantuan / Daftar Perintah
help:
	@echo "=============================================================================="
	@echo "                      DAFTAR PERINTAH MAKEFILE TUGAS 4                        "
	@echo "=============================================================================="
	@echo " --- DOCKER COMMANDS ---"
	@echo "  make run             : Build dan jalankan seluruh container (live logs gabungan)"
	@echo "  make up              : Jalankan seluruh container di background"
	@echo "  make down            : Matikan dan hapus seluruh container"
	@echo "  make reset           : Bersihkan seluruh log dan nyalakan ulang container baru"
	@echo "  make reset-sub       : Bersihkan log Subscriber saja (Publisher tetap aktif)"
	@echo "  make reset-pub       : Bersihkan log Publisher saja (Subscriber tetap aktif)"
	@echo "  make build           : Build Docker Image untuk publisher dan subscribers"
	@echo "  make logs            : Tampilkan live log semua container"
	@echo "  make logs-pub        : Tampilkan live log Publisher saja"
	@echo "  make logs-sub        : Tampilkan live log ketiga Subscriber sekaligus"
	@echo "  make logs-sub-service : Tampilkan live log subscriber service tertentu"
	@echo "     make logs-sub-service SUBSCRIBER=sub-alif"
	@echo "     make logs-sub-service SUBSCRIBER=sub-brindawan"
	@echo "     make logs-sub-service SUBSCRIBER=sub-wisnu"
	@echo "  make logs-alif       : Tampilkan live log Subscriber Alif saja"
	@echo "  make logs-brindawan  : Tampilkan live log Subscriber Brindawan saja"
	@echo "  make logs-wisnu      : Tampilkan live log Subscriber Wisnu saja"
	@echo "  make stats           : Live watch dashboard CPU, RAM, & Network I/O"
	@echo ""
	@echo " --- ANACONDA / CONDA ENVIRONMENT ---"
	@echo "  make conda-create    : Buat conda environment 'tugas4-pub-sub' dari environment.yml"
	@echo "  make conda-reset     : Hapus dan buat ulang conda env dari nol"
	@echo "  make conda-update    : Update package conda env sesuai environment.yml"
	@echo "  make conda-active    : Aktifkan conda env 'tugas4-pub-sub'"
	@echo ""
	@echo " --- LOCAL PYTHON (Tanpa Docker) ---"
	@echo "  make local-pub           : Jalankan publisher lokal"
	@echo "  make local-sub-alif      : Jalankan subscriber Alif lokal"
	@echo "  make local-sub-brindawan : Jalankan subscriber Brindawan lokal"
	@echo "  make local-sub-wisnu     : Jalankan subscriber Wisnu lokal"
	@echo "=============================================================================="

# ------------------------------------------------------------------------------
# DOCKER ORCHESTRATION
# ------------------------------------------------------------------------------

build:
	docker compose build

run:
	docker compose up --build

up:
	docker compose up -d --build

down:
	docker compose down

reset:
	docker compose down
	docker compose up -d --build
	@echo "[OK] Seluruh log container berhasil di-reset bersih!"

reset-sub:
	docker compose up -d --force-recreate sub-alif sub-brindawan sub-wisnu
	@echo "[OK] Log seluruh subscriber berhasil dibersihkan (Publisher tetap aktif)!"

reset-pub:
	docker compose up -d --force-recreate publisher
	@echo "[OK] Log publisher berhasil dibersihkan (Subscribers tetap aktif)!"

logs:
	docker compose logs -f

logs-pub:
	docker compose logs -f publisher

logs-sub:
	docker compose logs -f sub-alif sub-brindawan sub-wisnu

logs-sub-service:
	docker compose logs -f $(SUBSCRIBER)

logs-alif:
	docker compose logs -f sub-alif

logs-brindawan:
	docker compose logs -f sub-brindawan

logs-wisnu:
	docker compose logs -f sub-wisnu

stats:
	docker stats

restart:
	docker compose restart

clean:
	docker compose down --rmi local -v

# ------------------------------------------------------------------------------
# ANACONDA / CONDA ENVIRONMENT
# ------------------------------------------------------------------------------

conda-create:
	conda env create -f environment.yml
	@echo "[OK] Conda environment 'tugas4-pub-sub' berhasil dibuat!"

conda-reset:
	conda env remove -n tugas4-pub-sub -y
	conda env create -f environment.yml
	@echo "[OK] Conda environment 'tugas4-pub-sub' berhasil di-reset ulang dari nol!"

conda-update:
	conda env update -f environment.yml --prune
	@echo "[OK] Conda environment 'tugas4-pub-sub' berhasil diperbarui!"

conda-active:
	conda activate tugas4-pub-sub
	@echo "[OK] Conda environment 'tugas4-pub-sub' berhasil diaktifkan!"

# ------------------------------------------------------------------------------
# LOCAL RUN
# ------------------------------------------------------------------------------

local-pub:
	python publisher.py

local-sub-alif:
	python subscriber.py 103012580030-AMA 103012580030 localhost 9991

local-sub-brindawan:
	python subscriber.py 103012580016-BTY 103012580016 localhost 9991

local-sub-wisnu:
	python subscriber.py 103012580010-WKH 103012580010 localhost 9991