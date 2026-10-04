#!/usr/bin/env bash

# ==========================================================================
# Script: setup_ufw.sh
# Mô tả: Tự động hóa thiết lập cấu hình UFW an toàn cho máy chủ Ubuntu.
# ==========================================================================

set -euo pipefail

echo "[INFO] Đang khởi động tiến trình cấu hình UFW..."

# Đảm bảo ufw đã được cài đặt
if ! command -v ufw &> /dev/null; then
    echo "[WARN] UFW chưa được cài đặt. Tiến hành cài đặt..."
    sudo apt-get update && sudo apt-get install -y ufw
fi

# Reset UFW về mặc định ban đầu
echo "[INFO] Reset cấu hình UFW cũ..."
sudo ufw --force reset

# Áp dụng chính sách mặc định
echo "[INFO] Thiết lập chính sách mặc định: Deny Inbound, Allow Outbound..."
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Mở các cổng dịch vụ yêu cầu
echo "[INFO] Đang mở cổng 22/tcp cho SSH..."
sudo ufw allow 22/tcp comment 'Allow SSH traffic'

echo "[INFO] Đang mở cổng 80/tcp cho HTTP..."
sudo ufw allow 80/tcp comment 'Allow HTTP traffic'

# Kích hoạt UFW
echo "[INFO] Đang kích hoạt UFW..."
sudo ufw --force enable

# Hiển thị trạng thái sau cấu hình
echo "[SUCCESS] Cấu hình UFW hoàn tất! Chi tiết trạng thái bên dưới:"
sudo ufw status verbose
