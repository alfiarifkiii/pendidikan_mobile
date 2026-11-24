import 'package:flutter/material.dart';

import '../models/materi_model.dart';

const List<Materi> daftarMateri = [
  // 1. MATEMATIKA (6 Sub-Materi)
  Materi(
    judul: 'Matematika',
    deskripsi: 'Konsep berhitung dasar, bangun ruang, pecahan, dan pengukuran.',
    icon: Icons.calculate_rounded,
    warna: Colors.orange,
    poin: [
      SubMateri(
        judulRingkas: 'Bilangan bulat dan operasi penjumlahan, pengurangan, perkalian, pembagian.',
        penjelasanLengkap: 'Bilangan bulat terdiri dari bilangan bulat negatif, nol, dan bilangan bulat positif. Operasi hitung dasar meliputi penjumlahan, pengurangan, perkalian, dan pembagian yang mengikuti aturan urutan pengerjaan (tanda kurung, perkalian/pembagian, lalu penjumlahan/pengurangan).',
        contoh: 'Contoh: 15 + (4 × 3) - 7 = 15 + 12 - 7 = 20.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=operasi+hitung+bilangan+bulat+sd',
      ),
      SubMateri(
        judulRingkas: 'Pecahan sederhana dan perbandingannya.',
        penjelasanLengkap: 'Pecahan menyatakan bagian dari keseluruhan yang ditulis dalam bentuk a/b, di mana a adalah pembilang dan b adalah penyebut (b ≠ 0). Untuk membandingkan dua pecahan, samakan penyebutnya terlebih dahulu.',
        contoh: 'Contoh: 1/2 lebih besar dari 1/4 karena 1/2 = 2/4.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=mengenal+pecahan+sederhana+sd',
      ),
      SubMateri(
        judulRingkas:
            'Bangun datar: persegi, persegi panjang, segitiga, dan lingkaran.',
        penjelasanLengkap: 'Bangun datar adalah bentuk dua dimensi yang memiliki luas dan keliling. Persegi memiliki 4 sisi sama panjang, persegi panjang memiliki 2 pasang sisi sejajar, segitiga memiliki 3 sisi, dan lingkaran memiliki jarak titik tepi yang sama terhadap titik pusat.',
        contoh: 'Contoh: Luas persegi dengan sisi 5 cm adalah 5 × 5 = 25 cm².',
        youtubeUrl: 'https://www.youtube.com/results?search_query=luas+dan+keliling+bangun+datar+sd',
      ),
      SubMateri(
        judulRingkas: 'Satuan panjang, berat, dan waktu.',
        penjelasanLengkap: 'Pengukuran digunakan untuk mengetahui ukuran suatu benda atau durasi kejadian. Satuan panjang baku menggunakan meter (m) dan sentimeter (cm), satuan berat menggunakan kilogram (kg) dan gram (g), serta satuan waktu menggunakan jam, menit, dan detik.',
        contoh: 'Contoh: 1 meter = 100 cm, 1 kilogram = 1.000 gram, dan 1 jam = 60 menit.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=satuan+panjang+berat+dan+waktu+sd',
      ),
      SubMateri(
        judulRingkas: 'Bangun ruang: kubus, balok, tabung, dan bola.',
        penjelasanLengkap: 'Bangun ruang adalah bentuk tiga dimensi yang memiliki panjang, lebar, tinggi, serta isi atau volume. Kubus memiliki 6 sisi berbentuk persegi yang sama besar, sedangkan balok memiliki 3 pasang sisi berbentuk persegi panjang.',
        contoh: 'Contoh: Volume kubus dengan panjang rusuk 4 cm adalah 4 × 4 × 4 = 64 cm³.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=mengenal+bangun+ruang+kubus+dan+balok+sd',
      ),
      SubMateri(
        judulRingkas:
            'Membaca dan menyajikan data dalam diagram batang sederhana.',
        penjelasanLengkap: 'Data adalah kumpulan informasi hasil pengamatan atau pencatatan. Agar mudah dibaca, data dapat disajikan dalam bentuk tabel atau diagram batang yang menampilkan tinggi batang sesuai jumlah masing-masing kategori.',
        contoh: 'Contoh: Jika 8 siswa menyukai mangga dan 5 siswa menyukai apel, batang mangga digambar lebih tinggi dari apel.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=membaca+diagram+batang+sederhana+sd',
      ),
    ],
  ),

  // 2. BAHASA INDONESIA (6 Sub-Materi)
  Materi(
    judul: 'Bahasa Indonesia',
    deskripsi: 'Keterampilan membaca, menulis kalimat, dan memahami teks.',
    icon: Icons.translate_rounded,
    warna: Colors.redAccent,
    poin: [
      SubMateri(
        judulRingkas: 'Menentukan ide pokok dalam paragraf.',
        penjelasanLengkap: 'Ide pokok adalah gagasan utama yang menjadi inti pembahasan dalam sebuah paragraf. Ide pokok biasanya terdapat pada kalimat utama di awal (deduktif) atau di akhir paragraf (induktif).',
        contoh: 'Contoh: "Olahraga sangat bermanfaat bagi kesehatan tubuh." merupakan kalimat utama paragraf tentang manfaat olahraga.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=cara+menentukan+ide+pokok+paragraf+sd',
      ),
      SubMateri(
        judulRingkas: 'Penggunaan huruf kapital dan tanda baca yang tepat.',
        penjelasanLengkap: 'Huruf kapital digunakan pada awal kalimat, nama orang, nama hari, nama bulan, dan nama tempat geografis. Tanda titik (.) mengakhiri kalimat berita, tanda tanya (?) untuk kalimat tanya, dan tanda seru (!) untuk kalimat perintah.',
        contoh: 'Contoh: "Pada hari Senin, Rina berkunjung ke Kota Bandung."',
        youtubeUrl: 'https://www.youtube.com/results?search_query=penggunaan+huruf+kapital+dan+tanda+baca+sd',
      ),
      SubMateri(
        judulRingkas: 'Sinonim (persamaan kata) dan antonim (lawan kata).',
        penjelasanLengkap: 'Sinonim adalah dua kata atau lebih yang memiliki makna yang sama atau hampir sama. Antonim adalah kata-kata yang memiliki makna saling berlawanan satu sama lain.',
        contoh: 'Contoh: Sinonim dari "pandai" adalah "pintar". Antonim dari "tinggi" adalah "rendah".',
        youtubeUrl: 'https://www.youtube.com/results?search_query=sinonim+dan+antonim+bahasa+indonesia+sd',
      ),
      SubMateri(
        judulRingkas: 'Struktur kalimat sederhana (S-P-O-K).',
        penjelasanLengkap: 'Kalimat efektif disusun dari Subjek (pelaku), Predikat (tindakan/kegiatan), Objek (sasaran tindakan), dan Keterangan (tempat, waktu, atau cara).',
        contoh:
            'Contoh: "Adik (S) membaca (P) buku cerita (O) di ruang tamu (K)."',
        youtubeUrl: 'https://www.youtube.com/results?search_query=struktur+kalimat+spok+sd',
      ),
      SubMateri(
        judulRingkas:
            'Mengenal puisi anak dan cara membacanya dengan ekspresi.',
        penjelasanLengkap: 'Puisi adalah karya sastra yang disusun dalam bait dan baris dengan pilihan kata yang indah. Saat membaca puisi, perhatikan lafal (kejelasan ucapan), intonasi (nada suara), dan ekspresi wajah sesuai isi puisi.',
        contoh: 'Contoh: Puisi bertema alam dibaca dengan suara lembut dan penuh rasa kagum.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=belajar+membaca+puisi+anak+sd',
      ),
      SubMateri(
        judulRingkas: 'Membuat ringkasan dari teks cerita atau bacaan.',
        penjelasanLengkap: 'Ringkasan adalah penyajian singkat dari suatu bacaan panjang dengan tetap mempertahankan urutan kejadian dan gagasan utamanya tanpa mengubah makna cerita asli.',
        contoh: 'Contoh: Membaca seluruh cerita terlebih dahulu, mencatat bagian penting tiap paragraf, lalu merangkainya menjadi paragraf singkat.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=cara+meringkas+teks+bacaan+sd',
      ),
    ],
  ),

  // 3. IPA (6 Sub-Materi)
  Materi(
    judul: 'IPA',
    deskripsi: 'Mengenal makhluk hidup, energi, alam semesta, dan lingkungan.',
    icon: Icons.science_rounded,
    warna: Colors.green,
    poin: [
      SubMateri(
        judulRingkas: 'Ciri-ciri makhluk hidup dan kebutuhan dasarnya.',
        penjelasanLengkap: 'Makhluk hidup (manusia, hewan, dan tumbuhan) memiliki ciri bernapas, bergerak, tumbuh dan berkembang, berkembang biak, membutuhkan makanan/air, serta peka terhadap rangsang.',
        contoh: 'Contoh: Daun putri malu akan mengatup saat disentuh sebagai bukti peka terhadap rangsang.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=ciri+ciri+makhluk+hidup+ipa+sd',
      ),
      SubMateri(
        judulRingkas: 'Proses fotosintesis pada tumbuhan hijau.',
        penjelasanLengkap: 'Fotosintesis adalah proses pembuatan makanan oleh tumbuhan hijau dengan bantuan cahaya matahari, air dari akar, dan karbon dioksida dari udara melalui zat hijau daun (klorofil), yang menghasilkan glukosa dan oksigen.',
        contoh: 'Contoh: Tumbuhan yang diletakkan di tempat terang tumbuh lebih subur dan hijau dibandingkan di tempat gelap.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=proses+fotosintesis+tumbuhan+sd',
      ),
      SubMateri(
        judulRingkas: 'Perubahan wujud benda: padat, cair, dan gas.',
        penjelasanLengkap: 'Benda dapat berubah wujud akibat pemanasan atau pendinginan, seperti mencair (padat ke cair), membeku (cair ke padat), menguap (cair ke gas), mengembun (gas ke cair), dan menyublim (padat ke gas).',
        contoh: 'Contoh: Es batu yang dibiarkan di ruang terbuka akan mencair menjadi air.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=perubahan+wujud+benda+ipa+sd',
      ),
      SubMateri(
        judulRingkas: 'Sumber energi dan cara menghemat energi.',
        penjelasanLengkap: 'Sumber energi utama di bumi adalah matahari. Selain itu ada energi angin, air, listrik, dan bahan bakar. Menghemat energi penting agar sumber daya alam tetap lestari.',
        contoh:
            'Contoh: Mematikan lampu dan keran air setelah selesai digunakan.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=sumber+energi+dan+penghematan+energi+sd',
      ),
      SubMateri(
        judulRingkas:
            'Daur hidup hewan: metamorfosis sempurna dan tidak sempurna.',
        penjelasanLengkap: 'Metamorfosis adalah perubahan bentuk tubuh hewan selama masa pertumbuhan. Metamorfosis sempurna melewati 4 tahap (telur – larva – pupa/kepompong – dewasa), sedangkan tidak sempurna melewati 3 tahap (telur – nimfa – dewasa).',
        contoh: 'Contoh: Kupu-kupu mengalami metamorfosis sempurna, sedangkan belalang mengalami metamorfosis tidak sempurna.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=daur+hidup+hewan+metamorfosis+sd',
      ),
      SubMateri(
        judulRingkas: 'Mengenal tata surya: matahari dan planet-planet.',
        penjelasanLengkap: 'Tata surya adalah susunan benda langit yang berpusat pada Matahari sebagai bintang. Ada 8 planet yang mengelilingi Matahari secara teratur pada orbitnya, yaitu Merkurius, Venus, Bumi, Mars, Jupiter, Saturnus, Uranus, dan Neptunus.',
        contoh: 'Contoh: Bumi adalah planet ketiga dari Matahari yang memiliki air dan atmosfer sehingga dapat dihuni makhluk hidup.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=mengenal+tata+surya+dan+planet+sd',
      ),
    ],
  ),

  // 4. BAHASA INGGRIS (6 Sub-Materi)
  Materi(
    judul: 'Bahasa Inggris',
    deskripsi:
        'Kosakata dasar, perkenalan diri, angka, dan percakapan sehari-hari.',
    icon: Icons.language_rounded,
    warna: Colors.purple,
    poin: [
      SubMateri(
        judulRingkas: 'Greetings (salam sapaan) dan perkenalan diri.',
        penjelasanLengkap: 'Greetings digunakan untuk menyapa orang lain sesuai waktu, seperti Good morning (selamat pagi), Good afternoon (selamat siang), dan Good evening (selamat malam), diikuti perkenalan nama dan asal.',
        contoh: 'Contoh: "Hello! My name is Rina. Nice to meet you."',
        youtubeUrl: 'https://www.youtube.com/results?search_query=greetings+and+introduction+english+for+kids',
      ),
      SubMateri(
        judulRingkas: 'Numbers (angka 1–100) dan Colors (nama-nama warna).',
        penjelasanLengkap: 'Mengenal penyebutan angka dalam bahasa Inggris mulai dari one, two, three hingga one hundred, serta nama warna dasar seperti red (merah), blue (biru), yellow (kuning), dan green (hijau).',
        contoh: 'Contoh: "I have three blue pencils." (Saya punya tiga pensil biru).',
        youtubeUrl: 'https://www.youtube.com/results?search_query=numbers+and+colors+english+for+kids',
      ),
      SubMateri(
        judulRingkas: 'Kosakata anggota keluarga dan benda di kelas.',
        penjelasanLengkap: 'Mempelajari kosakata sekitar seperti father (ayah), mother (ibu), sister (saudara perempuan), brother (saudara laki-laki), serta benda kelas seperti book (buku), bag (tas), dan table (meja).',
        contoh: 'Contoh: "My mother puts a book on the table."',
        youtubeUrl: 'https://www.youtube.com/results?search_query=family+members+and+classroom+objects+vocabulary+kids',
      ),
      SubMateri(
        judulRingkas: 'Kalimat tanya sederhana: What, Where, dan How are you?',
        penjelasanLengkap: 'Kata tanya dasar digunakan untuk menanyakan informasi sederhana: What untuk menanyakan benda/nama, Where untuk menanyakan tempat, dan How are you untuk menanyakan kabar.',
        contoh: 'Contoh: "What is your favorite color?" — "My favorite color is green."',
        youtubeUrl: 'https://www.youtube.com/results?search_query=simple+questions+what+where+how+are+you+kids',
      ),
      SubMateri(
        judulRingkas: 'Days of the Week (nama hari) dan Months (nama bulan).',
        penjelasanLengkap: 'Dalam satu minggu terdapat 7 hari: Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, dan Saturday. Dalam satu tahun terdapat 12 bulan mulai dari January hingga December.',
        contoh: 'Contoh: "Today is Monday, and tomorrow is Tuesday."',
        youtubeUrl: 'https://www.youtube.com/results?search_query=days+of+the+week+and+months+song+for+kids',
      ),
      SubMateri(
        judulRingkas: 'Animals and Fruits (nama hewan dan buah-buahan).',
        penjelasanLengkap: 'Mengenal kosakata hewan di sekitar maupun kebun binatang seperti cat, rabbit, elephant, lion, serta nama buah-buahan segar seperti apple, banana, orange, dan watermelon.',
        contoh: 'Contoh: "A monkey likes to eat yellow bananas."',
        youtubeUrl: 'https://www.youtube.com/results?search_query=animals+and+fruits+vocabulary+for+kids',
      ),
    ],
  ),

  // 5. OLAHRAGA (6 Sub-Materi)
  Materi(
    judul: 'Olahraga',
    deskripsi:
        'Gerak dasar lokomotor, kebugaran jasmani, dan pola hidup sehat.',
    icon: Icons.sports_soccer_rounded,
    warna: Colors.blue,
    poin: [
      SubMateri(
        judulRingkas: 'Gerak dasar lokomotor: berjalan, berlari, dan melompat.',
        penjelasanLengkap: 'Gerak lokomotor adalah gerakan berpindah tempat dari satu titik ke titik lain. Melatih gerak lokomotor membantu meningkatkan keseimbangan, kelincahan, dan kekuatan otot kaki anak.',
        contoh:
            'Contoh: Berlari zig-zag melewati rintangan kerucut di lapangan.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=gerak+dasar+lokomotor+pjok+sd',
      ),
      SubMateri(
        judulRingkas:
            'Pentingnya pemanasan sebelum dan pendinginan sesudah olahraga.',
        penjelasanLengkap: 'Pemanasan (warming up) dilakukan selama 5–10 menit sebelum olahraga inti untuk melemaskan otot dan mencegah cedera. Pendinginan (cooling down) dilakukan setelah olahraga agar detak jantung kembali normal.',
        contoh: 'Contoh: Melakukan peregangan tangan, leher, dan kaki sebelum bermain sepak bola.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=gerakan+pemanasan+sebelum+olahraga+anak+sd',
      ),
      SubMateri(
        judulRingkas: 'Permainan bola besar: sepak bola dan bola basket mini.',
        penjelasanLengkap: 'Permainan bola besar melatih kerja sama tim, sportivitas, serta koordinasi mata, tangan, dan kaki. Dalam sepak bola teknik dasarnya adalah menendang dan menggiring bola, sedangkan dalam basket adalah memantulkan (dribbling) dan melempar bola.',
        contoh: 'Contoh: Mengoper bola kepada teman satu tim dengan bagian dalam kaki.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=permainan+bola+besar+pjok+sd',
      ),
      SubMateri(
        judulRingkas:
            'Menjaga kebersihan tubuh dan pola makan bergizi seimbang.',
        penjelasanLengkap: 'Kebugaran jasmani didukung oleh olahraga teratur, mandi setelah berkeringat, mencuci tangan dengan sabun, serta mengonsumsi makanan bergizi seimbang (karbohidrat, protein, sayur, buah, dan air putih).',
        contoh: 'Contoh: Minum air putih yang cukup setelah berolahraga dan mencuci tangan sebelum makan.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=pola+hidup+bersih+dan+sehat+pjok+sd',
      ),
      SubMateri(
        judulRingkas: 'Gerak non-lokomotor: menekuk, memutar, dan mengayun.',
        penjelasanLengkap: 'Gerak non-lokomotor adalah gerakan tubuh yang dilakukan di tempat tanpa berpindah posisi. Gerakan ini bermanfaat untuk melatih kelenturan sendi dan menjaga postur tubuh tetap tegak.',
        contoh: 'Contoh: Memutar kedua lengan ke depan dan ke belakang serta membungkukkan badan menyentuh ujung kaki.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=gerak+non+lokomotor+pjok+sd',
      ),
      SubMateri(
        judulRingkas: 'Senam irama sederhana mengikuti ketukan musik.',
        penjelasanLengkap: 'Senam irama adalah rangkaian gerakan senam yang dilakukan dengan mengikuti irama musik, tepukan tangan, atau hitungan. Senam irama melatih keluwesan gerak, kekompakan, dan rasa percaya diri.',
        contoh: 'Contoh: Melangkahkan kaki ke kiri dan ke kanan sambil mengayunkan kedua tangan sesuai hitungan 1 sampai 8.',
        youtubeUrl:
            'https://www.youtube.com/results?search_query=senam+irama+anak+sd',
      ),
    ],
  ),

  // 6. AGAMA (6 Sub-Materi)
  Materi(
    judul: 'Agama Islam',
    deskripsi: 'Akhlak terpuji, kejujuran, doa sehari-hari, dan toleransi.',
    icon: Icons.menu_book_rounded,
    warna: Colors.teal,
    poin: [
      SubMateri(
        judulRingkas: 'Keimanan dan rasa syukur kepada Tuhan Yang Maha Esa.',
        penjelasanLengkap: 'Keimanan adalah keyakinan dalam hati terhadap Tuhan dan ajaran agama yang dianut. Salah satu wujud keimanan anak adalah selalu bersyukur atas nikmat kesehatan, keluarga, dan alam sekitar.',
        contoh: 'Contoh: Mengucapkan syukur dan merawat tanaman serta hewan peliharaan dengan baik.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=bersyukur+kepada+tuhan+pendidikan+agama+sd',
      ),
      SubMateri(
        judulRingkas:
            'Perilaku jujur, amanah, dan hormat kepada orang tua serta guru.',
        penjelasanLengkap: 'Jujur berarti berkata dan bertindak sesuai kenyataan tanpa berbohong. Menghormati orang tua dan guru dilakukan dengan berbicara sopan, mendengarkan nasihat, serta mematuhi aturan kebaikan.',
        contoh: 'Contoh: Mengakui kesalahan saat tidak sengaja menjatuhkan barang dan meminta maaf.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=perilaku+jujur+dan+hormat+orang+tua+sd',
      ),
      SubMateri(
        judulRingkas: 'Membiasakan doa sebelum dan sesudah melakukan kegiatan.',
        penjelasanLengkap: 'Berdoa merupakan cara memohon perlindungan, kemudahan, dan keberkahan kepada Tuhan sebelum maupun sesudah melakukan aktivitas sehari-hari seperti belajar, makan, tidur, dan bepergian.',
        contoh: 'Contoh: Membaca doa sebelum mulai belajar di kelas agar ilmu mudah dipahami.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=doa+sehari+hari+untuk+anak+sd',
      ),
      SubMateri(
        judulRingkas:
            'Hidup rukun, saling menolong, dan toleransi antar sesama.',
        penjelasanLengkap: 'Toleransi adalah sikap saling menghormati dan menghargai perbedaan suku, budaya, maupun keyakinan teman. Sikap tolong-menolong menciptakan lingkungan bermain dan belajar yang damai.',
        contoh: 'Contoh: Membantu teman yang terjatuh dan tidak mengganggu teman yang sedang beribadah.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=hidup+rukun+dan+toleransi+anak+sd',
      ),
      SubMateri(
        judulRingkas:
            'Menjaga kebersihan diri dan lingkungan sebagai bagian dari iman.',
        penjelasanLengkap: 'Kebersihan badan, pakaian, dan tempat belajar mencerminkan hati yang bersih dan disiplin. Menjaga kebersihan juga menghindarkan kita dari berbagai penyakit.',
        contoh: 'Contoh: Membuang sampah pada tempatnya dan merapikan perlengkapan sekolah setelah belajar.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=kebersihan+sebagian+dari+iman+anak+sd',
      ),
      SubMateri(
        judulRingkas: 'Sifat pemaaf dan gemar berbagi kepada sesama.',
        penjelasanLengkap: 'Pemaaf berarti lapang dada memaafkan kesalahan teman tanpa menyimpan dendam. Gemar berbagi melatih empati dan kepedulian terhadap orang lain yang membutuhkan.',
        contoh: 'Contoh: Meminjamkan pensil kepada teman yang lupa membawa alat tulis dan berbagi bekal makanan.',
        youtubeUrl: 'https://www.youtube.com/results?search_query=sifat+pemaaf+dan+suka+berbagi+anak+sd',
      ),
    ],
  ),
];
