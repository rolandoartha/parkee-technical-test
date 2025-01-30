# Junior DevOps Technical Test PARKEE

## TYPE TASK

### 1. Linux

#### 1.1 Pencarian File Berdasarkan Ekstensi File (MANAGEMENT FILE)
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
