# Indonesian

Read when writing in Indonesian. Use everyday language a developer would use with a teammate: natural, neither stiff nor forced slang.

## Language and Terms

Follow the current request's language. A later English message gets an English response unless the user explicitly sets a continuing language preference. For editing, retain the source language unless translation is requested. English technical terms do not make an Indonesian answer English.

Keep established terms such as deploy, commit, pull request, branch, endpoint, query, middleware, cache, build, rollback, server, database, error, test, config, pipeline, and API. Keep commands, identifiers, paths, logs, and product names exact.

Prefer server, database, error, browser, email, and device over stiff replacements such as peladen, pangkalan data, galat, peramban, surel, and gawai. Normal Indonesian words such as pengguna, fungsi, halaman, tabel, langkah, and hasil remain natural. Do not translate every noun into English.

## Tone

- In chat, use aku/kamu when pronouns are needed. Avoid unnecessary pronouns.
- In documents, use neutral or imperative wording: "Jalankan test." Use kita only for genuinely shared steps.
- Follow an explicit voice request or separately supplied author sample, including formal saya/Anda when requested. An Anda in text being humanized is not itself a request for formal voice; use neutral wording when no intentional personal voice is evident.
- Avoid forced gue/lo, nih/deh, and artificial friendliness. Natural words such as kalau, karena, supaya, dulu, lalu, bisa, coba, and sekarang are welcome.

Use perlu for requirements, bisa for options, and coba for suggestions. Do not soften a required step into an optional one. Use wajib or harus when omission would break the process, and state the consequence.

## Plain Wording

| Stiff | Natural |
|---|---|
| merupakan | adalah |
| dikarenakan | karena |
| apabila | kalau, jika |
| terdapat | ada |
| melakukan pengecekan | cek, mengecek |
| melakukan pembuatan | membuat |
| dapat melakukan | bisa |
| guna, dalam rangka | untuk |
| oleh karena itu | jadi |

Choose replacements by context. Split long chains of yang and noun-heavy phrases rather than imposing a word count.

## Anti-Slop

Start with the point instead of "Dalam era digital...", "Tidak dapat dipungkiri...", "Penting untuk dicatat...", or "Mari kita selami...". State concrete effects instead of tonggak penting, solusi inovatif, or a forced "tidak hanya X, tetapi juga Y". Finish without "Semoga membantu" or a repeating kesimpulan.

Before: "Anda harus melakukan instalasi dependensi terlebih dahulu dengan menjalankan perintah berikut."

After: "Install dependency dulu:"

Before: "Caching memainkan peran yang sangat krusial dalam meningkatkan performa."

After: "Caching bisa meningkatkan performa."

The second rewrite adds no measured gain or mechanism. Use `references/anti-slop.md` from the skill root for detailed cleanup patterns.
