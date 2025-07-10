import XMonad
import qualified XMonad.StackSet as W

import System.IO
import Control.Monad
import Graphics.X11.ExtraTypes.XF86

import XMonad.Util.SpawnOnce
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys, additionalMouseBindings)

import XMonad.Layout.Gaps
import XMonad.Layout.CircleEx
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimplestFloat
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.ToggleLayouts (toggleLayouts, ToggleLayout(Toggle))
import XMonad.Layout.ResizableTile (MirrorResize(..))
import XMonad.Layout.Grid
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.TwoPane
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Accordion
import XMonad.Layout.Tabbed
import XMonad.Layout.Spiral
import XMonad.Layout.Dwindle
import XMonad.Layout.Cross
import XMonad.Layout.FixedColumn
import XMonad.Layout.Named
import XMonad.Layout.Decoration
import XMonad.Layout.DecorationMadness
import XMonad.Layout.ImageButtonDecoration
import XMonad.Layout.MouseResizableTile
import XMonad.Layout.PerWorkspace
import XMonad.Layout.IndependentScreens
import XMonad.Layout.Reflect
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks (manageDocks, avoidStruts)
import XMonad.Hooks.EwmhDesktops
import XMonad.Actions.WithAll
import XMonad.Actions.GridSelect
import qualified XMonad.Actions.ConstrainedResize as Sqr
-- WORKSPACES   [0-5]
myWorkspaces :: [String]
myWorkspaces    = [
                      "ONE"         -- index 0
                    , "TWO"         -- index 1
                    , "THREE"       -- index 2
                    , "FOUR"        -- index 3
                    , "FIVE"        -- index 4
                    , "SIX"         -- index 5
                    ]


-- UTILITY FUNCTIONS
float :: Window -> X ()
float w = windows $ W.float w (W.RationalRect (1/3) (1/4) (1/3) (1/2))

-- TAB CONFIGURATION
myTabConfig = def
    { activeColor         = "#24283B"
    , inactiveColor       = "#292d37"
    , urgentColor         = "#5294E2"
    , activeBorderColor   = "#24283B"
    , inactiveBorderColor = "#272727"
    , urgentBorderColor   = "#5294E2"
    , activeTextColor     = "#ABB2BF"
    , inactiveTextColor   = "#5a6477"
    , urgentTextColor     = "#24283B"
    , fontName            = "xft:Vanilla Caramel:size=10"
    }

-- WINDOW DECORATION THEME
myDecoTheme = def
    { activeColor         = "#5294E2"
    , inactiveColor       = "#292d37"
    , urgentColor         = "#E06B74"
    , activeBorderColor   = "#5294E2"
    , inactiveBorderColor = "#272727"
    , urgentBorderColor   = "#E06B74"
    , activeTextColor     = "#24283B"
    , inactiveTextColor   = "#ABB2BF"
    , urgentTextColor     = "#24283B"
    , fontName            = "xft:Vanilla Caramel:bold:size=9"
    , decoHeight          = 24
    , decoWidth           = 200
    }

-- GRID SELECTOR COLOURS
greyColorizer = colorRangeFromClassName
    black            -- lowest inactive bg
    black            -- highest inactive bg
    white            -- active bg
    white            -- inactive fg
    black            -- active fg
  where white = maxBound
        black = minBound

-- GRIG CONFIG
gridConfig colorizer    = (buildDefaultGSConfig greyColorizer)
    { gs_cellheight     = 65
    , gs_cellwidth      = 150
    , gs_cellpadding    = 20
    , gs_font           = "xft:Exo 2:size=8"
    }

