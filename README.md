# Tutorial Instalasi Navbar di Tema Argon untuk OpenWRT/LuCI

## 📱 Deskripsi
Script ini akan menambahkan navbar mobile modern di bagian bawah halaman web OpenWRT/LuCI dengan fitur:
- ✅ Navbar otomatis muncul/hilang saat scroll
- 📱 Desain responsif untuk perangkat mobile
- 🖼️ Ikon SVG untuk setiap menu
- 🎨 CSS terpisah yang mudah dikustomisasi
- ⚡ Performa ringan

## 📋 Prasyarat
- OpenWRT/LEDE dengan tema Argon terinstal
- Akses SSH ke router
- Koneksi internet aktif (untuk mengunduh script)

## 🚀 Cara Instalasi

### 1. Login ke Router via SSH
```bash
ssh root@alamat.ip.router
```

### 2. Unduh Script Instalasi
```bash
wget https://raw.githubusercontent.com/ajisetiawan716/navbar-argon/main/install-navbar.sh -O /tmp/install-navbar.sh && chmod +x /tmp/install-navbar.sh && sh /tmp/install-navbar.sh
```

### 5. Verifikasi Instalasi
Setelah instalasi selesai:
1. Buka antarmuka LuCI di browser
2. Scroll halaman untuk melihat navbar muncul di bagian bawah
3. Klik menu untuk navigasi cepat

## 🛠️ Konfigurasi Lanjutan
Untuk memodifikasi navbar, edit file berikut:

1. **Tambah/Edit Menu**:
   ```bash
   nano /usr/lib/lua/luci/view/themes/argon/navbar.htm
   ```

2. **Ubah Tampilan CSS**:
   ```bash
   nano /www/luci-static/argon/css/nav.css
   ```

3. **Perilaku Scroll**:
   ```bash
   nano /usr/lib/lua/luci/view/themes/argon/footer.htm
   ```

## ❌ Cara Uninstall
Untuk menghapus navbar:
```bash
rm -f /usr/lib/lua/luci/view/themes/argon/navbar.htm
rm -f /www/luci-static/argon/css/nav.css
sed -i '/nav.css/d' /usr/lib/lua/luci/view/themes/argon/header.htm
sed -i '/navbar/d' /usr/lib/lua/luci/view/themes/argon/header.htm
sed -i '/prevScrollpos/,/<\/script>/d' /usr/lib/lua/luci/view/themes/argon/footer.htm
```

## 🐛 Troubleshooting
Jika mengalami masalah:
1. **Navbar tidak muncul**:
   - Pastikan tema Argon aktif
   - Cek error di browser console (F12)

2. **Tampilan rusak**:
   ```bash
   rm /www/luci-static/argon/css/nav.css
   /tmp/install-navbar.sh
   ```

3. **Script error**:
   ```bash
   wget -O /tmp/install-navbar.sh https://raw.githubusercontent.com/username-repo/main/install-navbar.sh
   chmod +x /tmp/install-navbar.sh
   /tmp/install-navbar.sh
   ```

## 💡 Tips
- Gunakan koneksi stabil saat instalasi
- Backup konfigurasi sebelum modifikasi
- Restart browser setelah instalasi

---

Dibuat dengan ❤️ untuk komunitas OpenWRT Indonesia  
[Laporkan Issue](https://github.com/ajisetiawan716/navbar-argon/issues) | [Lihat Kode Sumber](https://github.com/username-repo)
