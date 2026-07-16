echo "Chọn trình duyệt bạn muốn cài:"
options=("Google Chrome" "Microsoft Edge" "Cốc Cốc" "Brave" "Thoát")
select opt in "${options[@]}"; do
    case $opt in
        "Google Chrome")
            echo "Đang cài đặt Google Chrome..."
            # Lệnh cài đặt Chrome ở đây
            ;;
        "Brave")
            echo "Đang cài đặt Brave..."
            # Lệnh cài đặt Firefox ở đây
            ;;
        "Microsoft Edge")
            echo "Đang cài đặt Microsoft Edge..."
            # Lệnh cài đặt Edge ở đây
            ;;
        "Cốc Cốc")
            echo "Đang cài đặt Cốc Cốc..."
            #
            ;;
        
        "Thoát")
            break
            ;;
        *) echo "Lựa chọn không hợp lệ!";;
    esac
done
