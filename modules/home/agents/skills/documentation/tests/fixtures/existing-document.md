# Existing Document Fixture

## README.md

```markdown
# Paket

Paket membantu tim memeriksa berkas sebelum dikirim.

## Penggunaan

Jalankan `python3 tools/paket.py inspect input.txt` dari root proyek. Berkas masukan harus UTF-8. Perintah hanya membaca berkas, tanpa mengubahnya.

Catatan tim: pertahankan salinan lokal sampai penerima mengonfirmasi berkas sudah diterima. Ini prosedur operasional kami, bukan fitur aplikasi.

## Pemeriksaan

Jalankan `python3 tools/paket.py test` sebelum membuat perubahan.

## Referensi

Lihat [Kontrak Format](docs/format.md) untuk batasan masukan.
```

## Supplied Project Facts

- `tools/paket.py` supports `inspect <path>` and `check`, not `test`.
- `inspect` reads UTF-8 without writing the input. `check` runs the local checks.
- `docs/format.md` exists and says the input must be UTF-8.
- The user asks only to correct the documented checks, in English. No translation or restructuring was requested.
