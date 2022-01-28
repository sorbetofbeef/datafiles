#!/usr/bin/lua
local options = {
    ["  qutebrowser"] = "qutebrowser",
    ["  Firefox"] = "firefox",
    ["  Font Manager"] = "font-manager",

    ["  Spotify TUI"] = "start-spotify",
    ["  Files"] = "kitty -1 lf",
    ["  HTop"] = "kitty -1 htop",
    ["  Kitty"] = "kitty -1 --title='Kitty'",
    ["  Neomutt"] = "kitty -1 neomutt",
    ["  Music"] = "kitty -1 --working-directory '/home/me/media/mix' ncmpcpp",
    ["  Video"] = "kitty -1 --working-directory '/home/me/media/vids' mpv",

    ["  Neovim IDE"] = "kitty -1 --working-directory '/home/me/projects' nvim"
                        .. " -c ':NvimTreeOpen'",
    ["  Configuration"] = "kitty -1 --working-directory '/home/me/.config' nvim"
                           .. " -c ':NvimTreeOpen'",
    ["  Data Files"] = "kitty -1 --working-directory '/home/me/.local' nvim"
                        .. " -c ':NvimTreeOpen'",

    ["  Super HTop"] = "kitty -1 doas htop",
    ["  System Files"] = "kitty -1 doas lf",
    ["  Super Configuration"] = "kitty -1 --working-directory '/usr' doas nvim --cmd ':cd /etc' -c ':Lexplore'",
    ["  Super Data Files"] = "kitty -1 --working-directory '/etc' doas nvim --cmd ':cd /usr' -c ':Lexplore'",
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
            .. "--dmenu --insensitive --prompt 'dmenu' --style ~/.config/wofi/style.css",
        "r"
    )
)
local s = assert(f:read("*a"))
s = string.gsub(s, "^%s+", "")
s = string.gsub(s, "%s+$", "")
s = string.gsub(s, "[\n]+", " ")
f:close()

os.execute(options[s])
