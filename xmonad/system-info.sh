#!/bin/bash

# System Information Display
# Shows beautiful system stats in rofi

get_system_info() {
    # CPU Info
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
    cpu_temp=$(sensors | grep "Package id 0:" | awk '{print $4}' | cut -d'+' -f2 | cut -d'°' -f1 2>/dev/null || echo "N/A")
    
    # Memory Info
    mem_info=$(free -h | awk 'NR==2{printf "%.1f/%.1f GB (%.0f%%)", $3/1024, $2/1024, $3*100/$2}')
    
    # Disk Info
    disk_info=$(df -h / | awk 'NR==2{printf "%s/%s (%s used)", $3, $2, $5}')
    
    # Uptime
    uptime_info=$(uptime -p | sed 's/up //')
    
    # Network
    network_info=$(ip route get 1.1.1.1 2>/dev/null | grep -oP 'dev \K\S+' | head -1)
    if [ -n "$network_info" ]; then
        network_speed=$(cat /sys/class/net/$network_info/speed 2>/dev/null || echo "Unknown")
        network_info="$network_info (${network_speed}Mb/s)"
    else
        network_info="Disconnected"
    fi
    
    # Battery (if available)
    battery_info=""
    if [ -d "/sys/class/power_supply/BAT0" ]; then
        battery_level=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
        battery_status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)
        battery_info="🔋 Battery: ${battery_level}% (${battery_status})"
    fi
    
    # Audio
    audio_info=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1)
    audio_mute=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -o 'yes\|no')
    
    # Current layout (simplified)
    current_layout="Unknown"
    
    echo "💻 CPU: ${cpu_usage}% @ ${cpu_temp}°C
🧠 Memory: ${mem_info}
💾 Disk: ${disk_info}
⏱️ Uptime: ${uptime_info}
🌐 Network: ${network_info}
$battery_info
🔊 Audio: ${audio_info} (${audio_mute})
🖥️ Layout: ${current_layout}
🎨 Theme: OneDark XMonad Setup"
}

# Rofi theme for system info
rofi_theme="
window {
    width: 60%;
    height: 50%;
    background-color: #24283B;
    border: 2px solid #5294E2;
    border-radius: 12px;
    padding: 20px;
}

listview {
    columns: 1;
    lines: 10;
    spacing: 8px;
    scrollbar: false;
    background-color: transparent;
}

element {
    padding: 10px 15px;
    border-radius: 6px;
    background-color: #292d37;
    text-color: #ABB2BF;
}

element-text {
    font: \"JetBrains Mono 10\";
    vertical-align: 0.5;
}

inputbar {
    children: [ prompt ];
    background-color: #5294E2;
    border-radius: 8px;
    padding: 15px 20px;
    margin: 0px 0px 20px 0px;
}

prompt {
    text-color: #24283B;
    font: \"Vanilla Caramel Bold 14\";
}
"

# Show system info
get_system_info | rofi -dmenu -p "📊 System Information" -theme-str "$rofi_theme" > /dev/null