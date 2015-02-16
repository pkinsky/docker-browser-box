import XMonad
import XMonad.Util.EZConfig

myModMask = mod1Mask

myKeys = 
  [((myModMask, xK_p), spawn "urxvt")]

main = xmonad $ defaultConfig
  { modMask            = myModMask 
  , borderWidth        = 2
  , terminal           = "xterm"
  , normalBorderColor  = "#cccccc"
  , focusedBorderColor = "#cd8b00" } `additionalKeys` myKeys
