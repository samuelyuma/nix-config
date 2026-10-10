# Indonesian

Read when the output is in Indonesian. Goal: a developer reads it once and knows who must do what. Natural and clear matters more than short.

## Eight Rules

1. **Explicit subject.** Write who acts: "Backend menolak request", "Frontend menampilkan notifikasi". Do not write a string of subjectless commands for system behavior.
2. **Consistent modal words.** Use only these meanings:
   - **harus**, **tidak boleh**: required or forbidden. Omitting it breaks something.
   - **sebaiknya**: recommended, with a reason.
   - **bisa**: optional.
   - **perlu**: a prerequisite exists.
3. **Term policy.**
   - Keep in English: field and endpoint names, status values, protocol terms (cursor, header, payload, retry, token, stream), and common developer words (deploy, commit, branch, pull request, endpoint, cache, build, rollback, middleware, query, config).
   - Write in Indonesian: ordinary verbs and nouns (kirim, simpan, tolak, ambil, riwayat pesan, pengguna, halaman, langkah, hasil, urutan).
   - Do not write English word order inside an Indonesian sentence ("Pakai send logic yang sekarang", "Kembalikan sukses").
4. **No noun piles.** At most two nouns in a row. Instead of "safe message mapper yang sudah ada", write "fungsi pemetaan pesan yang aman (sudah ada di `message_public.go`)".
5. **No "yang sekarang" or "sebelumnya" without a name.** Name the thing: "endpoint v1", "handler di `handler.go`", "rencana di `plan-v1.md`". A new reader does not know what "now" means.
6. **Define a term once.** First use gets a short clause: "cursor (penanda posisi halaman)", "idempotent (aman diulang tanpa efek ganda)". After that use the term alone.
7. **Keep connectors.** Karena, supaya, sehingga, lalu, tetapi, jika, setelah. Removing them makes the logic unclear.
8. **One sentence, one idea.** If a sentence has two "yang" clauses or three actions, split it.

## Voice

- Chat: "aku/kamu" only when a pronoun is needed. Avoid forced slang (gue, lo, nih, deh).
- Documents and specs: neutral, no pronouns. Describe behavior with a subject ("Server mengirim..."). Use imperatives only for steps the reader performs ("Jalankan test.").
- Follow an explicit request or author sample, including formal saya/Anda.

## Stiff to Natural

| Stiff | Natural |
|---|---|
| merupakan | adalah |
| dikarenakan | karena |
| apabila | jika, kalau |
| terdapat | ada |
| melakukan pengecekan | memeriksa, cek |
| dapat melakukan | bisa |
| guna, dalam rangka | untuk |
| oleh karena itu | jadi |

Pick by context. Keep established loanwords (server, database, error, browser, email).

## Anti-Slop

Start with the point. Skip "Dalam era digital...", "Tidak dapat dipungkiri...", "Penting untuk dicatat...", "Mari kita selami...". Say the concrete effect instead of "solusi inovatif" or "tonggak penting". Do not end with "Semoga membantu".

## Before and After

Before: "Pakai send logic yang sekarang untuk text dan media."
After: "Endpoint v2 memakai logika pengiriman v1 untuk teks dan media."

Before: "Tolak request kirim yang memakai kedua jenis credential sekaligus."
After: "Backend menolak request yang membawa bearer token dan API key sekaligus."

Before: "Tampung event sementara saat inbox dan history sedang di-load."
After: "Selama inbox dan riwayat pesan dimuat, frontend menyimpan event yang masuk di buffer. Setelah data selesai dimuat, frontend menggabungkan buffer itu dengan datanya."

Before: "Hitung pesan customer berstatus sent atau delivered, termasuk chat yang ditangani AI."
After: "Server menghitung pesan customer yang berstatus `sent` atau `delivered`. Chat yang ditangani AI ikut dihitung."

Before: "Cek akses ke business dan pastikan conversation memang milik business itu."
After: "Server harus memeriksa dua hal di setiap request: pengguna punya akses ke business, dan conversation milik business itu."

## Check Before Sending

- Can I name the actor of every rule?
- Is each rule marked as harus, sebaiknya, or bisa?
- Does any phrase depend on context the reader does not have?
- Is every technical term either standard or defined once?
- Did shortening remove a subject or connector?
