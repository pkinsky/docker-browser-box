import XMonad

main = xmonad $ defaultConfig
  { modMask            = mod4Mask 
  , borderWidth        = 2
  , terminal           = "xterm"
  , normalBorderColor  = "#cccccc"
  , focusedBorderColor = "#cd8b00" }
