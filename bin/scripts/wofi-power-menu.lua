#!/usr/bin/lua
local options = {
    [" Lock"] = "swaylock",
    [" Shut down"] = "systemctl poweroff",
    [" Reboot"] = "systemctl reboot",
    ["﫼 Log out"] = "riverctl exit",
    ["鈴 Suspend"] = "systemctl suspend",
    [" Hibernate"] = "systemctl hibernate",
}

local options_string = ""
local length = 0
for key, _ in pairs(options) do
    options_string = options_string .. key .. "\n"
    length = length + 1
end
options_string = options_string:sub(1, -2)

local f = assert(
    io.popen(
        "echo -e '"
            .. options_string
            .. "' | wofi "
            .. "--dmenu --insensitive --prompt 'Power menu' --width 300 --style ~/.config/wofi/powermenu.css --lines "
            .. length,
        "r"
    )
)
local s = assert(f:read("*a"))
s = string.gsub(s, "^%s+", "")
s = string.gsub(s, "%s+$", "")
s = string.gsub(s, "[\n]+", " ")
f:close()

os.execute(options[s])
