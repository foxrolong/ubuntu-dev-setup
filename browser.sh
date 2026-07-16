#!/bin/bash

# Kiểm tra whiptail
if ! command -v whiptail &>/dev/null; then
    echo "Đang cài đặt whiptail..."
    sudo apt update
    sudo apt install -y whiptail
fi

RESULTS=()

install_app() {
    local name="$1"
    local package="$2"
    shift 2

    echo
    echo "========================================"
    echo "▶ Đang kiểm tra $name..."
    echo "========================================"

    # Nếu đã cài thì bỏ qua
    if dpkg -s "$package" &>/dev/null; then
        echo "⏩ $name đã được cài đặt."
        RESULTS+=("⏩ $name: Đã cài đặt (Bỏ qua)")
        return
    fi

    echo "▶ Đang cài $name..."

    if "$@"; then
        RESULTS+=("✅ $name: Thành công")
    else
        RESULTS+=("❌ $name: Cài không thành công")
    fi
}

# Hiển thị bảng chọn
BROWSERS=$(whiptail \
    --title "CÀI ĐẶT TRÌNH DUYỆT" \
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

for browser in $BROWSERS; do
    browser=$(echo "$browser" | tr -d '"')

    case "$browser" in
        chrome)
            install_app "Google Chrome" "google-chrome-stable" bash -c '
                wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &&
                sudo apt install -y ./google-chrome-stable_current_amd64.deb &&
                rm -f google-chrome-stable_current_amd64.deb
            '
            ;;

        edge)
            install_app "Microsoft Edge" "microsoft-edge-stable" bash -c '
                curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft-edge.gpg >/dev/null &&
                echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge.list >/dev/null &&
                sudo apt update &&
                sudo apt install -y microsoft-edge-stable
            '
            ;;

        brave)
            install_app "Brave Browser" "brave-browser" bash -c '
                curl -fsS https://dl.brave.com/install.sh | sh
            '
            ;;

        coccoc)
            install_app "Cốc Cốc Browser" "coccoc-browser" bash -c '
                curl https://browser-linux.coccoc.com/deb/public.gpg | sudo gpg --yes --dearmor -o /etc/apt/trusted.gpg.d/coccoc-browser.gpg
echo "deb [arch=any] https://browser-linux.coccoc.com/deb/ stable main" | sudo tee /etc/apt/sources.list.d/coccoc-browser.list > /dev/null
sudo apt update
sudo apt install -y coccoc-browser-stable
            '
            ;;
    esac
done

echo
echo "========================================"
echo "           KẾT QUẢ CÀI ĐẶT"
echo "========================================"

for result in "${RESULTS[@]}"; do
    echo "$result"
done

echo "========================================"