-- SMART PER-WORKSPACE LAYOUTS
myLayout = onWorkspace "ONE" devLayouts $
           onWorkspace "TWO" webLayouts $
           onWorkspace "THREE" commLayouts $
           onWorkspace "FOUR" mediaLayouts $
           defaultLayouts
  where
    -- Workspace-specific layouts
    devLayouts = gaps [(U, 24), (R, 1), (L, 1), (D, 1)] (avoidStruts $ smartBorders $ spacing 5 $
        named "🔧 Dev-ThreeCol" threeCol |||
        named "🔧 Dev-TwoPane" twoPane |||
        named "🔧 Dev-Grid" grid |||
        named "🔧 Dev-Tabbed" tabbed)
        
    webLayouts = gaps [(U, 24), (R, 1), (L, 1), (D, 1)] (avoidStruts $ smartBorders $ spacing 2 $
        named "🌐 Web-Full" full |||
        named "🌐 Web-Tall" resizable |||
        named "🌐 Web-TwoPane" twoPane)
        
    commLayouts = gaps [(U, 24), (R, 1), (L, 1), (D, 1)] (avoidStruts $ smartBorders $ spacing 3 $
        named "💬 Chat-Grid" grid |||
        named "💬 Chat-Accordion" accordion |||
        named "💬 Chat-Float" float)
        
    mediaLayouts = gaps [(U, 24), (R, 1), (L, 1), (D, 1)] (avoidStruts $ smartBorders $ spacing 8 $
        named "🎵 Media-Full" full |||
        named "🎵 Media-Float" float |||
        named "🎵 Media-Circle" circleEx)
        
    defaultLayouts = gaps [(U, 24), (R, 1), (L, 1), (D, 1)] (avoidStruts $ smartBorders $ spacing 5 $
        named "📐 ResizableTall" resizable ||| 
        named "🔲 ThreeCol" threeCol ||| 
        named "⚌ TwoPane" twoPane ||| 
        named "⊞ Grid" grid ||| 
        named "🌀 Spiral" spiral ||| 
        named "🌿 Dwindle" dwindle ||| 
        named "📋 Accordion" accordion ||| 
        named "📑 Tabbed" tabbed ||| 
        named "✚ Cross" cross ||| 
        named "📏 FixedColumn" fixedCol ||| 
        named "⭕ Circle" circleEx ||| 
        named "🎈 Float" float) ||| 
        named "🖥️ Full" full

    -- Basic layouts
    resizable   = ResizableTall 1 (2/100) (1/2) []
    full        = noBorders (fullscreenFull Full)
    float       = simplestFloat
    circleEx    = circle
    
    -- Developer-focused layouts
    threeCol    = ThreeCol 1 (3/100) (1/3)           -- 3-column: editor, terminal, browser
    twoPane     = TwoPane (3/100) (1/2)               -- Simple 2-pane split
    grid        = Grid                                 -- Auto grid layout
    spiral      = spiral (6/7)                        -- Spiral layout
    dwindle     = Dwindle R CW 1.1 1.1                -- Fibonacci-like dwindle
    accordion   = Accordion                           -- Stack windows like accordion
    tabbed      = tabbedBottom shrinkText myTabConfig -- Tabbed interface
    cross       = simpleCross                         -- Cross layout
    fixedCol    = FixedColumn 1 20 80 10              -- Fixed column for terminals

