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
