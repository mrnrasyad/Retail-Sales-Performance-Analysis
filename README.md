# Project Background
Perusahaan ABC merupakan perusahaan ritel yang beroperasi di berbagai provinsi di Indonesia. Untuk mendukung pengambilan keputusan strategis, dilakukan analisis performa penjualan sepanjang tahun 2019 guna memahami tren penjualan secara bulanan serta membandingkan kontribusi dan karakteristik performa antar cabang di berbagai provinsi. Selain itu, analisis ini juga mengevaluasi kinerja brand utama yang berkontribusi terhadap total pendapatan perusahaan.

Berdasarkan hasil analisis, insight dan rekomendasi difokuskan pada tiga area utama berikut. 

- **Month-to-Month Trend Insight:** Membahas pola pergerakan GMV sepanjang tahun 2019, termasuk indikasi seasonality serta faktor utama yang mendorong kenaikan dan penurunan penjualan bulanan, terutama dari sisi volume order dan jumlah customer aktif.
- **Province Performance Insight:** Menganalisis kontribusi GMV antar provinsi serta perbedaan karakteristik penjualan tiap wilayah, baik dari sisi volume transaksi maupun nilai rata-rata order (AOV).
- **Brand Performance Insight:** Mengulas kinerja brand terhadap total GMV perusahaan, termasuk stabilitas penjualan, sensitivitas terhadap fluktuasi musiman, dan peran masing-masing brand dalam mendorong revenue.  

