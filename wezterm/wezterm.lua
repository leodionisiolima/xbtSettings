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
    cursor_fg = "#000000",
    cursor_bg = "#FFFFFF",
    foreground = "#FFFFFF",
    background = "#000000",

    brights = {
      "#555555",
      "#FF5555",
      "#55FF55",
      "#FFFF55",
      "#5555FF",
      "#FF55FF",
      "#55FFFF",
      "#FFFFFF",
    },

    ansi = {
      "#000000",
      "#AA0000",
      "#00AA00",
      "#AA5500",
      "#0000AA",
      "#AA00AA",
      "#00AAAA",
      "#AAAAAA",
    },

  },

  -- ⌨️ Atalhos de teclado
  keys = {
    {
      key = '"',
      mods = "CTRL|SHIFT",
      action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
    {
      key = "%",
      mods = "CTRL|SHIFT",
      action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    },
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
