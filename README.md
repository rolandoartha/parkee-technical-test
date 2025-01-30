# Junior DevOps Technical Test PARKEE

## TYPE TASK

### A. Linux

#### 1 Pencarian File Berdasarkan Ekstensi File (MANAGEMENT FILE)
**Tugas**: Buat shell script untuk mencari file berdasarkan ekstensi di direktori tertentu.  
**Jawab**:
```bash
#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "gunakan parameter: $0 <directori> <ekstensi>"
  exit 1
fi

direktori=$1
ekstensi=$2

if [ ! -d "$direktori" ]; then
  echo "Error: Direketori '$direktori' tidak ditemukan."
  exit 1
fi

find "$direktori" -type f -name "*.$ekstensi"
```

#### 2. Backup dan Kompresi File (MANAGEMENT FILE) 
**Tugas**: Buatlah sebuah shell script yang akan mem-backup sebuah direktori tertentu dan mengompres hasil backup tersebut dengan format .tar.gz. Script harus memiliki parameter input untuk menentukan direktori sumber dan lokasi penyimpanan hasil backup. 
**Jawab**:
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
echo "file beckup tersimpan di $file_backup"
```
