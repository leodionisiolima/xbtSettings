local wezterm = require 'wezterm'

return {
  -- 🎨 Fonte e aparência
  font = wezterm.font("Reddit Mono", { weight = "Regular" }),
  font_size = 12,
  enable_tab_bar = false,
  
  -- 🧱 Padding da janela
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

  -- 🪟 Remove barra de título e borda superior
  window_decorations = "NONE",

  -- 🌫️ Opacidade do fundo
  window_background_opacity = 1.0,

  -- ➤ Cursor
  default_cursor_style = "SteadyUnderline",
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",
  cursor_blink_rate = 0,
  cursor_thickness = 2.0,
  force_reverse_video_cursor = false,

  -- 🌈 Cores personalizadas
  colors = {
    cursor_fg = "#000000", -- cor do texto sob o cursor
    cursor_bg = "#FFFFFF", -- cursor branco sólido
    foreground = "#FFFFFF",
    background = "#000000",

    brights = {
      "#555555", -- black
      "#FF5555", -- red
      "#55FF55", -- green
      "#FFFF55", -- yellow
      "#5555FF", -- blue
      "#FF55FF", -- magenta
      "#55FFFF", -- cyan
      "#FFFFFF", -- white
    },

    
    ansi = {
      "#000000", -- black
      "#AA0000", -- red
      "#00AA00", -- green
      "#AA5500", -- yellow
      "#0000AA", -- blue
      "#AA00AA", -- magenta
      "#00AAAA", -- cyan
      "#AAAAAA", -- white
    },

  },

  -- ⌨️ Atalhos de teclado
  keys = {
    -- Split vertical: Ctrl + |
    {
      key = '"',
      mods = "CTRL|SHIFT",
      action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },

    -- Split horizontal: Ctrl + Shift + %
    {
      key = "%",
      mods = "CTRL|SHIFT",
      action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    },

    -- Mover foco entre panes com Shift + setas
    {
      key = "LeftArrow",
      mods = "SHIFT",
      action = wezterm.action.ActivatePaneDirection("Left"),
    },
    {
      key = "RightArrow",
      mods = "SHIFT",
      action = wezterm.action.ActivatePaneDirection("Right"),
    },
    {
      key = "UpArrow",
      mods = "SHIFT",
      action = wezterm.action.ActivatePaneDirection("Up"),
    },
    {
      key = "DownArrow",
      mods = "SHIFT",
      action = wezterm.action.ActivatePaneDirection("Down"),
    },
    {
      key = "w",
      mods = "CTRL|ALT",
      action = wezterm.action.CloseCurrentPane { confirm = false },
    },
  },
}
