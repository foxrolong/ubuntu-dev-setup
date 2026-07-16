#!/bin/bash

# Kiểm tra whiptail
if ! command -v whiptail &>/dev/null; then
    echo "Đang cài đặt whiptail..."
    sudo apt update
    sudo apt install -y whiptail
fi

# Hiển thị bảng chọn
BROWSERS=$(whiptail \
    --title "TRÌNH CÀI ĐẶT BROWSER FOXRO" \
    --checklist \
"Điều khiển:
↑ ↓ : Di chuyển
Space : Tích/Bỏ tích
Tab : Chuyển sang OK/Cancel
Enter : Xác nhận
Esc : Hủy cài đặt" \
    20 70 10 \
    "chrome" "Google Chrome" OFF \
    "edge" "Microsoft Edge" OFF \
    "brave" "Brave Browser" OFF \
    "coccoc" "Cốc Cốc Browser" OFF \
    3>&1 1>&2 2>&3)

# Nếu nhấn ESC hoặc Cancel
if [ $? -ne 0 ]; then
    echo "Đã hủy cài đặt."
    exit 0
fi

clear
echo "=============================="
echo " BẮT ĐẦU CÀI ĐẶT"
echo "=============================="

for browser in $BROWSERS; do
    browser=$(echo "$browser" | tr -d '"')

    case "$browser" in
        chrome)
            echo "▶ Cài Google Chrome..."
            wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
            sudo apt install -y ./google-chrome-stable_current_amd64.deb
            rm -f google-chrome-stable_current_amd64.deb
            ;;

        edge)
            echo "▶ Cài Microsoft Edge..."
            curl https://packages.microsoft.com/keys/microsoft.asc | \
                gpg --dearmor | \
                sudo tee /usr/share/keyrings/microsoft-edge.gpg >/dev/null

            echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main" | \
                sudo tee /etc/apt/sources.list.d/microsoft-edge.list >/dev/null

            sudo apt update
            sudo apt install -y microsoft-edge-stable
            ;;

        brave)
            echo "▶ Cài Brave..."
            curl -fsS https://dl.brave.com/install.sh | sh
            ;;

        coccoc)
            echo "▶ Cài Cốc Cốc..."
            wget -q https://files.coccoc.com/browser/coccoc-browser_latest_amd64.deb
            sudo apt install -y ./coccoc-browser_latest_amd64.deb
            rm -f coccoc-browser_latest_amd64.deb
            ;;
    esac
done

echo
echo "=============================="
echo " Hoàn tất cài đặt!"
echo "=============================="
