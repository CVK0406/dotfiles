#!/usr/bin/env python3
import os, subprocess, sys

THEME_PATH = os.path.expanduser("~/.config/rofi/cheatsheet.rasi")

# Complete, Categorized Keybind List from variables.lua
BIND_GROUPS = [
    (
        "🚀 ỨNG DỤNG (APPLICATIONS)",
        [
            ("Super", "󰍉", "Mở Caelestia App Launcher"),
            ("Super + T", "󰆍", "Mở Terminal (Foot)"),
            ("Super + W", "󰈹", "Mở Trình duyệt (Zen Browser)"),
            ("Super + C", "󰅩", "Mở Code Editor (Antigravity IDE)"),
            ("Super + E", "󰉋", "Mở Quản lý File (Yazi)"),
            ("Ctrl + Alt + V", "󰕾", "Cấu hình Âm thanh (Pavucontrol)"),
        ],
    ),
    (
        "🪟 QUẢN LÝ CỬA SỔ (WINDOW MANAGEMENT)",
        [
            ("Super + Q", "󰅖", "Đóng cửa sổ đang chọn (Close Window)"),
            ("Super + F", "󰊓", "Bật / Tắt Toàn màn hình (Fullscreen)"),
            ("Super + Alt + F", "󰊓", "Toàn màn hình có viền (Bordered Fullscreen)"),
            ("Super + Alt + Space", "󱂬", "Bật / Tắt Cửa sổ nổi (Floating)"),
            ("Super + P", "󰤱", "Ghim cửa sổ trên cùng (Pin Window)"),
            ("Ctrl + Super + \\", "󰉨", "Căn giữa cửa sổ (Center Window)"),
            ("Ctrl + Super + Alt + \\", "󰁌", "Khôi phục kích thước chuẩn (Normalize Window)"),
            ("Super + Alt + \\", "󰖔", "Chế độ xem video (Picture in Picture)"),
            ("Super + Z", "󰆾", "Di chuyển cửa sổ (Giữ & Kéo chuột trái)"),
            ("Super + X", "󰆿", "Thay đổi kích thước cửa sổ (Giữ & Kéo chuột phải)"),
            ("Super + ← / → / ↑ / ↓", "󰁍", "Di chuyển tiêu điểm cửa sổ (Focus Direction)"),
            ("Super + Shift + ← / → / ↑ / ↓", "󰜳", "Di chuyển cửa sổ theo hướng"),
            ("Super + Minus / Equal", "󰤄", "Tăng / Giảm chiều rộng cửa sổ"),
            ("Super + Shift + Minus / Equal", "󰤅", "Tăng / Giảm chiều cao cửa sổ"),
            ("Alt + Tab", "󰕰", "Chuyển sang cửa sổ tiếp theo"),
            ("Shift + Alt + Tab", "󰕱", "Chuyển sang cửa sổ phía trước"),
            ("Super + ,", "󰕮", "Bật / Tắt Nhóm cửa sổ (Toggle Group)"),
            ("Super + U", "󰕮", "Hủy nhóm cửa sổ (Ungroup)"),
        ],
    ),
    (
        "󱂬 WORKSPACES (MÀN HÌNH LÀM VIỆC)",
        [
            ("Super + 1 .. 9", "󰓩", "Chuyển đến Workspace 1 đến 9"),
            ("Super + Alt + 1 .. 9", "󰪹", "Di chuyển cửa sổ sang Workspace 1 đến 9"),
            ("Ctrl + Super + 1 .. 9", "󰓪", "Chuyển Nhóm Workspace (Workspace Group)"),
            ("Ctrl + Super + Alt + 1 .. 9", "󰪺", "Di chuyển cửa sổ sang Nhóm Workspace"),
            ("Super + Cuộn chuột", "󰛔", "Chuyển Workspace Kế tiếp / Trước đó"),
            ("Super + S", "󱂬", "Bật / Tắt Workspace phụ (Scratchpad)"),
            ("Super + Alt + S", "󰪹", "Đưa cửa sổ hiện tại vào Scratchpad"),
            ("Ctrl + Shift + Esc", "󰢮", "Mở Workspace System Monitor (Btop)"),
            ("Super + M", "󰓇", "Mở Workspace Âm nhạc (Music)"),
            ("Super + D", "󰭹", "Mở Workspace Trao đổi (Discord/Chat)"),
            ("Super + R", "󰄲", "Mở Workspace Công việc (Todo)"),
        ],
    ),
    (
        "📸 CHỤP ẢNH & QUAY MÀN HÌNH (MEDIA & CAPTURE)",
        [
            ("PrintScreen", "󰹑", "Chụp toàn bộ màn hình (Screenshot)"),
            ("Super + Shift + S", "󰹑", "Chụp đóng băng màn hình (Freeze Screenshot)"),
            ("Super + Shift + Alt + S", "󰹑", "Chụp vùng chọn màn hình (Region Screenshot)"),
            ("Ctrl + Alt + R", "󰑋", "Quay video màn hình (Screen Record)"),
            ("Super + Alt + R", "󰑋", "Quay video màn hình kèm âm thanh"),
            ("Super + Shift + Alt + R", "󰑋", "Quay video vùng chọn màn hình"),
            ("Super + Shift + C", "󰏟", "Lấy màu màn hình (Color Picker)"),
        ],
    ),
    (
        "📋 CLIPBOARD & EMOJI",
        [
            ("Super + V", "󰅍", "Mở Lịch sử Clipboard"),
            ("Super + Alt + V", "󰅍", "Xóa Lịch sử Clipboard"),
            ("Ctrl + Shift + ALT + V", "󰅍", "Dán Clipboard mới nhất"),
            ("Super + .", "󰞅", "Mở Bảng chọn Emoji"),
        ],
    ),
    (
        "🎵 ÂM THANH & MEDIA (AUDIO & MEDIA)",
        [
            ("Ctrl + Super + Space", "󰐎", "Phát / Dừng nhạc (Media Play/Pause)"),
            ("Ctrl + Super + Equal", "󰒭", "Bài hát kế tiếp (Next Track)"),
            ("Ctrl + Super + Minus", "󰒮", "Bài hát trước đó (Prev Track)"),
            ("Ctrl + Super + Backspace", "󰓛", "Dừng phát nhạc (Stop Media)"),
            ("Super + Shift + M", "󰝟", "Tắt tiếng (Mute Audio)"),
        ],
    ),
    (
        "⚙️ HỆ THỐNG & ĐIỀU KHIỂN (SYSTEM & CONTROL)",
        [
            ("Super", "󰍉", "Mở Caelestia App Launcher"),
            ("Super + N", "󰍡", "Bật / Tắt Sidebar Thông báo (Notifications)"),
            ("Ctrl + Alt + C", "󰎟", "Xóa tất cả thông báo"),
            ("Super + K", "󰕮", "Hiện / Ẩn tất cả Panel Caelestia"),
            ("Super + L", "󰌾", "Khóa màn hình (Lock Screen)"),
            ("Super + Alt + L", "󰌾", "Khôi phục màn hình khóa (Restore Lock)"),
            ("Super + Shift + L", "󰤄", "Chế độ ngủ (Sleep / Suspend)"),
            ("Ctrl + Alt + Delete", "󰐥", "Mở Menu Nguồn & Đăng xuất (Session)"),
            ("Ctrl + Super + Shift + R", "󰑐", "Khởi động lại Caelestia Shell"),
        ],
    ),
]

lines = []
for group_name, items in BIND_GROUPS:
    lines.append(f"─── {group_name} ───")
    for key, icon, desc in items:
        lines.append(f"  {key:<32} {icon}  {desc}")

formatted_menu = "\n".join(lines)

cmd = [
    "rofi",
    "-dmenu",
    "-i",
    "-p", "⌨️ Keybinds Cheatsheet",
    "-l", "18",
    "-theme", THEME_PATH
]

try:
    subprocess.run(cmd, input=formatted_menu, text=True)
except Exception:
    sys.exit(0)
