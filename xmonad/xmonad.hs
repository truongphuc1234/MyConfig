import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.StatusBar (defToggleStrutsKey, statusBarProp, withEasySB)
import XMonad.Layout.Decoration (ModifiedLayout)
import XMonad.Layout.Magnifier (Magnifier, magnifiercz')
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.ThreeColumns
import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce (spawnOnce)

main :: IO ()
main =
    xmonad
        . ewmhFullscreen
        . ewmh
        . xmobarProp
        . withEasySB (statusBarProp "my-xmobar" (pure customXmobarPP)) defToggleStrutsKey
        $ def
            { modMask = mod4Mask
            , terminal = "alacritty"
            , layoutHook = customLayout
            , normalBorderColor = lavender
            , focusedBorderColor = peach
            , borderWidth = 2
            , startupHook = customStartupHooks
            , focusFollowsMouse = False
            }
            `additionalKeysP` [ ("M-S-z", spawn "xscreensaver-command -lock")
                              , ("M-S-s", unGrab *> spawn "scrot -s")
                              , ("M-f", spawn "firefox")
                              ]

customLayout :: ModifiedLayout Spacing (Choose Tall (Choose (Mirror Tall) (Choose Full (Choose (ModifiedLayout Magnifier ThreeCol) SpiralWithDir)))) a
customLayout = smartSpacing 4 $ tiled ||| Mirror tiled ||| Full ||| threeCol ||| spr
  where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 1 / 2
    delta = 3 / 100
    spr = spiral (6 / 7)

customXmobarPP :: PP
customXmobarPP =
    def
        { ppSep = "."
        , ppTitleSanitize = xmobarColor mauve "" . xmobarStrip
        , ppHidden = xmobarColor mauve "" . wrap " " ""
        , ppCurrent = wrap " " "" . xmobarBorder "Top" teal 2
        , ppHiddenNoWindows = xmobarColor sky "" . wrap " " ""
        , ppUrgent = xmobarColor red "" . wrap (xmobarColor yellow "" "!") (xmobarColor yellow "" "!")
        , ppExtras = [logTitles formatFocused formatUnFocused]
        }
  where
    formatFocused = wrap (xmobarColor green "" "[") (xmobarColor green "" "]") . xmobarColor sapphire "" . ppWindow
    formatUnFocused = wrap (xmobarColor teal "" "[") (xmobarColor teal "" "]") . xmobarColor blue "" . ppWindow
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

customStartupHooks :: X ()
customStartupHooks = do
    spawnOnce "xsetroot -cursor_name left_ptr"
    spawnOnce "feh --bg-fill -no-fehbg ~/Pictures/shaded_landscape.png"
    spawnOnce "xrandr --output eDP-1 --off"
    spawnOnce "trayer --edge top --align right --SetDockerType true --SetPartialStrut true --expand true --width 10 --transparent true --tint 0x5f5f5f --height 18"

sapphire, lavender, blue, green, teal, sky, mauve, red, maroon, yellow, peach, rosewater :: String
rosewater = "#f2d5cf"
peach = "#ef9f76"

flamingo = "#eebebe"

pink = "#f4b8e4"

mauve = "#ca9ee6"

red = "#e78284"

maroon = "#ea999c"

yellow = "#e5c890"

green = "#a6d189"

teal = "#81c8be"

sky = "#99d1db"

sapphire = "#85c1dc"

blue = "#8caaee"

lavender = "#babbf1"

text = "#c6d0f5"

subtext1 = "#b5bfe2"

subtext0 = "#a5adce"

overlay2 = "#949cbb"

overlay1 = "#838ba7"

overlay0 = "#737994"

surface2 = "#626880"

surface1 = "51576d"

surface0 = "#414559"

base = "#303446"

mantle = "#292c3c"

crust = "#232634"
