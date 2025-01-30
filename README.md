# Parkee Technical Test

## Linux

### 1. Pencarian File Berdasarkan Ekstensi file (MANAGEMENT FILE)
Buatlah sebuah shell script yang menerima dua parameter: direktori dan ekstensi file. Script ini harus mencari semua file dengan ekstensi yang diberikan di dalam direktori tersebut dan menampilkan daftar nama file yang ditemukan.

```bash
#!/bin/bash
if [ "$#" -ne 2 ]; then
 echo "gunakan parameter: $0 <direktori> <ekstensi>"
 exit 1
fi
direktori=$1
ekstensi=$2
if [ ! -d "$direktori" ]; then
 echo "Error: Direktori '$direktori' tidak ditemukan."
 exit 1
fi
find "$direktori" -type f -name "*.$ekstensi"
```

### 2. Backup dan Kompresi File (MANAGEMENT FILE)
Buatlah sebuah shell script yang akan mem-backup sebuah direktori tertentu dan mengompres hasil backup tersebut dengan format .tar.gz. Script harus memiliki parameter input untuk menentukan direktori sumber dan lokasi penyimpanan hasil backup.

```bash
#!/bin/bash
if [ "$#" -ne 2 ]; then
 echo "gunakan parameter: $0 <direktori> <lokasi_backup>"
 exit 1
fi
source_dir=$1
backup_dir=$2
timestamp=$(date +%Y%m%d%H%M%S)
file_backup="$backup_dir/backup_$timestamp.tar.gz"
tar -czf "$file_backup" -C "$source_dir" .
echo "file backup tersimpan di $file_backup"
```

### 3. Menghitung dan Menampilkan Statistik File (MANAGEMENT FILE)
Buatlah sebuah shell script yang akan menghitung dan menampilkan jumlah baris, kata dan karakter dari semua file teks dalam sebuah direktori tertentu. Hasilnya harus ditampilkan dalam format tabel.

```bash
#!/bin/bash
if [ "$#" -ne 1 ]; then
 echo "gunakan parameter: $0 <direktori>"
 exit 1
fi
direktori=$1
echo -e "File\tBaris\tKata\tKarakter"
for file in "$direktori"/*.txt; do
 [ -e "$file" ] || continue
 stats=$(wc "$file")
 echo -e "$(basename "$file")\t$stats"
done
```

### 4. Backup Direktori dan Rotasi Log (MANAGEMENT FILE)
Buatlah sebuah shell script yang akan melakukan backup sebuah direktori tertentu dan menghapus backup yang lebih lama dari 7 hari. Script harus memiliki parameter untuk menentukan direktori sumber dan direktori tujuan backup.

```bash
#!/bin/bash
if [ "$#" -ne 2 ]; then
 echo "Usage: $0 <source_directory> <backup_directory>"
 exit 1
fi
SOURCE_DIR=$1
BACKUP_DIR=$2
TIMESTAMP=$(date +%Y%m%d)
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
tar -czf "$BACKUP_FILE" -C "$SOURCE_DIR" .
find "$BACKUP_DIR" -name "backup_*.tar.gz" -mtime +7 -exec rm {} \;
echo "Backup completed and old backups removed."
```

### 5. Automasi Pembaharuan Sistem (BASIC SYSTEM)
Buatlah sebuah shell script yang akan secara otomatis memperbaharui semua package di sistem menggunakan package manager yang sesuai dengan family linux (misal ‘apt’, ‘yum’ atau sebagainya). Script harus juga mencatat hasil dari setiap pembaruan kedalam sebuah file log.

```bash
#!/bin/bash
LOG_FILE="/var/log/system_update.log"
if command -v apt &>/dev/null; then
 sudo apt update && sudo apt upgrade -y | tee -a "$LOG_FILE"
elif command -v yum &>/dev/null; then
 sudo yum update -y | tee -a "$LOG_FILE"
else
 echo "Unsupported package manager" | tee -a "$LOG_FILE"
fi
```

