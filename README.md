# ErgoMotion Lab 🏃‍♀️⚙️📱  
*Scan • Score • Improve — HP lo jadi lab ergonomi berjalan.*

ErgoMotion Lab adalah aplikasi Android (build with **Flet + Flutter**) yang memadukan teknik industri & biologi manusia. Fokusnya: bantu mahasiswa praktikum menganalisis postur, beban kerja, dan time-motion study **secara real-time** langsung dari kamera & sensor internal ponsel.

## Kenapa Keren?

- **RULA & REBA Auto-Scoring** – deteksi risiko ergonomi hitungan detik.  
- **MODAPTS / MOST Mapping** – kode aktivitas & perhitungan TMU otomatis.  
- **Offline-First** – tetap jalan meski sinyal ngadat; sync ke cloud kalau ready.  
- **One-Tap Insight** – overlay skeleton + risk meter, laporan ringkas di aplikasi.  
- **Built for Students** – dirancang khusus buat tugas praktikum, bukan pabrik raksasa.

## Teknologi Singkat

| Layer        | Stack                           |
|--------------|---------------------------------|
| UI/UX        | Flet (Python) + Flutter Custom Control |
| Pose Engine  | TensorFlow Lite MoveNet Lightning |
| Scoring      | PoseRisk (RULA/REBA)            |
| Backend Opt. | FastAPI on Cloud Run            |
| Database     | SQLite offline, Supabase sync   |

> Project ini masih early-beta. Contributions, bug reports, atau ide liar sangat diterima!

MIT © 2025 ErgoMotion Lab Team