Python notebook yang digunakan untuk mengambil data melalui API, melakukan inspeksi data, serta proses pembersihan data dapat diakses pada folder berikut: [link](https://github.com/mrnrasyad/Retail-Sales-Performance-Analysis/tree/main/python%20notebook).

Query SQL yang digunakan untuk membangun ERD serta menjalankan berbagai analytic query untuk menjawab berbagai pertanyaan bisnis tersedia pada folder berikut: [link](https://github.com/mrnrasyad/Retail-Sales-Performance-Analysis/tree/main/sql).

Dashboard Tableau interaktif yang digunakan untuk laporan dan eksplorasi tren penjualan dapat diakses melalui tautan berikut: [link](https://public.tableau.com/views/retail_performance_dashboard/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link).



# Data Structure & Initial Checks

Struktur basis data utama perusahaan ABC terdiri dari empat tabel, yaitu Customer, Order, Order_Detail, dan Product dengan total baris sebanyak 50651. Deskripsi masing-masing tabel adalah sebagai berikut:

- **Customer:** Tabel ini berisi informasi lokasi pelanggan berupa kota dan provinsi serta id pelanggan. Data ini digunakan untuk analisis geografis dan perilaku pelanggan.
- **Order:** Setiap order memiliki order_id, order_date, dan terhubung ke satu pelanggan melalui CustomerKey. Tabel ini merepresentasikan satu transaksi pembelian oleh pelanggan.
- **Order_Detail:** Tabel ini berisi informasi kuantitas, harga per item, dan total harga, serta menghubungkan Order dan Product melalui foreign key OrderKey dan product_id.
- **Product:** Menyimpan data master produk dengan product_id sebagai primary key dan atribut brand. Tabel ini digunakan untuk analisis performa produk dan brand terhadap penjualan.

<p align="center">
  <kbd><img src="image\erd.png"> </kbd> <br>
  Entity Relationship Diagram
</p>



# Executive Summary

### Overview of Findings

Total GMV sepanjang tahun 2019 mencapai **Rp355.901.161.000**, dengan puncak penjualan terjadi pada **bulan Desember sebesar Rp44.546.359.000** atau sekitar **12,5% dari total revenue tahunan**. Penurunan GMV terbesar terjadi pada **bulan September**, dengan penurunan **−25,61% dibandingkan bulan sebelumnya**, sementara kenaikan GMV tertinggi terjadi pada **bulan Oktober**, meningkat **87,19% dibandingkan bulan September**.

Dari sisi regional, **DKI Jakarta merupakan kontributor GMV terbesar** dengan **31,7% dari total revenue**, menunjukkan konsentrasi penjualan yang kuat di satu wilayah. Dari sisi brand, **Brand S menjadi market leader** dengan kontribusi **12,6% terhadap total GMV**, menjadikannya brand paling berpengaruh terhadap kinerja penjualan secara keseluruhan.



<p align="center">
  <kbd><img src="image\insight-1.png" width=800px> </kbd> <br>
  Performance Summary
</p>




# Insights Deep Dive
### Month-to-Month Trend Insight:

* GMV menunjukkan **tren peningkatan dari awal tahun hingga Mei**, kemudian mengalami **perlambatan pada pertengahan tahun (Juni–September)** sebelum kembali meningkat signifikan pada kuartal akhir. Pola ini mengindikasikan adanya **seasonality dalam perilaku pembelian**, namun perlu data lintas tahun untuk konfirmasi.
* Perlambatan GMV di pertengahan tahun terutama disebabkan oleh melemahnya aktivitas customer (penurunan order dan unit), bukan penurunan nilai per transaksi. Hal ini menunjukkan isu engagement, sementara lonjakan Oktober menegaskan bahwa GMV sangat dipengaruhi aktivasi customer dan volume transaksi.

<p align="center">
  <kbd><img src="image\insight-2.png" width=600px> </kbd> <br>
  Month-to-Month Trend Insight
</p>

### Province Performance Insight:

* **DKI Jakarta mendominasi GMV nasional** dengan kontribusi **31,7%**, disusul oleh **Jawa Barat (13,6%)**, **Yogyakarta (8,7%)**, **Jawa Tengah (7,8%)**, dan **Jawa Timur (5,0%)**.
* Ketimpangan kontribusi GMV yang cukup besar antara Jakarta dan provinsi lain menunjukkan bahwa **penjualan masih sangat terpusat pada wilayah tertentu**, sehingga ketergantungan terhadap satu pasar relatif tinggi.
* **Riau dan Sumatra Barat memiliki AOV yang sangat tinggi dengan jumlah order yang relatif rendah**, mengindikasikan kemungkinan adanya transaksi bernilai besar per order.
* Sebaliknya, **Jakarta menghasilkan GMV besar terutama dari volume transaksi yang tinggi**, bukan dari nilai transaksi per order yang tinggi. Hal ini menunjukkan **perbedaan karakteristik perilaku pembelian antar wilayah**.

<p align="center">
  <kbd><img src="image\insight-3.png" width=600px> </kbd> <br>
  Province Performance Insight
</p>


### Brand Performance Insight:

* **Brand S, Brand P, Brand R, Brand C, dan Brand D** merupakan lima brand dengan kontribusi GMV terbesar, dengan **Brand S sebagai market leader (12,6%)**, diikuti oleh **Brand P (10,6%)**, **Brand R (10,2%)**, **Brand C (7,4%)**, dan **Brand D (7,0%)**.
* Sebagian besar brand utama (**Brand S, Brand R, Brand C, dan Brand D**) mengalami **perlambatan penjualan pada pertengahan tahun**, serta **penurunan GMV pada bulan September**, yang selaras dengan penurunan jumlah customer aktif.
* **Brand P menunjukkan performa paling stabil sepanjang tahun**, dengan tren GMV yang relatif konsisten dan cenderung meningkat, menjadikannya brand dengan ketahanan stabilitas penjualan terbaik.
* Brand dengan kontribusi GMV sangat kecil (misalnya **Brand Q, ~0,03%**) berpotensi memiliki **peran kecil atau niche**, sehingga dampaknya terhadap total revenue relatif tidak signifikan.

<p align="center">
  <kbd><img src="image\insight-4.png" width=600px> </kbd> <br>
  Brand Performance Insight
</p>



# Recommendations:

Berdasarkan insight dan temuan yang telah dijelaskan, beberapa rekomendasi yang dapat dilakukan adalah:

1. **Investigasi penurunan customer pada bulan September**
   * Lakukan analisis lebih lanjut pada faktor eksternal (musiman, kalender libur, atau perubahan perilaku pelanggan) serta faktor internal (promo, stok, atau channel distribusi).

2. **Optimalkan campaign pada periode low-season**
   * Jalankan program promosi atau insentif khusus pada periode **Juni–September**, terutama menjelang September, untuk menstabilkan GMV dan menjaga jumlah customer aktif.

3. **Strategi regional yang lebih tersegmentasi**
   * Kurangi ketergantungan pada Jakarta dengan mendorong pertumbuhan di provinsi berkontribusi menengah (Jawa Barat, Yogyakarta, Jawa Tengah) melalui kampanye lokal atau penyesuaian channel distribusi.
   * Manfaatkan provinsi dengan **AOV tinggi namun order rendah** (misalnya Riau dan Sumatra Barat) untuk program **high-value account management** atau penawaran khusus pembelian bernilai besar.

4. **Perencanaan penjualan akhir tahun**
   * Mengingat lonjakan kinerja pada kuartal IV, siapkan **stok, kampanye, dan kapasitas operasional lebih awal** untuk memaksimalkan potensi peak season.
  


# Assumptions and Caveats:

Selama proses analisis, beberapa asumsi diterapkan untuk menangani permasalahan kualitas data. Asumsi dan batasan tersebut dijelaskan sebagai berikut:

* Data penjualan dengan `customer_id = 0`, `product_id = 'unknown'`, atau `brand = 'unknown'` tidak disertakan dalam analisis.
* Data dengan nilai `item_price` negatif atau `order_id = 'undefined'` dihapus agar tidak memengaruhi hasil analisis.