### 6. Membuat dan Menyimpan SSH Key (SSH)
Buatlah sebuah shell script yang akan membuat sepasang SSH Key (public dan private) dengan menggunakan ssh-keygen dan menyimpannya di direktori yang ditentukan oleh pengguna sebagai parameter. Jika direktori tidak ada, script harus membuatnya terlebih dahulu.

```bash
#!/bin/bash
if [ "$#" -ne 1 ]; then
 echo "gunakan parameter: $0 <direktori>"
 exit 1
fi
dir=$1
mkdir -p "$dir"
ssh-keygen -t rsa -b 2048 -f "$dir/id_rsa" -N ""
echo "SSH key tersimpan di $dir"
```

### 7. Mengcopy public key ke server remote (SSH)
Buatlah sebuah shell script yang menerima tiga parameter: file public key, username, dan ip address server. Script ini harus menyalin public key ke server remote untuk memungkinkan user lain untuk melakukan ssh tanpa password.

```bash
#!/bin/bash
if [ "$#" -ne 3 ]; then
 echo "gunakan parameter: $0 <public_key> <username> <server_ip>"
 exit 1
fi
scp "$1" "$2@$3:~/.ssh/authorized_keys"
```

### 8. Mengecheck Koneksi SSH ke Server Remote (SSH)
Buatlah sebuah shell script yang menerima dua parameter: username dan ip address server. Script ini harus mencoba melakukan koneksi SSH ke server remote dan print message yang menunjukan apakah koneksi berhasil atau gagal.

```bash
#!/bin/bash
if [ "$#" -ne 2 ]; then
 echo "gunakan parameter: $0 <username> <server_ip>"
 exit 1
fi
ssh -o BatchMode=yes -o ConnectTimeout=5 "$1@$2" exit
if [ "$?" -eq 0 ]; then
 echo "koneksi SSH berhasil"
else
 echo "koneksi SSH gagal"
fi
```

### 9. Membuat Script untuk Menambahkan SSH Key ke ‘authorized_keys’ (SSH)
Buatlah sebuah shell script yang menerima dua parameter: file key public dan username. Script ini harus menambahkan public key ke file ‘~/.ssh/authorized_keys’ dari user yang bersangkutan di server local.

```bash
#!/bin/bash
if [ "$#" -ne 2 ]; then
 echo "gunakan parameter: $0 <public_key> <username>"
 exit 1
fi
cat "$1" >> "/home/$2/.ssh/authorized_keys"
```

### 10. Menghapus SSH Key dari ‘authorized_keys’ (SSH)
Buatlah sebuah shell script yang menerima dua parameter: string yang unique dari key public dan username. Script ini harus menghapus public key yang mengandung string unique tersebut dari file ‘~/.ssh/authorized_keys’ dari user yang bersangkutan.

```bash
#!/bin/bash
if [ "$#" -ne 2 ]; then
 echo "gunakan parameter: $0 <public-key> <username>"
 exit 1
fi
sed -i "/$1/d" "/home/$2/.ssh/authorized_keys"
```

### 11. Pengelolaan Service (SERVICE)
Buatlah sebuah shell script yang dapat memulai, menghentikan, dan memeriksa status dari sebuah service tertentu di sistem. Script harus memiliki parameter untuk menentukan tindakan yang diinginkan (start, stop, status) dan nama service.

```bash
#!/bin/bash
if [ "$#" -ne 2 ]; then
 echo "parameter: $0 <start|stop|status> <nama-service>"
 exit 1
fi
action=$1
SERVICE=$2
case $action in
 start)
 sudo systemctl start "$SERVICE"
 echo "$SERVICE dijalankan."
 ;;
 stop)
 sudo systemctl stop "$SERVICE"
 echo "$SERVICE dihentikan."
 ;;
 status)
 sudo systemctl status "$SERVICE"
 ;;
 *)
 echo "Invalid."
 exit 1
 ;;
esac
```

