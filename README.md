# ubuntu-dev-setup
## Hướng dẫn cài đặt

trước tiên hãy cập nhật danh sách các gói phần mềm mới nhất cùng phiên bản của chúng từ kho lưu trữ. Mục đích để hệ thống biết được những thay đổi mới nhất và có thể cài đặt hoặc nâng cấp các phần mềm một cách an toàn và chính xác.

```update
sudo apt update
```
Để cài đặt tất cả các công cụ một cách nhanh chóng hãy chạy lệnh sau:

```bash

```

nếu muốn cài từng công cụ có thể tham khảo các file script tương ứng phía dưới đây:
## Trình duyệt web
Lý do từ "trình duyệt" được dùng ở dạng số nhiều rất đơn giản: việc có nhiều trình duyệt web cho phép bạn phân chia việc sử dụng từng trình duyệt cho một mục đích cụ thể. Ví dụ:
<ol>
    <li>Microsoft Edge</li>
    <li>Cốc Cốc</li>
    <li>Brave</li>
    <li>Google Chrome</li>
</ol>
lệnh cài đặt các trình duyệt sau:
<p>(chạy lệnh xong mọi người có thể chọn trình duyệt nào muốn cài rồi cài nhé)</p>

```push
bash -c "$(curl -fsSL https://raw.githubusercontent.com/foxrolong/ubuntu-dev-setup/main/browser.sh)"
```

<div align="center">
  <img src="image/menu-browser.png" width="500"/>
</div>

## Môi trường lập trình

**Curl**
```
sudo apt install curl
```
**VS Code**
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/foxrolong/ubuntu-dev-setup/main/install.sh)"
```
**Vietnamese input (IBus unikey)**
```

```
**Git**
```

```
1. Công cụ Tùy chỉnh Đồ họa (GUI)
Nếu bạn muốn tinh chỉnh hệ thống mà chưa cần đụng tới dòng lệnh, đây là hai công cụ mạnh mẽ nhất:

GNOME Tweaks (gnome-tweaks): Cho phép can thiệp sâu hơn vào môi trường desktop. Bạn có thể thay đổi theme (chủ đề), font chữ, hành vi của cửa sổ, không gian làm việc (workspaces) và quản lý các ứng dụng khởi động cùng hệ thống.

Cài đặt: sudo apt install gnome-tweaks

Dconf Editor (dconf-editor): Được ví như "Registry Editor" của Ubuntu/GNOME. Công cụ này cho phép bạn đọc và thay đổi các biến môi trường cũng như cài đặt ẩn của hàng loạt phần mềm hệ thống.

Cài đặt: sudo apt install dconf-editor

Lưu ý: Cần cẩn thận khi thay đổi các giá trị (keys) trong đây vì sai sót có thể làm lỗi hành vi của giao diện.

## thêm sửa xóa
kiểm tra trong file có gì 
```
ls
```

xóa file
```
rm -r tên thư mục xóa/
rm -rf tên thư mục xóa/ 
```

## công cụ lập trình nhúng esp32 **esp-idf**

```
git clone https://github.com/espressif/esp-idf.git
git clone -b v6.0.2 --recursive https://github.com/espressif/esp-idf.git esp-idf-6.0.2
```
< lưu ý: yêu cầu tải bản python tương ứng khi cài 
< Ví Dụ: bản 6.0.2 tải python3.14 
```
sudo apt update
sudo apt install python3.14-venv
```
sau khi cài xong nhập lệnh (. ./export.sh) để chạy

- thêm vào vs code tự dộng chạy ko cần nhập lại thủ công
1. chọn **F1** trên bàn phím
2. tìm **setting.json**
<img width="566" height="141" alt="image" src="https://github.com/user-attachments/assets/c78b09ec-d0a5-4f1a-bb87-3deb6baaecf6" /><br>
chọn **Open user setting (Json)**
3. copy dán đoạn mã dưới này và thay đổi đường dẫn đến file chứa export.sh của bạn.
```
{
    "terminal.integrated.profiles.linux": {
        "bash": {
            "path": "bash",
            "args": [
                "-c",
                "source /run/media/long/48D4B274D4B263BA/IDF1/esp-idf-6.0.2/export.sh && bash"
            ]
        }
    }
}
```
### lỗi thường gặp
1. cmake
```
long@long:/run/media/long/48D4B274D4B263BA/idfiot/xiaozhi-esp32-2.4.0/xiaozhi-esp32-2.4.0$ idf.py set-target esp32s3
Adding "set-target"'s dependency "fullclean" to list of commands with default set of options.
Executing action: fullclean
Build directory '/run/media/long/48D4B274D4B263BA/idfiot/xiaozhi-esp32-2.4.0/xiaozhi-esp32-2.4.0/build' not found. Nothing to clean.
Executing action: set-target
Set Target to: esp32s3, new sdkconfig will be created.
fatal: not a git repository: '/run/media/long/48D4B274D4B263BA/IDF1/esp-idf-6.0.2/.git'
WARNING: Git version unavailable, reading from source
ESP-IDF v6.0.2
"cmake" must be available on the PATH to use idf.py
```
lỗi này là khi bạn chưa cài "cmake", để khác phục hãy tải "cmake"
```
sudo apt update
sudo apt install cmake
```
