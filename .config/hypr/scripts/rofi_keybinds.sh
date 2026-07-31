#!/usr/bin/env python3
import subprocess, sys

# Keybind Cheatsheet for CachyOS + Hyprland + Caelestia
BIND_GROUPS = [
    (
        "🚀 APPS & LAUNCHER",
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
        "🪟 WINDOW MANAGEMENT",
        [
            ("Super + Q", "󰅖", "Đóng cửa sổ (Close Window)"),
            ("Super + F", "󰊓", "Bật / Tắt Toàn màn hình (Fullscreen)"),
            ("Super + Alt + Space", "󱂬", "Bật / Tắt Cửa sổ nổi (Floating)"),
            ("Super + P", "󰤱", "Ghim cửa sổ (Pin Window)"),
            ("Super + Z", "󰆾", "Di chuyển cửa sổ (Giữ chuột trái kéo)"),
            ("Super + X", "󰆿", "Resize cửa sổ (Giữ chuột phải kéo)"),
            ("Super + ← / → / ↑ / ↓", "󰁍", "Di chuyển tiêu điểm cửa sổ (Focus Direction)"),
            ("Super + Shift + ← / → / ↑ / ↓", "󰜳", "Di chuyển cửa sổ theo hướng"),
            ("Alt + Tab", "󰕰", "Chuyển sang cửa sổ tiếp theo"),
            ("Shift + Alt + Tab", "󰕱", "Chuyển sang cửa sổ phía trước"),
        ],
    ),
    (
        "󱂬 WORKSPACES",
        [
            ("Super + 1 .. 9", "󰓩", "Chuyển đến Workspace 1 đến 9"),
            ("Super + Alt + 1 .. 9", "󰪹", "Di chuyển cửa sổ sang Workspace 1 đến 9"),
            ("Super + S", "󱂬", "Bật / Tắt Workspace phụ (Scratchpad)"),
            ("Super + M", "󰓇", "Workspace Âm nhạc (Music)"),
            ("Super + D", "󰭹", "Workspace Trao đổi (Discord/Chat)"),
            ("Super + R", "󰄲", "Workspace Công việc (Todo)"),
            ("Super + Cuộn chuột", "󰛔", "Chuyển Workspace Kế tiếp / Trước đó"),
        ],
    ),
    (
        "⚙️ SYSTEM & UTILITIES",
        [
            ("Super + L", "󰌾", "Khóa màn hình (Lock Screen)"),
            ("PrintScreen", "󰹑", "Chụp ảnh màn hình (Screenshot)"),
            ("Ctrl + Shift + Esc", "󰢮", "Mở System Monitor (Btop)"),
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

# Try rofi first, fallback to fuzzel if rofi is closed
try:
    subprocess.run(
        ["rofi", "-dmenu", "-i", "-p", "⌨️ Hyprland Keybinds Cheatsheet", "-l", "22"],
        input=formatted_menu,
        text=True,
    )
except FileNotFoundError:
    try:
        subprocess.run(
            ["fuzzel", "-d", "-p", "⌨️ Keybinds: "],
            input=formatted_menu,
            text=True,
        )
    except Exception:
        pass
