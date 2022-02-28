#!/usr/bin/lua

local gpg = "kitty --class passwords \"/usr/bin/gpg -d -q /home/me/.local/share/passwords/"

local options = {
    ["Outlook"] = gpg .. "outlook.pgp\"",
    -- [""] = "sudo reboot",
    -- ["Log out"] = "riverctl exit",
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
            .. "--dmenu --insensitive --prompt 'Passwords' --style ~/.config/wofi/style.css",
        "r"
    )
)
local s = assert(f:read("*a"))
s = string.gsub(s, "^%s+", "")
s = string.gsub(s, "%s+$", "")
s = string.gsub(s, "[\n]+", " ")
f:close()

os.execute(options[s])
