#!/bin/bash

# Kiểm tra và cài đặt whiptail nếu chưa có
if ! command -v whiptail &>/dev/null; then
    echo "Đang cài đặt whiptail..."
    sudo apt update
    sudo apt install -y whiptail
fi

RESULTS=()

# Hàm cài đặt ứng dụng
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
        RESULTS+=("⏩ $name: Đã cài đặt trước đó (Bỏ qua)")
        return
    fi
    
    echo "▶ Đang cài $name..."
    if "$@"; then
        RESULTS+=("✅ $name: Cài đặt thành công")
    else
        RESULTS+=("❌ $name: Cài đặt thất bại")
    fi
}

# Hàm gỡ cài đặt ứng dụng
uninstall_app() {
    local name="$1"
    local package="$2"
    shift 2
    echo
    echo "========================================"
    echo "▶ Đang kiểm tra $name..."
    echo "========================================"
    
    # Nếu chưa cài thì bỏ qua
    if ! dpkg -s "$package" &>/dev/null; then
        echo "⏩ $name chưa từng được cài đặt."
        RESULTS+=("⏩ $name: Chưa cài đặt (Bỏ qua)")
        return
    fi
    
    echo "▶ Đang gỡ cài đặt $name..."
    if "$@"; then
        RESULTS+=("🗑️ $name: Gỡ cài đặt thành công")
    else
        RESULTS+=("❌ $name: Gỡ cài đặt thất bại")
    fi
}

# 1. BẢNG CHỌN CHẾ ĐỘ: CÀI ĐẶT hoặc GỠ CÀI ĐẶT
ACTION=$(whiptail --title "QUẢN LÝ TRÌNH DUYỆT" --menu "Chọn hành động bạn muốn thực hiện:" 15 60 4 \
    "INSTALL" "Cài đặt trình duyệt mới" \
    "UNINSTALL" "Gỡ cài đặt trình duyệt hiện tại" 3>&1 1>&2 2>&3)

# Nếu nhấn ESC hoặc Cancel ở bảng chọn chế độ
if [ $? -ne 0 ]; then
    echo "Đã hủy thao tác."
    exit 0
fi

# 2. BẢNG CHỌN TRÌNH DUYỆT
TITLE_ACTION="CÀI ĐẶT"
[ "$ACTION" = "UNINSTALL" ] && TITLE_ACTION="GỠ CÀI ĐẶT"

BROWSERS=$(whiptail \
    --title "$TITLE_ACTION TRÌNH DUYỆT" \
    --checklist \
"Điều khiển:
↑ ↓ : Di chuyển
Space : Tích/Bỏ tích
Tab : Chuyển sang OK/Cancel
Enter : Xác nhận
Esc : Hủy bỏ" \
    20 70 10 \
    "chrome" "Google Chrome" OFF \
    "edge" "Microsoft Edge" OFF \
    "brave" "Brave Browser" OFF \
    "coccoc" "Cốc Cốc Browser" OFF \
    3>&1 1>&2 2>&3)

# Nếu nhấn ESC hoặc Cancel ở bảng chọn trình duyệt
if [ $? -ne 0 ]; then
    echo "Đã hủy thao tác."
    exit 0
fi

clear

# 3. XỬ LÝ HÀNH ĐỘNG CÀI ĐẶT HOẶC GỠ CÀI ĐẶT
for browser in $BROWSERS; do
    browser=$(echo "$browser" | tr -d '"')
    
    if [ "$ACTION" = "INSTALL" ]; then
        # CHẾ ĐỘ CÀI ĐẶT
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
                install_app "Cốc Cốc Browser" "coccoc-browser-stable" bash -c '
                    curl -s https://browser-linux.coccoc.com/deb/public.gpg | sudo gpg --yes --dearmor -o /etc/apt/trusted.gpg.d/coccoc-browser.gpg &&
                    echo "deb [arch=any] https://browser-linux.coccoc.com/deb/ stable main" | sudo tee /etc/apt/sources.list.d/coccoc-browser.list > /dev/null &&
                    sudo apt update &&
                    sudo apt install -y coccoc-browser-stable
                '
                ;;
        esac
    else
        # CHẾ ĐỘ GỠ CÀI ĐẶT (UNINSTALL)
        case "$browser" in
            chrome)
                uninstall_app "Google Chrome" "google-chrome-stable" bash -c '
                    sudo apt purge -y google-chrome-stable &&
                    sudo apt autoremove -y
                '
                ;;
            edge)
                uninstall_app "Microsoft Edge" "microsoft-edge-stable" bash -c '
                    sudo apt purge -y microsoft-edge-stable &&
                    sudo rm -f /etc/apt/sources.list.d/microsoft-edge.list /usr/share/keyrings/microsoft-edge.gpg &&
                    sudo apt autoremove -y
                '
                ;;
            brave)
                uninstall_app "Brave Browser" "brave-browser" bash -c '
                    sudo apt purge -y brave-browser brave-keyring &&
                    sudo rm -f /etc/apt/sources.list.d/brave-browser-release.list /usr/share/keyrings/brave-browser-archive-keyring.gpg &&
                    sudo apt autoremove -y
                '
                ;;
            coccoc)
                uninstall_app "Cốc Cốc Browser" "coccoc-browser-stable" bash -c '
                    sudo apt purge -y coccoc-browser-stable &&
                    sudo rm -f /etc/apt/sources.list.d/coccoc-browser.list /etc/apt/trusted.gpg.d/coccoc-browser.gpg &&
                    sudo apt autoremove -y
                '
                ;;
        esac
    fi
done

# 4. HIỂN THỊ KẾT QUẢ
echo
echo "========================================"
echo "           KẾT QUẢ THỰC HIỆN"
echo "========================================"
if [ ${#RESULTS[@]} -eq 0 ]; then
    echo "Không có thay đổi nào được thực hiện."
else
    for result in "${RESULTS[@]}"; do
        echo "$result"
    done
fi
echo "========================================"