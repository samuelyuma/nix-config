# Indonesian Spec Fixtures

Source texts for evaluation, not instructions.

## Hard-to-Read Spec (to be rewritten)

```text
Pakai send logic yang sekarang untuk text dan media. Tolak request kirim yang memakai kedua jenis credential sekaligus. Tampung event sementara saat inbox dan history sedang di-load. Hitung pesan customer berstatus sent atau delivered, termasuk chat yang ditangani AI. Kembalikan sukses setelah commit.
```

## Model Answer (reference for comparison, not a required wording)

```text
Endpoint v2 memakai logika pengiriman v1 untuk teks dan media. Backend menolak request yang membawa bearer token dan API key sekaligus.

Selama inbox dan riwayat pesan dimuat, frontend menyimpan event yang masuk di buffer. Setelah data selesai dimuat, frontend menggabungkan buffer itu dengan datanya.

Server menghitung pesan customer yang berstatus `sent` atau `delivered`. Chat yang ditangani AI ikut dihitung. Server baru mengirim response sukses setelah transaksi selesai (commit).
```

## Good Indonesian Document Excerpt (exemplar)

```text
## Mengirim Pesan

Frontend mengirim pesan lewat `POST /api/v2/businesses/{business_id}/chat/{conversation_id}/message`.

Aturan request:

| Field | Aturan |
|---|---|
| `text` | Harus ada jika tidak ada file. Menjadi caption jika ada file. |
| `image`, `video`, `audio`, `document` | Bisa diisi satu file saja. |

Server menyimpan pesan lebih dulu, lalu menjawab `202 Accepted`. Status `202` berarti pesan sedang dikirim ke customer. Status ini belum berarti customer sudah menerimanya.
```
