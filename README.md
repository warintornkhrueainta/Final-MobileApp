# 🎬 Movie Tracker App (บันทึกรายการหนัง/ซีรีส์)

### 👤 ผู้จัดทำ
- ชื่อ-นามสกุล: วรินทร เครืออินตา
- รหัสผู้เข้าสอบ: 67543210065-8

---

## 📝 รายละเอียดฟังก์ชัน (Features)
แอปพลิเคชันสำหรับจัดการรายการหนังและซีรีส์ที่ชื่นชอบ โดยมีฟังก์ชันหลักดังนี้:
* **Dashboard สรุปข้อมูล:** แสดงตัวเลขสถิติแยกตามสถานะ (อยากดู, กำลังดู, ดูจบ)
* **การจัดการข้อมูล (CRUD):** เพิ่ม, อ่าน, แก้ไข และลบ รายการหนังได้
* **ระบบค้นหา (Search):** ค้นหารายการตามชื่อเรื่องแบบ Real-time
* **ระบบกรองข้อมูล (Filter):** เลือกดูรายการตามสถานะที่กำหนด
* **ฐานข้อมูล Local:** บันทึกข้อมูลลงในเครื่องด้วย SQLite ข้อมูลไม่หายเมื่อปิดแอป
<img width="473" height="909" alt="Image" src="https://github.com/user-attachments/assets/13f3964c-7bfe-41da-b357-1449e4e60bbe" />

<img width="473" height="909" alt="Image" src="https://github.com/user-attachments/assets/0d60ce73-a846-4ae9-b1ad-8ad3c7b1cd18" />

<img width="473" height="909" alt="Image" src="https://github.com/user-attachments/assets/b0d8dec3-c7eb-41b2-924c-24dfb10f2f5f" />

<img width="473" height="909" alt="Image" src="https://github.com/user-attachments/assets/8ffba7e2-53fc-420c-923c-bcf6b54f1c79" />

<img width="473" height="909" alt="Image" src="https://github.com/user-attachments/assets/939319d1-2977-4f5a-ad55-9b5ffd0b8066" />

<img width="473" height="909" alt="Image" src="https://github.com/user-attachments/assets/f2595e1b-3130-4202-b30b-3eb93afef6ac" />

<img width="473" height="909" alt="Image" src="https://github.com/user-attachments/assets/ac2a561f-e9dd-4d06-8fb9-13ef3cda160e" />

---

## 🗄️ โครงสร้างฐานข้อมูล (Database Structure)

แอปพลิเคชันนี้ใช้ฐานข้อมูล **SQLite** โดยมีตารางหลักคือ `movies` ดังนี้:

### ER Diagram แบบง่าย


| Field Name | Data Type | Description |
| :--- | :--- | :--- |
| **id** | INTEGER (PK) | ไอดีหลัก (Auto Increment) |
| **title** | TEXT | ชื่อเรื่องหนัง/ซีรีส์ |
| **type** | TEXT | ประเภท (Movie, Series) |
| **status** | TEXT | สถานะ (อยากดู, กำลังดู, ดูจบ) |
| **rating** | REAL | คะแนนความพึงพอใจ (0.0 - 10.0) |
| **note** | TEXT | บันทึกเพิ่มเติม |
| **episodes**| INTEGER | จำนวนตอน (สำหรับซีรีส์) |

---

## 📦 Package ที่ใช้ (Dependencies)
แอปนี้พัฒนาด้วย Flutter โดยใช้ Library หลักดังนี้:
1.  **provider**: สำหรับจัดการ State Management ของข้อมูล
2.  **sqflite**: สำหรับจัดการฐานข้อมูล SQLite
3.  **path**: สำหรับจัดการที่อยู่ไฟล์ฐานข้อมูลในเครื่อง

---

## 🚀 วิธีการรันแอปพลิเคชัน (How to run)
1.  ทำการ `git clone` repository นี้ลงในเครื่อง
2.  เปิด Command Line ใน Folder โปรเจกต์ แล้วรันคำสั่ง:
    ```bash
    flutter pub get
    ```
3.  เชื่อมต่อเครื่องจริงหรือเปิด Simulator
4.  รันแอปด้วยคำสั่ง:
    ```bash
    flutter run
    ```
*(หรือติดตั้งผ่านไฟล์ APK ที่อยู่ในโฟลเดอร์ `/release`)*
