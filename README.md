# 📊 Vulnerability Report Viewer (Laravel + Docker)

Laravel project untuk membaca laporan JSON (dashboard interaktif) dan export PDF dengan **spatie/laravel-pdf**.
Dijalankan sepenuhnya di Docker (PHP-FPM + Nginx + Chromium).

## 🚀 Cara Jalankan
```bash
docker compose up -d --build
```

Akses di browser: `http://localhost:8000/report`

## 📦 Service
- **app** → PHP 8.2 FPM + Composer + Node + Chromium
- **nginx** → Nginx reverse proxy

## 👨‍💻 Pengembangan
- Controller: `ReportController`, `ExportController`
- Views: `report.blade.php`, `report_pdf.blade.php`
- Asset: `public/css/style.css`, `public/js/dashboard.js`