### 12. Men-copy Direktori ke Server Remote (SCP)
Buatlah sebuah 2 shell script (scp, dan rsync) yang menerima tiga parameter: file source, username, dan ip address server tujuan. Script ini harus menyalin file tersebut ke direktori home pengguna di server remote menggunakan ‘scp’ dan ‘rsync’.

- scp

```bash
#!/bin/bash
if [ "$#" -ne 3 ]; then
 echo "parameter: $0 <direktori> <username> <server_ip>"
 exit 1
fi
scp -r "$1" "$2@$3:~/"
```

- rsync

```bash
#!/bin/bash
if [ "$#" -ne 3 ]; then
 echo "parameter: $0 <direktori> <username> <server_ip>"
 exit 1
fi
rsync -avz "$1" "$2@$3:~/"
```

### 13. Membuat Unit File Systemd untuk Service Sederhana (SERVICE)
Buatlah sebuah shell script yang membuat sebuah file systemd untuk menjalankan script python sederhana. File ini harus ditempatkan di folder `/etc/systemd/system/`. Script python harus dijalankan sebagai service yang dapat dijalankan, dihentikan dan di cek status service tersebut menggunakan systemctl.

```bash
#!/bin/bash

SERVICE_FILE="/etc/systemd/system/simple_python.service"

echo "[Unit]
Description=Simple Python Service
After=network.target

[Service]
ExecStart=/usr/bin/python3 /opt/simple_script.py
Restart=always
User=root

[Install]
WantedBy=multi-user.target" | sudo tee "$SERVICE_FILE"

sudo systemctl daemon-reload
sudo systemctl enable simple_python
sudo systemctl start simple_python
```

### 14. Memonitoring Penggunaan CPU (MONITORING)
Buatlah sebuah shell script yang akan memonitor penggunaan CPU pada sistem. Jika penggunaan CPU rata-rata dalam 1 menit diatas 75%, script harus mencatat informasi tersebut ke dalam sebuah log file.

```bash
#!/bin/bash
LOG_FILE="cpu_monitor.log"
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
if (( $(echo "$CPU_USAGE > 75" | bc -l) )); then
 echo "$(date) - Penggunaan CPU tinggi: $CPU_USAGE%" >> "$LOG_FILE"
fi
```

### 15. Monitoring Penggunaan Disk (MONITORING)
Buatlah sebuah shell script yang akan memonitor penggunaan disk pada sistem. Jika penggunaan disk diatas 80%, script harus mengirimkan notifikasi melalui suatu service lain (bebas menggunakan tools apapun untuk notifikasinya).

```bash
#!/bin/bash
THRESHOLD=80
USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
#contoh notifikasi menggunakan wall
if [ "$USAGE" -gt "$THRESHOLD" ]; then
 echo "Warning: Penggunaan disk diatas $THRESHOLD% ($USAGE%)" | wall
fi
```

### 16. Menampilan Informasi Sistem (MONITORING)
Buatlah sebuah shell script yang menampilkan informasi sistem dasar, termasuk nama host, waktu sistem saat ini, dan jumlah pengguna yang sedang login.

```bash
#!/bin/bash
echo "Hostname: $(hostname)"
echo "Tanggal: $(date)"
echo "Jumlah user yang sedang login: $(who | wc -l)"
```

### 17. Pengaturan Firewall dengan `iptables` (NETWORK)
Buatlah sebuah shell script yang mengkonfigurasi aturan firewall menggunakan ‘iptables’, ikuti persyaratan aturan dibawah ini:
1. Mengizinkan semua koneksi keluar.
2. Mengizinkan koneksi masuk ke port 22 (SSH), 80 (HTTP), dan 443 (HTTPS).
3. Menolak semua koneksi masuk lainnya.

```bash
#!/bin/bash
iptables -F
iptables -A OUTPUT -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -j DROP
iptables-save > /etc/iptables.rules
```

