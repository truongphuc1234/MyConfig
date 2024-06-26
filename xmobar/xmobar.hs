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
        green,
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

runMemory :: Runnable
runMemory =
  Run $
    Memory
      [ "-t",
        "<usedratio>"
      ]
      10

runWeather :: Runnable
runWeather =
  Run $
    Weather
      "VVDN"
      [ "-t",
        "VVDN: <tempC>°C",
        "-L",
        "20",
        "-H",
        "35",
        "--normal",
        yellow,
        "--high",
        red,
        "--low",
        blue
      ]
      36000

runNetwork :: Runnable
runNetwork = Run $ Wireless "wlp1s0" ["-t", "<essid> <quality>"] 10

runAlsa :: Runnable
runAlsa = Run $ Alsa "default" "Master" []


config :: Config
config =
  defaultConfig
    { font = "Iosevka Bold 10",
      alpha = 255,
      bgColor = base,
      fgColor = teal,
      sepChar = "%",
      alignSep = "}{",
      commands = [Run (XPropertyLog "_XMONAD_LOG_1"), runDate, runBattery, runMemory, runWeather, runNetwork, runAlsa ],
      template = "%_XMONAD_LOG_1%}{ %alsa:default:Master% . %wlp1s0wi% . %memory% . %VVDN% . %date% . %battery%"
    }

main :: IO ()
main = xmobar config