-- KEYBINGS
myKeys = [

  -- TERMINAL & APPLICATIONS
    ((mod4Mask, xK_Return), spawn "kitty")
    , ((mod4Mask .|. shiftMask, xK_Return), spawn "kitty --class floating")
    , ((mod4Mask, xK_w), spawn "brave")
    , ((mod4Mask, xK_f), spawn "kitty -e ranger")
    , ((mod4Mask, xK_t), spawn "telegram-desktop")
    , ((mod4Mask, xK_d), spawn "~/.config/rofi/scripts/rofi-main.sh")
    , ((mod4Mask, xK_n), spawn "kitty -e nvim")
    , ((mod4Mask, xK_g), spawn "kitty -e lazygit")
    , ((mod4Mask .|. shiftMask, xK_f), spawn "thunar")

  -- DEVELOPER TOOLS
    , ((mod4Mask, xK_grave), spawn "kitty --class dropdown")
    , ((mod4Mask .|. shiftMask, xK_c), spawn "kitty -e htop")
    , ((mod4Mask .|. shiftMask, xK_g), spawn "gitui")
    , ((mod4Mask .|. shiftMask, xK_d), spawn "kitty -e lazydocker")
    , ((mod4Mask .|. controlMask, xK_t), spawn "kitty -e btop")

  -- SCREENSHOTS
    , ((0, xK_Print), spawn "scrot -s ~/Screenshots/%Y-%m-%d_%H-%M-%S.png")
    , ((mod4Mask, xK_Print), spawn "scrot ~/Screenshots/%Y-%m-%d_%H-%M-%S.png")
    , ((mod4Mask .|. shiftMask, xK_s), spawn "scrot -s ~/Screenshots/%Y-%m-%d_%H-%M-%S.png")

  -- WINDOW MANAGEMENT
    , ((mod4Mask, xK_q), kill)
    , ((mod4Mask .|. shiftMask, xK_q), killAll)
    , ((mod4Mask, xK_space), sendMessage NextLayout)
    , ((mod4Mask .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)
    , ((mod4Mask, xK_Tab), windows W.focusDown)
    , ((mod4Mask .|. shiftMask, xK_Tab), windows W.focusUp)
    , ((mod4Mask, xK_j), windows W.focusDown)
    , ((mod4Mask, xK_k), windows W.focusUp)
    , ((mod4Mask .|. shiftMask, xK_j), windows W.swapDown)
    , ((mod4Mask .|. shiftMask, xK_k), windows W.swapUp)
    , ((mod4Mask, xK_m), windows W.focusMaster)
    , ((mod4Mask .|. shiftMask, xK_m), windows W.swapMaster)
    , ((mod4Mask .|. button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))

  -- LAYOUTS & RESIZING
    , ((mod4Mask, xK_h), sendMessage Shrink)
    , ((mod4Mask, xK_l), sendMessage Expand)
    , ((mod4Mask .|. shiftMask, xK_h), sendMessage MirrorShrink)
    , ((mod4Mask .|. shiftMask, xK_l), sendMessage MirrorExpand)
    , ((mod4Mask, xK_comma), sendMessage (IncMasterN 1))
    , ((mod4Mask, xK_period), sendMessage (IncMasterN (-1)))
    , ((mod4Mask .|. controlMask, xK_space), sendMessage ToggleLayout)

  -- FLOATING WINDOWS
    , ((mod4Mask, xK_s), withFocused $ windows . W.sink)
    , ((mod4Mask .|. shiftMask, xK_space), withFocused float)

  -- GRID SELECT
    , ((mod4Mask, xK_g), goToSelected $ gridConfig greyColorizer)
    , ((mod4Mask .|. shiftMask, xK_g), bringSelected $ gridConfig greyColorizer)

  -- MOVING FLOATING WINDOWS
    , ((mod4Mask, xK_Up), sendMessage (MoveUp 10))
    , ((mod4Mask, xK_Down), sendMessage (MoveDown 10))
    , ((mod4Mask, xK_Left), sendMessage (MoveLeft 10))
    , ((mod4Mask, xK_Right), sendMessage (MoveRight 10))

  -- INCREASE THE SIZE OF A FLOATING WINDOW
    , ((mod4Mask .|. shiftMask, xK_Up), sendMessage (IncreaseUp 10))
    , ((mod4Mask .|. shiftMask, xK_Down), sendMessage (IncreaseDown 10))
    , ((mod4Mask .|. shiftMask, xK_Left), sendMessage (IncreaseLeft 10))
    , ((mod4Mask .|. shiftMask, xK_Right), sendMessage (IncreaseRight 10))

  -- DECREASE THE SIZE OF A FLOATING WINDOW
    , ((mod4Mask .|. controlMask, xK_Up), sendMessage (DecreaseUp 10))
    , ((mod4Mask .|. controlMask, xK_Down), sendMessage (DecreaseDown 10))
    , ((mod4Mask .|. controlMask, xK_Left), sendMessage (DecreaseLeft 10))
    , ((mod4Mask .|. controlMask, xK_Right), sendMessage (DecreaseRight 10))

  -- SYSTEM CONTROLS
    , ((mod4Mask .|. shiftMask, xK_l), spawn "i3lock -c 000000")
    , ((mod4Mask .|. shiftMask, xK_r), spawn "xmonad --restart")
    , ((mod4Mask .|. controlMask, xK_r), spawn "xmonad --recompile && xmonad --restart")

  -- VOLUME CONTROL
    , ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
    , ((mod4Mask, xK_F1), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ((mod4Mask, xK_F2), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ((mod4Mask, xK_F3), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")

  -- BRIGHTNESS CONTROL
    , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight -inc 5")
    , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 5")
    , ((mod4Mask, xK_F5), spawn "xbacklight -dec 5")
    , ((mod4Mask, xK_F6), spawn "xbacklight -inc 5")

  -- MEDIA CONTROLS
    , ((0, xF86XK_AudioPlay), spawn "playerctl play-pause")
    , ((0, xF86XK_AudioNext), spawn "playerctl next")
    , ((0, xF86XK_AudioPrev), spawn "playerctl previous")
    , ((mod4Mask, xK_F7), spawn "playerctl previous")
    , ((mod4Mask, xK_F8), spawn "playerctl play-pause")
    , ((mod4Mask, xK_F9), spawn "playerctl next")

  -- CONFIGURATION & DEVELOPMENT
    , ((mod4Mask, xK_e), spawn "code ~/.xmonad/xmonad.hs")
    , ((mod4Mask .|. shiftMask, xK_e), spawn "kitty -e nvim ~/.xmonad/xmonad.hs")
    , ((mod4Mask .|. controlMask, xK_e), spawn "kitty -e nvim  ~/.config")

  -- QUICK ACTIONS
    , ((mod4Mask, xK_p), spawn "rofi -show drun")
    , ((mod4Mask .|. shiftMask, xK_p), spawn "rofi -show run")
    , ((mod4Mask, xK_o), spawn "rofi -show window")
    , ((mod4Mask, xK_x), spawn "rofi -show ssh")
    , ((mod4Mask, xK_z), spawn "~/.xmonad/layout-selector-improved.sh")
    , ((mod4Mask .|. shiftMask, xK_z), spawn "~/.xmonad/show-current-layout.sh")
    , ((mod4Mask, xK_grave), spawn "~/.xmonad/workspace-preview.sh")
    , ((mod4Mask .|. shiftMask, xK_grave), spawn "rofi -show windowcd")
    , ((mod4Mask .|. controlMask, xK_d), spawn "killall picom || picom --config ~/.config/picom/picom.conf")
    , ((mod4Mask, xK_i), spawn "~/.xmonad/system-info.sh")
    , ((mod4Mask .|. shiftMask, xK_c), spawn "~/.config/bspwm/themes/onedark/polybar/scripts/calendar-enhanced.sh show")

  -- GAPS CONTROL
    , ((mod4Mask .|. controlMask, xK_g), sendMessage $ ToggleGaps)
    , ((mod4Mask .|. controlMask, xK_plus), sendMessage $ IncGap 1 L)
    , ((mod4Mask .|. controlMask, xK_minus), sendMessage $ DecGap 1 L)]

-- MOUSE RESIZE AND MOVE
myMouseKeys = [ ((mod4Mask .|. shiftMask, button3), \w -> focus w >> Sqr.mouseResizeWindow w True) ]

-- APP RULES
myApps = composeAll
  [ className =? "Chromium"        --> doShift (myWorkspaces !! 1)
  , className =? "TelegramDesktop" --> doShift (myWorkspaces !! 2)
  , className =? "Discord"         --> doFloat <+> doShift (myWorkspaces !! 3)
  , className =? "Anki"            --> doShift (myWorkspaces !! 4)
  , className =? "Calculator"      --> doFloat
  , className =? "Sxiv"            --> doFloat
  , className =? "MPlayer"         --> doFloat
  , className =? "mpv"             --> doFloat
  , className =? "zathura"         --> doShift (myWorkspaces !! 4)
  , className =? "wezterm"         --> doFloat
  , className =? "dropdown"        --> doFloat
  , className =? "floating"        --> doFloat
  ]

-- AUTOSTART
myStartupHook :: X()
myStartupHook = do
    -- X11 settings
    spawn "xset s off"
    spawn "xset -dpms"
    spawn "xset r rate 484 69"
    spawn "xsetroot -def"
    
    -- Keyboard and input
    spawn "setxkbmap -option caps:escape -layout us"
    spawn "xrdb -load ~/.Xresources"
    spawn "xsetroot -cursor_name left_ptr"
    
    -- Applications
    spawn "parcellite"
    spawn "pkill redshift && redshift -l 0.01:-99.0 -g 0.8 -t 5200:5200 -r randr"
    spawn "killall picom; picom --config ~/.config/picom/picom.conf"
    
    -- Display and wallpaper
    spawn "xrandr --output DP-0 --mode 1920x1080 --rate 165.00"
    spawn "nitrogen --set-zoom-fill github/workspaces/tmp/Configs/Wallpapers/RosePine/astronaut_fields.jpg"
    
    -- Polybar
    spawn myPolybar
    spawn "sleep 3 && ~/.xmonad/polybar-updater.sh"
    
    -- Notification
    spawn "notify-send 'Notification' 'XMonad Loaded'"

-- STATUS BAR
myPolybar = "~/.config/bspwm/themes/onedark/polybar/launch.sh"

-- CONFIG
main = do
    xmonad $ ewmh def
        { manageHook = myApps <+> manageDocks <+> manageHook def
        , layoutHook = myLayout
        , modMask = mod4Mask
        , borderWidth = 2
        , normalBorderColor = "#272727"
        , focusedBorderColor = "#24283b"
        , workspaces = myWorkspaces
        , startupHook = myStartupHook
        , handleEventHook = ewmhDesktopsEventHook
            } `additionalKeys` myKeys
              `additionalMouseBindings` myMouseKeys