### 18. Konfigurasi Jaringan dengan ‘netplan’ (NETWORK)
Buatlah sebuah shell script yang mengkonfigurasi jaringan menggunakan ‘netplan’. Script ini harus mengatur ip address pada interface network ‘eth0’ dengan detail berikut:
1. IP Address : 192.168.1.100
2. Gateway: 192.168.1.1
3. DNS: 8.8.8.8 dan 8.8.4.4

```bash
#!/bin/bash
NETPLAN_FILE="/etc/netplan/01-netcfg.yaml"
echo "network:
 version: 2
 ethernets:
 eth0:
 dhcp4: no
 addresses: [192.168.1.100/24]
 gateway4: 192.168.1.1
 nameservers:
 addresses: [8.8.8.8, 8.8.4.4]" | sudo tee "$NETPLAN_FILE"
sudo netplan apply
```

## Scripting Data

Gunakanlah Python dan pandas untuk menyelesaikan soal dibawah, termasuk penggabungan beberapa file dan pembersihan data untuk memudahkan analisis.

### Soal Scripting dengan Python Pandas

Pertanyaan:
Anda diberikan beberapa file CSV yang berisi data transaksi dari berbagai cabang sebuah toko. Setiap file berisi kolom berikut:
- transaction_id
- branch
- date
- product_id
- quantity
- price
- customer_id

Beberapa tugas yang perlu Anda lakukan adalah:
1. Gabungkan semua file CSV menjadi satu DataFrame.
2. Bersihkan data dengan cara berikut:
    - Hapus baris yang memiliki nilai NaN pada kolom transaction_id, date, dan customer_id.
    - Ubah format kolom date menjadi tipe datetime.
    - Hilangkan duplikat berdasarkan transaction_id, pilih data berdasarkan date terbaru.
3. Setelah data duplikat dihilangkan, hitung total penjualan per cabang dan simpan hasilnya ke file baru total_sales_per_branch.csv dengan kolom branch dan total.

Berikut adalah file CSV yang perlu Anda gabungkan: branch_a.csv, branch_b.csv, branch_c.csv.

```python
import pandas as pd
from glob import glob

# Load all CSV files
files = ["branch_a.csv", "branch_b.csv", "branch_c.csv"]
df = pd.concat([pd.read_csv(f) for f in files])

# Clean Data
df.dropna(subset=['transaction_id', 'date', 'customer_id'], inplace=True)
df['date'] = pd.to_datetime(df['date'])
df.sort_values(by=['transaction_id', 'date'], ascending=[True, False], inplace=True)
df.drop_duplicates(subset='transaction_id', keep='first', inplace=True)

# Calculate total sales per branch
df['total'] = df['quantity'] * df['price']
sales_per_branch = df.groupby('branch')['total'].sum().reset_index()

# Save to CSV
sales_per_branch.to_csv('total_sales_per_branch.csv', index=False)
```

## API

### 1. Buatlah Table dengan kolom
- “Name”
- “Web pages”
- “Country”
- “Domains”
- “State Province”

Dari api berikut:
```bash
curl --location 'http://universities.hipolabs.com/search?country=United%2BStates'
```

- Buatlah scripting tersebut menggunakan python dengan library pandas.
- Buatlah parameter pencarian menggunakan python dengan kata kunci untuk memfilter “country”.
- Buatlah scripting untuk filtering data yang tidak memiliki data “state-province”.

```python
import requests
import pandas as pd

def fetch_universities(country):
 url = f"http://universities.hipolabs.com/search?country={country.replace(' ', '%20')}"
 response = requests.get(url)
 data = response.json()
 df = pd.DataFrame(data)
 df = df[['name', 'web_pages', 'country', 'domains', 'state-province']]
 df = df[df['state-province'].notna()]
 return df

# Example usage
df = fetch_universities("United States")
df.to_csv("universities.csv", index=False)
```
