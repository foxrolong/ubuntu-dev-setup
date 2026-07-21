#!/bin/bash

echo "===== INSTALL MENU ====="
echo "1) Visual Studio Code"
echo "2) Kiro CLI"
echo "3) Cài cả hai"
echo "4) Thoát"

read -rp "Chọn: " choice

case "$choice" in
    1)
        sudo snap install --classic code
        ;;
    2)
        curl -fsSL https://cli.kiro.dev/install | bash
        ;;
    3)
        sudo snap install --classic code
        curl -fsSL https://cli.kiro.dev/install | bash
        ;;
    4)
        exit 0
        ;;
    *)
        echo "Lựa chọn không hợp lệ!"
        exit 1
        ;;
esac

echo "Hoàn tất."
