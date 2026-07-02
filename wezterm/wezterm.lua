local wezterm = require 'wezterm'

wezterm.on("format-window-title", function(tab, pane)
  local ok, window_id = pcall(function() return tostring(pane.window_id) end)
  if not ok then return "wezterm" end

  -- Read label file every time (no caching)
  local f = io.open("/tmp/wezterm-label-win-" .. window_id, "r")
  if f then
    local label = f:read("*l")
    f:close()
    if label and label ~= "" then return label end
  end
  return "wezterm"
end)

-- CTRL+click on a file link opens it in Zed, not the OS default (mousepad).
-- Only file:// URIs are intercepted; http/https/etc fall through to the OS opener.
wezterm.on("open-uri", function(window, pane, uri)
  -- DEBUG: record every uri click so we can see exactly what wezterm passes
  local log = io.open("/tmp/wz-openuri.log", "a")
  if log then log:write(tostring(uri) .. "\n"); log:close() end

  -- match file:// URIs and bare absolute/home paths
  local file = uri:match("^file://[^/]*(/.*)$") or uri:match("^(/.*)$") or uri:match("^(~/.*)$")
  if file then
    file = file:gsub("#.*$", "")
    wezterm.background_child_process({ "/home/leo/.local/bin/zed", file })
    return false  -- prevent wezterm's default OS-open
  end
  -- not a file link: let wezterm handle it normally
end)

wezterm.on("window-close-requested", function(window, pane)
  window:perform_action(
    wezterm.action.CloseCurrentPane { confirm = true },
    pane
  )
end)

return {
  window_close_confirmation = "AlwaysPrompt",
  font = wezterm.font("Reddit Mono", { weight = "Regular" }),
  font_size = 9,
  adjust_window_size_when_changing_font_size = false,
  enable_tab_bar = true,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = false,
  tab_bar_at_bottom = false,
  tab_max_width = 25,
  window_decorations = "TITLE | RESIZE",

  window_frame = {
    font = wezterm.font("Reddit Mono", { weight = "Regular" }),
    font_size = 10,
  },

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

  -- +10% more opaque (0.52 -> 0.57): the general window/compositor transparency
  -- washes the terminal out more than intended, so bump opacity to darken it back.
  window_background_opacity = 0.57,

  default_cursor_style = "SteadyUnderline",
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",
  cursor_blink_rate = 0,
  cursor_thickness = 2.0,
  force_reverse_video_cursor = false,

  colors = {
    cursor_fg = "#000000",
    cursor_bg = "#FFFFFF",
    foreground = "#FFFFFF",
    background = "#000000",
    split = "#808080",

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

  selection_word_boundary = " \t\n{}[]()\"'`,;:│➜❯ ",

  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "NONE",
      action = wezterm.action.CompleteSelection("ClipboardAndPrimarySelection"),
    },
  },

  keys = {
    -- Pane split: CTRL+uhjk
    { key = "u", mods = "CTRL", action = wezterm.action.SplitPane { direction = "Up" } },
    { key = "h", mods = "CTRL", action = wezterm.action.SplitPane { direction = "Left" } },
    { key = "j", mods = "CTRL", action = wezterm.action.SplitPane { direction = "Down" } },
    { key = "k", mods = "CTRL", action = wezterm.action.SplitPane { direction = "Right" } },
    -- Pane focus: ALT+uhjk
    { key = "u", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "h", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
    { key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
    -- Splits normais (subdividem pane atual)
    -- {
    --   key = '"',
    --   mods = "CTRL|SHIFT",
    --   action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    -- },
    -- {
    --   key = "%",
    --   mods = "CTRL|SHIFT",
    --   action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    -- },
    -- Splits top-level (dividem tab inteira)
    -- {
    --   key = '"',
    --   mods = "CTRL|SHIFT|ALT",
    --   action = wezterm.action.SplitPane {
    --     direction = "Right",
    --     top_level = true,
    --   },
    -- },
    -- {
    --   key = "%",
    --   mods = "CTRL|SHIFT|ALT",
    --   action = wezterm.action.SplitPane {
    --     direction = "Down",
    --     top_level = true,
    --   },
    -- },
    {
      key = "w",
      mods = "CTRL|ALT",
      action = wezterm.action.CloseCurrentPane { confirm = false },
    },
    {
      key = "F4",
      mods = "ALT",
      action = wezterm.action.CloseCurrentTab { confirm = true },
    },
    {
      key = "Enter",
      mods = "ALT",
      action = wezterm.action.DisableDefaultAssignment,
    },
    {
      key = "w",
      mods = "CTRL",
      action = wezterm.action.SendKey { key = 'w', mods = 'CTRL' },
    },
    {
      key = "f",
      mods = "CTRL",
      action = wezterm.action.TogglePaneZoomState,
    },
    {
      key = "f",
      mods = "CTRL|SHIFT",
      action = wezterm.action.TogglePaneZoomState,
    },
  },
}
