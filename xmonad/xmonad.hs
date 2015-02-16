import XMonad

main = xmonad $ defaultConfig
  { borderWidth        = 2
  , terminal           = "xterm"
  , normalBorderColor  = "#cccccc"
  , focusedBorderColor = "#cd8b00" }
