import Xmobar

peach, rosewater, flamingo, pink, mauve, red :: String
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

runBattery :: Runnable
runBattery =
  Run $
    Battery
      [ "--template",
        "<acstatus>",
        "--Low",
        "10", -- units: %
        "--High",
        "80", -- units: %
        "--low",
        red,
        "--normal",
        peach,
        "--high",
        teal,
        "--", -- battery specific options
        -- discharging status
        "-o",
        "<left>% (<timeleft>)",
        -- AC "on" status
        "-O",
        "Charging",
        -- charged status
        "-i",
        "Charged"
      ]
      50

runDate :: Runnable
runDate = Run $ Date "%D %a %T" "date" 10

config :: Config
config =
  defaultConfig
    { font = "FiraCode Nerd Font SemiBold 10",
      alpha = 255,
      bgColor = base,
      fgColor = maroon,
      alignSep = "}{",
      commands = [Run XMonadLog, runDate, runBattery],
      template = "%XMonadLog%}{ %date% | %battery%"
    }

main :: IO ()
main = xmobar config
